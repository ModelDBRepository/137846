// FILE IN USE 05/17/2005 -- present.
// Changes to previous version of 01/05:
//	1. HCN channels rebuilt based on Chan et al (2004), J Neurosci 24: 9921-32.	

//genesis
float  xmin = -0.2
float  xmax = 0.1
int	xdivs = 299 
float  dx = (xmax - xmin)/xdivs
float  x
int i

//==================================================================
// 	Tab channel descriptions for GP neuron modeling
// 	Created by J. Hanson
//	edited 10-02
//	Updated by J. Edgerton, 9/2003 --
//==================================================================



//==================================================================
//					  Fast Na channel
//	Activation and fast inactivation made to replicate resurgent
//		sodium current from Raman & Bean as closely as possible.
//	Slow inactivation gate added by J. Edgerton, 2004.
//	Support for voltage-dependent Z-gate by Cengiz Gunay, 2004
//==================================================================
function make_Na_fast_GP
	if ({exists Na_fast_GP})
			return
	end
	create  tabchannel Na_fast_GP
	setfield Na_fast_GP Ek {ENa} Gbar {G_Na_fast_GP} Ik 0 Gk 0\
		Xpower {mpower_NaF} Ypower {hpower_NaF} Zpower {spower_NaF}
		
//	Activation & Deactivation
	float Vhalfm 	= {Vhalfm_NaF}
	float Km 		= {Km_NaF}
	float taummax 	= {taummax_NaF} / {dq10_NaF_m}
	float taummin 	= {taummin_NaF}	/ {dq10_NaF_m}
	float Ktau1   	= {Ktaum1_NaF}
	float Ktau2		= {Ktaum2_NaF}
	float V0m, minf, taum
	V0m = {Vhalfm}		//the following is commented out bc Surmeier fitted with 3rd order Boltzmann:
				// + ({Km} * {log {(1 / {pow 0.5 {1/{mpower_NaF}}}) - 1}})
	echo "Na_fast V0m: " {V0m}
	call Na_fast_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
		//note taum is divided by 3 here to compensate for temperature used in Surmeier's experiments
		taum = (({taummin} + (({taummax} - {taummin}) / ({exp { ({V0taum_NaF} - x) / {Ktau1} } } + {exp {({V0taum_NaF} - x) / {Ktau2} }})))/3)
		//taum = {taummin} + (({taummax} - {taummin}) / ({exp { ({V0m} - x) / {Ktau1} } } + {exp {({V0m} - x) / {Ktau2} }}))
		//echo
		//echo taum {taum}
		//echo minf {minf}
		//echo
		setfield Na_fast_GP X_A->table[{i}] {taum}
		setfield Na_fast_GP X_B->table[{i}] {minf}
		x = x + dx
	end
	tweaktau Na_fast_GP X
	call Na_fast_GP TABFILL X 6000 0
	setfield Na_fast_GP X_A->calc_mode {NO_INTERP}
	setfield Na_fast_GP X_B->calc_mode {NO_INTERP}

//      Fast Inactivation
        float V0h               = {V0h_NaF}
        float V0tauh    = {V0tauh_NaF}
        float Kh                = {Kh_NaF}
        float tauhmax   = {tauhmax_NaF} / {dq10_NaF_h1}
        float tauhmin   = {tauhmin_NaF} / {dq10_NaF_h1}
        float Ktauh1    = {Ktauh1_NaF}
        float Ktauh2    = {Ktauh2_NaF}
        float hinf, tauh
        call Na_fast_GP TABCREATE Y {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                hinf = 1 / (1 + {exp {({V0h} - x) / {Kh} }})
                tauh = ({tauhmin} + (({tauhmax} - {tauhmin}) / ({exp { ({V0tauh} - x) / {Ktauh1} } } + {exp {({V0tauh} - x) / {Ktauh2} }})))
                setfield Na_fast_GP Y_A->table[{i}] {tauh}
                setfield Na_fast_GP Y_B->table[{i}] {hinf}
                x = x + dx
                end
        tweaktau Na_fast_GP Y
        call Na_fast_GP TABFILL Y 6000 0
        setfield Na_fast_GP Y_A->calc_mode {NO_INTERP}
        setfield Na_fast_GP Y_B->calc_mode {NO_INTERP}


//      Slow Inactivation
//      Equations & params from Spampanato et al, 2003, except that
//              tausmin added to prevent segmentation faults due to
//              excessively small time constants at voltage extremes.
        float V0s               = {V0s_NaF}
        float V0taus    = {V0s_NaF}
        float Ks                = {Ks_NaF}
        float mins              = {mins_NaF}
        float Ktaus1    = {Ktaus1_NaF}
        float Ktaus2    = {Ktaus2_NaF}
        float tausmax   = {tausmax_NaF} / {dq10_NaF_h2}
        float tausmin   = {tausmin_NaF} / {dq10_NaF_h2}
        float sinf, taus

        call Na_fast_GP TABCREATE Z {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                sinf = {mins} + ((1-{mins}) / (1 + {exp {({V0s} - x) / {Ks} }}))
                taus = tausmin + ({tausmax} - {tausmin}) / ({exp {({V0taus} - x) / {Ktaus1}}} + {exp {({V0taus} - x) / {Ktaus2}}})

                setfield Na_fast_GP Z_A->table[{i}] {taus}
                setfield Na_fast_GP Z_B->table[{i}] {sinf}
                x = x + dx
        end
        tweaktau Na_fast_GP Z
        call Na_fast_GP TABFILL Z 6000 0
        setfield Na_fast_GP Z_A->calc_mode {NO_INTERP}
        setfield Na_fast_GP Z_B->calc_mode {NO_INTERP}
        setfield Na_fast_GP Z_conc 0  // Z-gate voltage-dependent
end

//==================================================================
//					  persistent Na channel
//	Based on Magistretti & Alonso (1999), JGP 114:491-509
//		and Magistretti & Alonso (2002), JGP 120: 855-873.
//	Created by J.R. Edgerton, 03/2004
//	Modified 10/2004 by JRE: add z-gate slow inactivation, improve 
//		model's y-gate intermediate inactivation.
//==================================================================
function make_Na_slow_GP
	if ({exists Na_slow_GP})
		return
	end
	create  tabchannel Na_slow_GP
	setfield Na_slow_GP Ek {ENa} Gbar {G_Na_slow_GP} Ik 0 Gk 0 \
	Xpower {mpower_NaP} Ypower {hpower_NaP} Zpower {spower_NaP}
	
//	***	Activation & Deactivation (m-gate)
	float Km		= {Km_NaP}
	float Vhalfm   	= {Vhalfm_NaP}
	float V0taum 	= {V0taum_NaP}
	float taummax 	= {taummax_NaP} / {dq10_NaP}
	float taummin 	= {taummin_NaP} / {dq10_NaP}
	float Ktau1   	= {Ktaum1_NaP}
	float Ktau2   	= {Ktaum2_NaP}
	float minf, taum
	
// 1/(alpha+beta) REPLACED with matched equation of standard form, JRE 09/28/2005
//	float alp0	=	2130
//	float bet0 = 	2460

	float V0m = {Vhalfm} + ({Km} * {log {(1 / {pow 0.5 {1/{mpower_NaP}}}) - 1}})
	echo "Na_slow V0m: " {V0m}

	call Na_slow_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
		taum = {taummin} + (({taummax} - {taummin}) / ({exp { ({V0m} - x) / {Ktau1} } } + {exp {({V0m} - x) / {Ktau2} }}))
		setfield Na_slow_GP X_A->table[{i}] {taum}
		setfield Na_slow_GP X_B->table[{i}] {minf}
		x = x + dx
	end

	tweaktau Na_slow_GP X
	call Na_slow_GP TABFILL X 6000 0
	setfield Na_slow_GP X_A->calc_mode {NO_INTERP}
	setfield Na_slow_GP X_B->calc_mode {NO_INTERP}

//	***	Fast / Intermediate Inactivation (h-gate)
	float hmin	= {hmin_NaP}
	float V0h   = {V0h_NaP}
	float Kh   	= {Kh_NaP}
	float V0tauh = {V0tauh_NaP}
	float Ktauh1 = {Ktauh1_NaP}
	float Ktauh2 = {Ktauh2_NaP}
	float tauhmin = {tauhmin_NaP} / {dq10_NaP}
	float tauhmax = {tauhmax_NaP} / {dq10_NaP}

	float tauh, hinf
	call Na_slow_GP TABCREATE Y {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		
		hinf = {hmin} + ((1 - {hmin}) / (1 + {exp {({V0h} - x) / {Kh} }}))
		tauh = ({tauhmin} + (({tauhmax} - {tauhmin}) / ({exp {({V0tauh} - x) / {Ktauh1}}} + {exp {({V0tauh} - x) / {Ktauh2}}})))
			
		setfield Na_slow_GP Y_A->table[{i}] {tauh}
		setfield Na_slow_GP Y_B->table[{i}] {hinf}
		x = x + dx
	end
	
	tweaktau Na_slow_GP Y
	call Na_slow_GP TABFILL Y 6000 0
	setfield Na_slow_GP Y_A->calc_mode {NO_INTERP}
	setfield Na_slow_GP Y_B->calc_mode {NO_INTERP}

//	*** Slow Inactivation (s-gate)	
	float Ks	  	= {Ks_NaP}
	float V0s	 	= {V0s_NaP}
	float Aalpha 	= {Aalpha_NaP}
	float Balpha 	= {Balpha_NaP}
	float Kalpha 	= {Kalpha_NaP}
	float Abeta 	= {Abeta_NaP}
	float Bbeta 	= {Bbeta_NaP}
	float Kbeta		= {Kbeta_NaP}

	float alphas, betas, taus, sinf
	call Na_slow_GP TABCREATE Z {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		alphas = (({Aalpha} * x) + {Balpha}) / (1 - {exp {((x + ({Balpha} / {Aalpha})) / {Kalpha})}})
		betas = (({Abeta} * x) + {Bbeta}) / (1 - {exp {((x + ({Bbeta} / {Abeta})) / {Kbeta})}})
		
		taus = 1 / ({dq10_NaP} * ({alphas} + {betas}))
		sinf = 1 / (1 + {exp {({V0s} - x) / {Ks} }})
		setfield Na_slow_GP Z_A->table[{i}] {taus}
		setfield Na_slow_GP Z_B->table[{i}] {sinf}
		x = x + dx
	end
	tweaktau Na_slow_GP Z
	call Na_slow_GP TABFILL Z 6000 0
	setfield Na_slow_GP Z_A->calc_mode {NO_INTERP}
	setfield Na_slow_GP Z_B->calc_mode {NO_INTERP}
	setfield Na_slow_GP Z_conc 0  // Z-gate voltage-dependent
end


//==================================================================
//		 		Kdr Kv2 
//		(Kv2.1) slow activating
//			  Created based on GP data:
//			  Baranuskas, Tkatch and Surmeier
//			  1999, J Neurosci 19(15):6394-6404
//==================================================================
function make_Kv2_GP
	if (({exists Kv2_GP}))
		return
	end
	create tabchannel Kv2_GP
	setfield Kv2_GP Ek {EK} Gbar {G_Kv2_GP} Ik 0 Gk 0\
		Xpower {npower_Kv2} Ypower {hpower_Kv2} Zpower 0

	float Vhalfn = {Vhalfn_Kv2}	// True Vhalf for channel activation
	float Kn = {Kn_Kv2}
	float taunmax = {taunmax_Kv2} / {dq10_Kv2}
	float taunmin = {taunmin_Kv2} / {dq10_Kv2}
	float K1tau = {Ktaun1_Kv2}
	float K2tau = {Ktaun2_Kv2}

	float V0n, ninf, taun, alpha, beta
	V0n = {Vhalfn} + ({Kn} * {log {(1 / {pow 0.5 {1/{npower_Kv2}}}) - 1}})
	echo "Kv2 V0n: " {V0n}
	//V0n is Vhalf for each individual n gate.
	call Kv2_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		ninf = 1 / (1 + {exp { ({V0n} - x) / {Kn} } } )
		taun = (({taunmin} + (({taunmax} - {taunmin}) / ({exp { ({V0n} - x) / {K1tau} } } + {exp {({V0n} - x) / {K2tau} }})))/{KV2_taunDiv})
		setfield Kv2_GP X_A->table[{i}] {taun}
		setfield Kv2_GP X_B->table[{i}] {ninf}
		x = x + dx
	end
	tweaktau Kv2_GP X
	call Kv2_GP TABFILL X 6000 0
	setfield Kv2_GP X_A->calc_mode {NO_INTERP}
	setfield Kv2_GP X_B->calc_mode {NO_INTERP}
		
	float V0h   = 	{V0h_Kv2}
	float Kh	=  	{Kh_Kv2}
	float hmin  =	{hmin_Kv2}
	float tauhmax = {tauhmax_Kv2} / {dq10_Kv2}
	float tauhmin =	{tauhmin_Kv2} / {dq10_Kv2}
	float Ktauh1  = {Ktauh1_Kv2}
	float Ktauh2  = {Ktauh2_Kv2}
	float V0tauh  =	{V0tauh_Kv2} 
	float hinf, tauh
	call Kv2_GP TABCREATE Y {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		hinf = {hmin} + ((1 - {hmin}) / (1 + {exp {({V0h} - x) / {Kh} }}))
		tauh = {tauhmin} + (({tauhmax} - {tauhmin}) / ({exp { ({V0tauh} - x) / {Ktauh1}}} + {exp {({V0tauh} - x) / {Ktauh2} }}))
		setfield Kv2_GP Y_A->table[{i}] {tauh}
		setfield Kv2_GP Y_B->table[{i}] {hinf}
		x = x + dx
	end
	tweaktau Kv2_GP Y
	call Kv2_GP TABFILL Y 6000 0
	setfield Kv2_GP Y_A->calc_mode {NO_INTERP}
	setfield Kv2_GP Y_B->calc_mode {NO_INTERP}
end



//==================================================================
//		 		Kdr Kv3
//		(Kv3.1/3.4 heteromultimers) fast activating,
//			incompletely inactivating.
//		From Surmeier's kv3sur.mod NEURON mechanism
//			written by Josh Held
//		Adapted to genesis by J.R. Edgerton, 2003
//		Modified to reflect new data in
//		Baranauskas et al (2003) by J.R. Edgerton, 2004.
//			  Baranauskas, Tkatch and Surmeier
//			  	1999, J Neurosci 19(15):6394-6404
//		Baranauskas, Tkatch, Nagata, Yeh & Surmeier 2003.
//			Nat Neurosci 6: 258-66.
//==================================================================
function make_Kv3_GP
	if (({exists Kv3_GP}))
		return
	end
	create tabchannel Kv3_GP
	setfield Kv3_GP Ek {EK} Gbar {G_Kv3_GP} Ik 0 Gk 0\
		Xpower {npower_Kv3} Ypower {hpower_Kv3} Zpower 0
	
	float Vhalfn = {Vhalfn_Kv3}	// True Vhalf for channel activation
	float Kn = {Kn_Kv3}
	float taunmax = {taunmax_Kv3} / {dq10_Kv3}
	float taunmin = {taunmin_Kv3} / {dq10_Kv3}
	float K1tau = {Ktaun1_Kv3}
	float K2tau = {Ktaun2_Kv3}

	float V0n, ninf, taun, alpha, beta
	V0n = {Vhalfn} + ({Kn} * {log {(1 / {pow 0.5 {1/{npower_Kv3}}}) - 1}})
	echo "Kv3 V0n: " {V0n}
	//V0n is Vhalf for each individual n gate.
	
	call Kv3_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		ninf = 1 / (1 + {exp { ({V0n} - x) / {Kn} } } )
		taun = ({taunmin} + (({taunmax} - {taunmin}) / ({exp { ({V0n} - x) / {K1tau} } } + {exp {-({V0n} - x) / {K2tau} }}))/{KV3_taunDiv})
		setfield Kv3_GP X_A->table[{i}] {taun}
		setfield Kv3_GP X_B->table[{i}] {ninf}
		x = x + dx
	end
	tweaktau Kv3_GP X
	call Kv3_GP TABFILL X 6000 0
	setfield Kv3_GP X_A->calc_mode {NO_INTERP}
	setfield Kv3_GP X_B->calc_mode {NO_INTERP}
		
	float V0h   = 	{V0h_Kv3}
	float Kh	=  	{Kh_Kv3}
	float hmin  =	{hmin_Kv3}
	float tauhmax = {tauhmax_Kv3} / {dq10_Kv3}
	float tauhmin =	{tauhmin_Kv3} / {dq10_Kv3}
	float Ktauh1  = {Ktauh1_Kv3}
	float Ktauh2  = {Ktauh2_Kv3}
	float V0tauh  =	{V0tauh_Kv3} 
	float hinf, tauh
	call Kv3_GP TABCREATE Y {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		hinf = {hmin} + ((1 - {hmin}) / (1 + {exp {({V0h} - x) / {Kh} }}))
		tauh = {tauhmin} + (({tauhmax} - {tauhmin}) / ({exp { ({V0tauh} - x) / {Ktauh1}}} + {exp {({V0tauh} - x) / {Ktauh2} }}))
                setfield Kv3_GP Y_A->table[{i}] {tauh}
		setfield Kv3_GP Y_B->table[{i}] {hinf}
		x = x + dx
	end

	tweaktau Kv3_GP Y
	call Kv3_GP TABFILL Y 6000 0
	setfield Kv3_GP Y_A->calc_mode {NO_INTERP}
	setfield Kv3_GP Y_B->calc_mode {NO_INTERP}
end


//==================================================================
//					  KA Kv4 fast
//			   Low voltage-activated
//			  Created based on GP data:
//			  Tkatch, Baranauskas and Surmeier
//			  2000, J Neurosci 20(2):579-588
//		Modified by J. R. Edgerton 02/2004
//==================================================================
function make_Kv4_fast_GP
	if (({exists Kv4_fast_GP}))
		return
	end
	create tabchannel Kv4_fast_GP
	setfield Kv4_fast_GP Ek {EK} Gbar {G_Kv4_fast_GP} Ik 0 Gk 0\
		Xpower {npower_Kv4} Ypower {hpower_Kv4} Zpower 0
	float Kn		= {Kn_Kv4}
	float V0n   	= {V0n_Kv4}
	float taunmax 	= {taunmax_Kv4} / {dq10_Kv4}
	float taunmin 	= {taunmin_Kv4} / {dq10_Kv4}
	float Ktaun1 	= {Ktaun1_Kv4}
	float Ktaun2 	= {Ktaun2_Kv4}
	float ninf, taun
	float Vhalfn = {V0n} - ({Kn} * {log {(1 / {pow 0.5 {1/{npower_Kv4}}}) - 1}})
	echo "Kv4f actual Vhalf: " {Vhalfn}
 	call Kv4_fast_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		ninf = 1 / (1 + {exp {({V0n} - x) / {Kn} }})
		taun = (taunmin + ({taunmax} - {taunmin}) / ({exp {({V0n} - x) / {Ktaun1}}} + {exp {({V0n} - x) / {Ktaun2}}})/{KV4_taunDiv})
		setfield Kv4_fast_GP X_A->table[{i}] {taun}
		setfield Kv4_fast_GP X_B->table[{i}] {ninf}
		x = x + dx
	end
	tweaktau Kv4_fast_GP X
	call Kv4_fast_GP TABFILL X 6000 0
	setfield Kv4_fast_GP X_A->calc_mode {NO_INTERP}
	setfield Kv4_fast_GP X_B->calc_mode {NO_INTERP}

	float tauhmax 	= {tauhmax_Kv4f} / {dq10_Kv4}   
	float tauhmin 	= {tauhmin_Kv4f} / {dq10_Kv4}
	float Kh		= {Kh_Kv4}
	float V0h   	= {V0h_Kv4}
	float Ktauh1 	= {Ktauh1_Kv4}
	float Ktauh2 	= {Ktauh2_Kv4}
	float hinf, tauh
	call Kv4_fast_GP TABCREATE Y {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		hinf = 1 / (1 + {exp {({V0h} - x) / {Kh} }})
		tauh = tauhmin + ({tauhmax} - {tauhmin}) / ({exp {({V0h} - x) / {Ktauh1}}} + {exp {({V0h} - x) / {Ktauh2}}}) 
		setfield Kv4_fast_GP Y_A->table[{i}] {tauh}
		setfield Kv4_fast_GP Y_B->table[{i}] {hinf}
		x = x + dx
	end
	tweaktau Kv4_fast_GP Y
	call Kv4_fast_GP TABFILL Y 6000 0
	setfield Kv4_fast_GP Y_A->calc_mode {NO_INTERP}
	setfield Kv4_fast_GP Y_B->calc_mode {NO_INTERP}
end


//==================================================================
//					  KA Kv4 slow
//			   Low voltage-activated
//			  Created based on GP data:
//			  Tkatch, Baranauskas and Surmeier
//			  2000, J Neurosci 20(2):579-588
//		Modified by J. R. Edgerton 02/2004
//==================================================================
function make_Kv4_slow_GP
	if (({exists Kv4_slow_GP}))
		return
	end
	create tabchannel Kv4_slow_GP
	float npower = 4
	setfield Kv4_slow_GP Ek {EK} Gbar {G_Kv4_slow_GP} Ik 0 Gk 0\
		Xpower {npower_Kv4} Ypower {hpower_Kv4} Zpower 0
	float Kn		= {Kn_Kv4}
	float V0n   	= {V0n_Kv4}
	float taunmax 	= {taunmax_Kv4} / {dq10_Kv4}
	float taunmin 	= {taunmin_Kv4} / {dq10_Kv4}
	float Ktaun1 	= {Ktaun1_Kv4}
	float Ktaun2 	= {Ktaun2_Kv4}
	float ninf, taun
	float Vhalfn = {V0n} - ({Kn} * {log {(1 / {pow 0.5 {1/{npower_Kv4}}}) - 1}})
	echo "Kv4s actual Vhalf: " {Vhalfn}
 	call Kv4_slow_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		ninf = 1 / (1 + {exp {({V0n} - x) / {Kn} }})
		taun = (taunmin + ({taunmax} - {taunmin}) / ({exp {({V0n} - x) / {Ktaun1}}} + {exp {({V0n} - x) / {Ktaun2}}})/{KV4_taunDiv})
		setfield Kv4_slow_GP X_A->table[{i}] {taun}
		setfield Kv4_slow_GP X_B->table[{i}] {ninf}
		x = x + dx
	end
	tweaktau Kv4_slow_GP X
	call Kv4_slow_GP TABFILL X 6000 0
	setfield Kv4_slow_GP X_A->calc_mode {NO_INTERP}
	setfield Kv4_slow_GP X_B->calc_mode {NO_INTERP}

	float tauhmax 	= {tauhmax_Kv4s} / {dq10_Kv4}   
	float tauhmin 	= {tauhmin_Kv4s} / {dq10_Kv4}
	float Kh		= {Kh_Kv4}
	float V0h   	= {V0h_Kv4}
	float Ktauh1 	= {Ktauh1_Kv4}
	float Ktauh2 	= {Ktauh2_Kv4}
	float hinf, tauh
	call Kv4_slow_GP TABCREATE Y {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		hinf = 1 / (1 + {exp {({V0h} - x) / {Kh} }})
		tauh = tauhmin + ({tauhmax} - {tauhmin}) / ({exp {({V0h} - x) / {Ktauh1}}} + {exp {({V0h} - x) / {Ktauh2}}}) 
		setfield Kv4_slow_GP Y_A->table[{i}] {tauh}
		setfield Kv4_slow_GP Y_B->table[{i}] {hinf}
		x = x + dx
	end
	tweaktau Kv4_slow_GP Y
	call Kv4_slow_GP TABFILL Y 6000 0
	setfield Kv4_slow_GP Y_A->calc_mode {NO_INTERP}
	setfield Kv4_slow_GP Y_B->calc_mode {NO_INTERP}
end


//==================================================================
//		 			KCNQ 
// Activation kinetics: Gamper, Stockand, Shapiro (2003). J Neurosci 23: 84-95.
// GV curve, deact kinetics: Prole & Marrion (2004). Biophys J. 86: 1454-69.
//==================================================================
function make_KCNQ_GP
	if (({exists KCNQ_GP}))
		return
	end
	create tabchannel KCNQ_GP
	setfield KCNQ_GP Ek {EK} Gbar {G_KCNQ_GP} Ik 0 Gk 0\
		Xpower {npower_KCNQ} Ypower 0 Zpower 0
	float Vhalfn = {Vhalfn_KCNQ}	// True Vhalf for channel activation
	float Kn = {Kn_KCNQ}
	float taunmax = {taunmax_KCNQ} / {dq10_KCNQ}
	float taunmin = {taunmin_KCNQ} / {dq10_KCNQ}
	float K1tau = {Ktaun1_KCNQ}
	float K2tau = {Ktaun2_KCNQ}
	float V0n, ninf, taun, alpha, beta
	V0n = {Vhalfn} + ({Kn} * {log {(1 / {pow 0.5 {1/{npower_KCNQ}}}) - 1}})
	echo "KCNQ V0n: " {V0n}
	//V0n is Vhalf for each individual n gate.
	call KCNQ_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		ninf = 1 / (1 + {exp { ({V0n} - x) / {Kn} } } )
		taun = {taunmin} + (({taunmax} - {taunmin}) / ({exp { ({V0n} - x) / {K1tau} } } + {exp { ({V0n} - x) / {K2tau} }}))
		setfield KCNQ_GP X_A->table[{i}] {taun}
		setfield KCNQ_GP X_B->table[{i}] {ninf}
		x = x + dx
	end
	tweaktau KCNQ_GP X
	call KCNQ_GP TABFILL X 6000 0
	setfield KCNQ_GP X_A->calc_mode {NO_INTERP}
	setfield KCNQ_GP X_B->calc_mode {NO_INTERP}
end


//==================================================================
//					   HVA Ca2+ Channels 
//	Voltage-dependent activation from GP data:  
//		Surmeier Seno and Kitai 2000
//			 	J Neurophysio. 71(3):1272-1280
//==================================================================
//First make a calcium concentration object that will keep track of the
//Ca2+ coming in from the calcium channels and apply buffering. 
function make_Ca_GP_conc
	if (({exists Ca_GP_conc}))
		return
	end
	create Ca_concen Ca_GP_conc
	setfield Ca_GP_conc	\
		tau	 {tau_CaClearance}   \   // sec
		B	   5.2e-6 \   // Moles per coulomb, later scaled to conc
		Ca_base 5e-05	 //Units in mM, so = 50 nM.
end

//Next make nernst object to keep track of Calcium reversal potential
//during changes in intracellular calcium concentration.
function make_Ca_GP_nernst
	if (({exists Ca_GP_nernst}))
		return
	end
	create nernst Ca_GP_nernst
	setfield Ca_GP_nernst	\
		Cout	2	\	//external Ca2+ conc
		Cin	5e-5	\	//baseline internal Ca2+ conc 50 nM
		T	32	\	//temp in Celsius
		valency	2	\	//divalent
		scale 	1		//E in volts
end

//Finally make actual calcium channels.
	// Made by J. Hanson based on Surmeier GP data
function make_Ca_HVA_GP
	if (({exists Ca_HVA_GP}))
		return
	end
	int ndivs, i
	float x, y
	create tabchannel Ca_HVA_GP
	setfield Ca_HVA_GP Ek {ECa} Gbar {G_Ca_HVA_GP} Ik 0 Gk 0 \
		Xpower {npower_CaHVA} Ypower 0 Zpower 0

	//first setup voltage-dependent activation
	float tau =  {taun_CaHVA} / {dq10_CaHVA}
	float K = -1*{Kn_CaHVA}
	float V0 = {Vhalfn_CaHVA}
	setuptau Ca_HVA_GP X \
		{tau} {tau*1e-6} 0 0 1e6 \
		1 0 1 {-1.0*V0} {K} -range {xmin} {xmax} 
	call Ca_HVA_GP TABFILL X 6000 0
	setfield Ca_HVA_GP X_A->calc_mode {NO_INTERP}
	setfield Ca_HVA_GP X_B->calc_mode {NO_INTERP}
end


//==================================================================
//	SK channel from Volker Steuber's DCN neuron model, modified to
//		reflect Hill fits in the following:
//		Hirschberg et al, 1999: Biophys J. 77: 1905-13. 
//		Keen et al, 1999: J. Neurosci 19: 8830-38.
//		Tau-Ca equation made by Volker based on Hirschberg et al, 1998:
//			JGP 111: 565-581.
//==================================================================	
function make_SK_GP
	if ({exists K_ahp_GP})
		return
	end
 
	float cxmin, cxmax, cxdivs, cdx
	float taum, minf
	float hillslope = {hillslope_SK}	// Hirschberg et al, 1999
	float taumax = {taumax_SK}			// deactivation tau in 0 Ca2+
	float taumin = {taumin_SK}			// max rate in saturating Ca2+
	float caSat = {CaSat_SK}			// calcium conc at which tauact hits max
	float tauK = ({taumax} - {taumin}) / {caSat}
	// NOTE: genesis SI concentration units = mols / m^3 = millimolar!
	create tabchannel K_ahp_GP
	setfield K_ahp_GP Ek {EK} Gbar {G_K_ahp_GP}  \
		Xpower 0 Ypower 0 Zpower {zpower_SK} 
	cxmin = 0.00001	// 10 nM
	cxmax = 0.06 		// 60 microM
					// Conc-dependence grid will have 6000 points spanning 
					//	1 nM to 6 microM with resolution of 1 nM.
	cxdivs = 5999	// Have to use high-resolution for channel setup because
					// most of G-Ca curve falls within the first 1 microM.
	cdx = (cxmax - cxmin)/cxdivs
	call K_ahp_GP TABCREATE Z {cxdivs} {cxmin} {cxmax}
	x = cxmin

	for (i = 0; i <= {cxdivs}; i = i + 1)
	
		if (x < {caSat})
	  		taum = ({taumax} - x*{tauK})/{dq10_SK}
		else
	  		taum = {taumin}/{dq10_SK}
		end
		minf = {pow {x} {hillslope}} / ({pow {x} {hillslope}} + {pow {EC50_SK} {hillslope}})

		setfield K_ahp_GP Z_A->table[{i}] {taum}
		setfield K_ahp_GP Z_B->table[{i}] {minf}

		x = x + cdx
  	end
	
	tweaktau K_ahp_GP Z
	call K_ahp_GP TABFILL Z 6000 0
	setfield K_ahp_GP Z_A->calc_mode {NO_INTERP}
	setfield K_ahp_GP Z_B->calc_mode {NO_INTERP}
end
	

//==================================================================
//	  H current  (Anomalous rectifier--mixed Na and K current)
//		HCN1/HCN2 heteromeric channel, GP-specific
//		Channel model from Chan et al (2004), J Neurosci 24: 9921-32.
//		Original model from Siegelbaum lab. Wang et al (2002), Neuron 36:
//			451-62. Chen et al (2001), JGP 117: 491-504.
//==================================================================
function make_h_HCN_GP
	if ({exists h_HCN_GP})
	   		return
	end
	create tabchannel h_HCN_GP
	setfield h_HCN_GP Ek {Eh} Gbar {{G_h_HCN_GP}}  \
		Xpower {mpower_HCN1} Ypower 0 Zpower 0
	float Km	  	= {Km_HCN1}
	float V0m	 	= {V0m_HCN1}
	float taumin	= {taumin_HCN1} / {dq10_HCN1}
	float taumax	= {taumax_HCN1} / {dq10_HCN1}
	float Ktau1		= {Ktau1_HCN1}
	float Ktau2		= {Ktau2_HCN1}
	float dq10 		= {dq10_HCN1}
	float minf, taum
	call h_HCN_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
		taum = {taumin} + (({taumax} - {taumin}) / ({exp {({V0m} - x)/{Ktau1}}} + {exp {({V0m}-x)/{Ktau2}}}))
		setfield h_HCN_GP X_A->table[{i}] {taum}
		setfield h_HCN_GP X_B->table[{i}] {minf}
		x = x + dx
	end
	tweaktau h_HCN_GP X
	call h_HCN_GP TABFILL X 6000 0
	setfield h_HCN_GP X_A->calc_mode {NO_INTERP}
	setfield h_HCN_GP X_B->calc_mode {NO_INTERP}
end

//==================================================================
//	  H current  (Anomalous rectifier--mixed Na and K current)
//		HCN2 homomeric channel, GP-specific
//		Channel model from Chan et al (2004), J Neurosci 24: 9921-32.
//		Original model from Siegelbaum lab. Wang et al (2002), Neuron 36:
//			451-62. Chen et al (2001), JGP 117: 491-504.
//==================================================================
function make_h_HCN2_GP
	if ({exists h_HCN2_GP})
	   	return
	end
	create tabchannel h_HCN2_GP
	setfield h_HCN2_GP Ek {Eh} Gbar {{G_h_HCN2_GP}}  \
		Xpower {mpower_HCN2} Ypower 0 Zpower 0
	float Km	  	= {Km_HCN2}
	float V0m	 	= {V0m_HCN2}
	float taumin	= {taumin_HCN2} / {dq10_HCN2}
	float taumax	= {taumax_HCN2} / {dq10_HCN2}
	float Ktau1		= {Ktau1_HCN2}
	float Ktau2		= {Ktau2_HCN2}
	float dq10 		= {dq10_HCN2}
	float minf, taum
	call h_HCN2_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
		taum = {taumin} + (({taumax} - {taumin}) / ({exp {({V0m} - x)/{Ktau1}}} + {exp {({V0m} - x)/{Ktau2}}}))
		setfield h_HCN2_GP X_A->table[{i}] {taum}
		setfield h_HCN2_GP X_B->table[{i}] {minf}
		x = x + dx
	end
	tweaktau h_HCN2_GP X
	call h_HCN2_GP TABFILL X 6000 0
	setfield h_HCN2_GP X_A->calc_mode {NO_INTERP}
	setfield h_HCN2_GP X_B->calc_mode {NO_INTERP}
end
