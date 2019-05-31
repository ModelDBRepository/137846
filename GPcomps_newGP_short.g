//FILE IN USE 09/30/2004 -- present.

//genesis - genesis2.2 script, J Hanson 5/02
//axon rebuilt with hillock, initial segment, nodes and internodal
//	segments 06/25/2004 according to Shen et al (1999).
// 06/28/2004: added KCNQ to axon, added G_mult_KCNQ_dend and G_mult_KCNQ_axon
// 09/30/2004: changed dendritic subclassifications to match the data of
//		Hanson & Smith, 2004.

float PI = 3.14159

function make_GP_comps
	float len, dia, surf, rad, vol, core_vol, shell_vol
	float rad_core, shell_vol
	int i

/* make spherical soma prototype */
	len = 0 
	dia = 1 
	rad = {dia}/2.0
	rad_core = rad - {shell_thick} 
	surf = 4*{PI}*rad*rad
	vol = 4/3*{PI}*rad*rad*rad
	core_vol = 4/3*{PI}*rad_core*rad_core*rad_core
	shell_vol = vol - core_vol
	if (!({exists GP_soma}))
		create compartment GP_soma
	end
	setfield GP_soma Cm {{CM}*surf} Ra {8.0*{RA}/({dia}*{PI})}  \
		Em {ELEAK_sd} initVm {EREST_ACT} Rm {{RM_sd}/surf} inject 0.0  \
		dia {dia} len {len}

/* put channels in soma */
	copy Ca_HVA_GP GP_soma/Ca_HVA_GP_somahill
	addmsg GP_soma GP_soma/Ca_HVA_GP_somahill VOLTAGE Vm
	addmsg GP_soma/Ca_HVA_GP_somahill GP_soma CHANNEL Gk Ek
	setfield GP_soma/Ca_HVA_GP_somahill Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_soma}*{G_mult}}

	copy K_ahp_GP GP_soma/K_ahp_GP_somahill
	addmsg GP_soma GP_soma/K_ahp_GP_somahill VOLTAGE Vm
        addmsg GP_soma/K_ahp_GP_somahill GP_soma CHANNEL Gk Ek
        setfield GP_soma/K_ahp_GP_somahill Gbar	\
		{{G_K_ahp_GP}*surf*{G_mult_SK_soma}*{G_mult}}

	copy Ca_GP_nernst GP_soma/Ca_GP_nernst
	copy Ca_GP_conc GP_soma/Ca_GP_conc
	addmsg GP_soma/Ca_HVA_GP_somahill GP_soma/Ca_GP_conc I_Ca Ik 
	addmsg GP_soma/Ca_GP_conc GP_soma/Ca_HVA_GP_somahill CONCEN Ca
	addmsg GP_soma/Ca_GP_conc GP_soma/K_ahp_GP_somahill CONCEN Ca
	addmsg GP_soma/Ca_GP_conc GP_soma/Ca_GP_nernst CIN Ca
	addmsg GP_soma/Ca_GP_nernst GP_soma/Ca_HVA_GP_somahill EK E 
	setfield GP_soma/Ca_GP_conc B {{B_Ca_GP_conc}/shell_vol}

   	copy Na_fast_GP GP_soma/Na_fast_GP_somahill
        addmsg GP_soma GP_soma/Na_fast_GP_somahill VOLTAGE Vm
        addmsg GP_soma/Na_fast_GP_somahill GP_soma CHANNEL Gk Ek
        setfield GP_soma/Na_fast_GP_somahill Gbar	\
		{{G_Na_fast_GP}*surf*{G_mult_NaF_soma}*{G_mult}}

	copy Na_slow_GP GP_soma/Na_slow_GP_somahill
        addmsg GP_soma GP_soma/Na_slow_GP_somahill VOLTAGE Vm
        addmsg GP_soma/Na_slow_GP_somahill GP_soma CHANNEL Gk Ek
        setfield GP_soma/Na_slow_GP_somahill Gbar	\
		{{G_Na_slow_GP}*surf*{G_mult_NaS_soma}*{G_mult}}

	copy Kv3_GP GP_soma/Kv3_GP_somahill
        addmsg GP_soma GP_soma/Kv3_GP_somahill VOLTAGE Vm
        addmsg GP_soma/Kv3_GP_somahill GP_soma CHANNEL Gk Ek
        setfield GP_soma/Kv3_GP_somahill Gbar	\
		{{G_Kv3_GP}*surf*{G_mult_KV3_soma}*{G_mult}} 

	copy Kv2_GP GP_soma/Kv2_GP_somahill
        addmsg GP_soma GP_soma/Kv2_GP_somahill VOLTAGE Vm
        addmsg GP_soma/Kv2_GP_somahill GP_soma CHANNEL Gk Ek
	setfield GP_soma/Kv2_GP_somahill Gbar	\
		{{G_Kv2_GP}*surf*{G_mult_KV2_soma}*{G_mult}}

	copy Kv4_fast_GP GP_soma/Kv4_fast_GP_somahill
        addmsg GP_soma GP_soma/Kv4_fast_GP_somahill VOLTAGE Vm
        addmsg GP_soma/Kv4_fast_GP_somahill GP_soma CHANNEL Gk Ek
        setfield GP_soma/Kv4_fast_GP_somahill Gbar	\
		{{G_Kv4_fast_GP}*surf*{G_mult_KA_soma}*{G_mult}}

	copy Kv4_slow_GP GP_soma/Kv4_slow_GP_somahill
        addmsg GP_soma GP_soma/Kv4_slow_GP_somahill VOLTAGE Vm
        addmsg GP_soma/Kv4_slow_GP_somahill GP_soma CHANNEL Gk Ek
        setfield GP_soma/Kv4_slow_GP_somahill Gbar	\
		{{G_Kv4_slow_GP}*surf*{G_mult_KA_soma}*{G_mult}}
	
	copy KCNQ_GP GP_soma/KCNQ_GP_somahill
        addmsg GP_soma GP_soma/KCNQ_GP_somahill VOLTAGE Vm
        addmsg GP_soma/KCNQ_GP_somahill GP_soma CHANNEL Gk Ek
        setfield GP_soma/KCNQ_GP_somahill Gbar	\
		{{G_KCNQ_GP}*surf*{G_mult_KCNQ_soma}*{G_mult}}

	copy h_HCN_GP GP_soma/h_HCN_GP_somahill
        addmsg GP_soma GP_soma/h_HCN_GP_somahill VOLTAGE Vm
        addmsg GP_soma/h_HCN_GP_somahill GP_soma CHANNEL Gk Ek
        setfield GP_soma/h_HCN_GP_somahill Gbar	\
		{{G_h_HCN_GP}*surf*{G_mult}}
		
	copy h_HCN2_GP GP_soma/h_HCN2_GP_somahill
        addmsg GP_soma GP_soma/h_HCN2_GP_somahill VOLTAGE Vm
        addmsg GP_soma/h_HCN2_GP_somahill GP_soma CHANNEL Gk Ek
        setfield GP_soma/h_HCN2_GP_somahill Gbar	\
		{{G_h_HCN2_GP}*surf*{G_mult}}

/* make axon hillock prototype --> extension of soma */
	len = 1 
	dia = 1 
	rad = {dia} / 2.0
	surf = 2*{PI}*rad*{len} 
	vol = {PI}*rad*rad*{len} 
	if (dia > {{shell_thick}*2.0})
		rad_core = rad - {shell_thick}
		core_vol = {PI}*rad_core*rad_core*{len} 
		shell_vol = vol - core_vol
	else
		shell_vol = vol
	end
	if (!({exists GP_axHill}))
	    create compartment GP_axHill
	end
	setfield GP_axHill Cm {{CM}*surf} Ra {4.0*{RA}*{len}/({dia}*{dia}*{PI})}  \
        	Em {ELEAK_sd} initVm {EREST_ACT} Rm {{RM_sd}/surf} inject 0.0  \
        	dia {dia} len {len}

/* put channels in axon hillock --> same as soma */
	copy Ca_HVA_GP GP_axHill/Ca_HVA_GP_somahill
	addmsg GP_axHill GP_axHill/Ca_HVA_GP_somahill VOLTAGE Vm
	addmsg GP_axHill/Ca_HVA_GP_somahill GP_axHill CHANNEL Gk Ek
	setfield GP_axHill/Ca_HVA_GP_somahill Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_soma}*{G_mult}}

	copy K_ahp_GP GP_axHill/K_ahp_GP_somahill
	addmsg GP_axHill GP_axHill/K_ahp_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/K_ahp_GP_somahill GP_axHill CHANNEL Gk Ek
        setfield GP_axHill/K_ahp_GP_somahill Gbar	\
		{{G_K_ahp_GP}*surf*{G_mult_SK_soma}*{G_mult}}

	copy Ca_GP_nernst GP_axHill/Ca_GP_nernst
	copy Ca_GP_conc GP_axHill/Ca_GP_conc
	addmsg GP_axHill/Ca_HVA_GP_somahill GP_axHill/Ca_GP_conc I_Ca Ik 
	addmsg GP_axHill/Ca_GP_conc GP_axHill/Ca_HVA_GP_somahill CONCEN Ca
	addmsg GP_axHill/Ca_GP_conc GP_axHill/K_ahp_GP_somahill CONCEN Ca
	addmsg GP_axHill/Ca_GP_conc GP_axHill/Ca_GP_nernst CIN Ca
	addmsg GP_axHill/Ca_GP_nernst GP_axHill/Ca_HVA_GP_somahill EK E 
	setfield GP_axHill/Ca_GP_conc B {{B_Ca_GP_conc}/shell_vol}

   	copy Na_fast_GP GP_axHill/Na_fast_GP_somahill
        addmsg GP_axHill GP_axHill/Na_fast_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/Na_fast_GP_somahill GP_axHill CHANNEL Gk Ek
        setfield GP_axHill/Na_fast_GP_somahill Gbar	\
		{{G_Na_fast_GP}*surf*{G_mult_NaF_soma}*{G_mult}}

	copy Na_slow_GP GP_axHill/Na_slow_GP_somahill
        addmsg GP_axHill GP_axHill/Na_slow_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/Na_slow_GP_somahill GP_axHill CHANNEL Gk Ek
        setfield GP_axHill/Na_slow_GP_somahill Gbar	\
		{{G_Na_slow_GP}*surf*{G_mult_NaS_soma}*{G_mult}}

	copy Kv3_GP GP_axHill/Kv3_GP_somahill
        addmsg GP_axHill GP_axHill/Kv3_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/Kv3_GP_somahill GP_axHill CHANNEL Gk Ek
        setfield GP_axHill/Kv3_GP_somahill Gbar	\
		{{G_Kv3_GP}*surf*{G_mult_KV3_soma}*{G_mult}} 

	copy Kv2_GP GP_axHill/Kv2_GP_somahill
        addmsg GP_axHill GP_axHill/Kv2_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/Kv2_GP_somahill GP_axHill CHANNEL Gk Ek
	setfield GP_axHill/Kv2_GP_somahill Gbar	\
		{{G_Kv2_GP}*surf*{G_mult_KV2_soma}*{G_mult}}

	copy Kv4_fast_GP GP_axHill/Kv4_fast_GP_somahill
        addmsg GP_axHill GP_axHill/Kv4_fast_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/Kv4_fast_GP_somahill GP_axHill CHANNEL Gk Ek
        setfield GP_axHill/Kv4_fast_GP_somahill Gbar	\
		{{G_Kv4_fast_GP}*surf*{G_mult_KA_soma}*{G_mult}}

	copy Kv4_slow_GP GP_axHill/Kv4_slow_GP_somahill
        addmsg GP_axHill GP_axHill/Kv4_slow_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/Kv4_slow_GP_somahill GP_axHill CHANNEL Gk Ek
        setfield GP_axHill/Kv4_slow_GP_somahill Gbar	\
		{{G_Kv4_slow_GP}*surf*{G_mult_KA_soma}*{G_mult}}
	
	copy KCNQ_GP GP_axHill/KCNQ_GP_somahill
        addmsg GP_axHill GP_axHill/KCNQ_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/KCNQ_GP_somahill GP_axHill CHANNEL Gk Ek
        setfield GP_axHill/KCNQ_GP_somahill Gbar	\
		{{G_KCNQ_GP}*surf*{G_mult}}

	copy h_HCN_GP GP_axHill/h_HCN_GP_somahill
        addmsg GP_axHill GP_axHill/h_HCN_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/h_HCN_GP_somahill GP_axHill CHANNEL Gk Ek
        setfield GP_axHill/h_HCN_GP_somahill Gbar	\
		{{G_h_HCN_GP}*surf*{G_mult}}
		
	copy h_HCN2_GP GP_axHill/h_HCN2_GP_somahill
        addmsg GP_axHill GP_axHill/h_HCN2_GP_somahill VOLTAGE Vm
        addmsg GP_axHill/h_HCN2_GP_somahill GP_axHill CHANNEL Gk Ek
        setfield GP_axHill/h_HCN2_GP_somahill Gbar	\
		{{G_h_HCN2_GP}*surf*{G_mult}}

/* make axon initial segment prototype--> low Rm */
	len = 1 
	dia = 1 
	rad = {dia} / 2
	surf = 2*{PI}*rad*{len} 
	vol = {PI}*rad*rad*{len} 
        if (!({exists GP_axIS}))
            create compartment GP_axIS
        end
        setfield GP_axIS Cm {{CM}*surf} Ra {4.0*{RA}*{len}/({dia}*{dia}*{PI})}  \
                Em {ELEAK_ax} initVm {EREST_ACT} Rm {{RM_ax}/surf} inject 0.0  \
                dia {dia} len {len}
		
/* put channels in axon initial segment */
	copy Na_fast_GP GP_axIS/Na_fast_GP_IS
	addmsg GP_axIS GP_axIS/Na_fast_GP_IS VOLTAGE Vm
	addmsg GP_axIS/Na_fast_GP_IS GP_axIS CHANNEL Gk Ek
	setfield GP_axIS/Na_fast_GP_IS Gbar	\
		{{G_Na_fast_GP}*surf*{G_mult_Na_IS}*{G_mult}}
	
	copy Na_slow_GP GP_axIS/Na_slow_GP_IS
        addmsg GP_axIS GP_axIS/Na_slow_GP_IS VOLTAGE Vm
        addmsg GP_axIS/Na_slow_GP_IS GP_axIS CHANNEL Gk Ek
        setfield GP_axIS/Na_slow_GP_IS Gbar	\
		{{G_Na_slow_GP}*surf*{G_mult_Na_IS}*{G_mult}}
		
	copy Kv4_fast_GP GP_axIS/Kv4_fast_GP_IS
        addmsg GP_axIS GP_axIS/Kv4_fast_GP_IS VOLTAGE Vm
        addmsg GP_axIS/Kv4_fast_GP_IS GP_axIS CHANNEL Gk Ek
        setfield GP_axIS/Kv4_fast_GP_IS Gbar	\
		{{G_Kv4_fast_GP}*surf*{G_mult_KA_axon}*{G_mult}}

	copy Kv4_slow_GP GP_axIS/Kv4_slow_GP_IS
        addmsg GP_axIS GP_axIS/Kv4_slow_GP_IS VOLTAGE Vm
        addmsg GP_axIS/Kv4_slow_GP_IS GP_axIS CHANNEL Gk Ek
        setfield GP_axIS/Kv4_slow_GP_IS Gbar	\
		{{G_Kv4_slow_GP}*surf*{G_mult_KA_axon}*{G_mult}}
	
	copy Kv3_GP GP_axIS/Kv3_GP_IS
        addmsg GP_axIS GP_axIS/Kv3_GP_IS VOLTAGE Vm
        addmsg GP_axIS/Kv3_GP_IS GP_axIS CHANNEL Gk Ek
        setfield GP_axIS/Kv3_GP_IS Gbar	\
		{{G_Kv3_GP}*surf*{G_mult_Kdr_IS}*{G_mult}}
	
	copy Kv2_GP GP_axIS/Kv2_GP_IS
        addmsg GP_axIS GP_axIS/Kv2_GP_IS VOLTAGE Vm
        addmsg GP_axIS/Kv2_GP_IS GP_axIS CHANNEL Gk Ek
        setfield GP_axIS/Kv2_GP_IS Gbar	\
		{{G_Kv2_GP}*surf*{G_mult_Kdr_IS}*{G_mult}}

	copy KCNQ_GP GP_axIS/KCNQ_GP_IS
        addmsg GP_axIS GP_axIS/KCNQ_GP_IS VOLTAGE Vm
        addmsg GP_axIS/KCNQ_GP_IS GP_axIS CHANNEL Gk Ek
        setfield GP_axIS/KCNQ_GP_IS Gbar	\
		{{G_KCNQ_GP}*surf*{G_mult_KCNQ_axon}*{G_mult}}

	
/* make axon internodal segment prototype--> low Cm, high Rm, no chans */
	len = 1 
	dia = 1 
	rad = {dia} / 2.0
	surf = 2*{PI}*rad*{len} 
	vol = {PI}*rad*rad*{len} 
        if (!({exists GP_axIN}))
            create compartment GP_axIN
        end
        setfield GP_axIN Cm {{CM_my}*surf} Ra {4.0*{RA}*{len}/({dia}*{dia}*{PI})}  \
                Em {ELEAK_ax} initVm {EREST_ACT} Rm {{RM_my}/surf} inject 0.0  \
                dia {dia} len {len}
// no channels in axIN segments.


/* make axon node prototype--> same characteristics as initial segment */
	len = 1 
	dia = 1 
	rad = {dia} / 2.0
	surf = 2*{PI}*rad*{len} 
	vol = {PI}*rad*rad*{len} 
        if (!({exists GP_axNode}))
            create compartment GP_axNode
        end
        setfield GP_axNode Cm {{CM}*surf} Ra {4.0*{RA}*{len}/({dia}*{dia}*{PI})}  \
                Em {ELEAK_ax} initVm {EREST_ACT} Rm {{RM_ax}/surf} inject 0.0  \
                dia {dia} len {len}

/* put channels in node--> exclude NaP to prevent spontaneous initiation */
	copy Na_fast_GP GP_axNode/Na_fast_GP_node
	addmsg GP_axNode GP_axNode/Na_fast_GP_node VOLTAGE Vm
	addmsg GP_axNode/Na_fast_GP_node GP_axNode CHANNEL Gk Ek
	setfield GP_axNode/Na_fast_GP_node Gbar	\
		{{G_Na_fast_GP}*surf*{G_mult_Na_axon}*{G_mult}}
/*	
	copy Na_slow_GP GP_axNode/Na_slow_GP_node
        addmsg GP_axNode GP_axNode/Na_slow_GP_node VOLTAGE Vm
        addmsg GP_axNode/Na_slow_GP_node GP_axNode CHANNEL Gk Ek
        setfield GP_axNode/Na_slow_GP_node Gbar	\
		{{G_Na_slow_GP}*surf*{G_mult_Na_axon}*{G_mult}}
*/		
	copy Kv4_fast_GP GP_axNode/Kv4_fast_GP_node
        addmsg GP_axNode GP_axNode/Kv4_fast_GP_node VOLTAGE Vm
        addmsg GP_axNode/Kv4_fast_GP_node GP_axNode CHANNEL Gk Ek
        setfield GP_axNode/Kv4_fast_GP_node Gbar	\
		{{G_Kv4_fast_GP}*surf*{G_mult_KA_axon}*{G_mult}}

	copy Kv4_slow_GP GP_axNode/Kv4_slow_GP_node
        addmsg GP_axNode GP_axNode/Kv4_slow_GP_node VOLTAGE Vm
        addmsg GP_axNode/Kv4_slow_GP_node GP_axNode CHANNEL Gk Ek
        setfield GP_axNode/Kv4_slow_GP_node Gbar	\
		{{G_Kv4_slow_GP}*surf*{G_mult_KA_axon}*{G_mult}}
	
	copy Kv3_GP GP_axNode/Kv3_GP_node
        addmsg GP_axNode GP_axNode/Kv3_GP_node VOLTAGE Vm
        addmsg GP_axNode/Kv3_GP_node GP_axNode CHANNEL Gk Ek
        setfield GP_axNode/Kv3_GP_node Gbar	\
		{{G_Kv3_GP}*surf*{G_mult_Kdr_axon}*{G_mult}}
	
	copy Kv2_GP GP_axNode/Kv2_GP_node
        addmsg GP_axNode GP_axNode/Kv2_GP_node VOLTAGE Vm
        addmsg GP_axNode/Kv2_GP_node GP_axNode CHANNEL Gk Ek
        setfield GP_axNode/Kv2_GP_node Gbar	\
		{{G_Kv2_GP}*surf*{G_mult_Kdr_axon}*{G_mult}}

	copy KCNQ_GP GP_axNode/KCNQ_GP_node
        addmsg GP_axNode GP_axNode/KCNQ_GP_node VOLTAGE Vm
        addmsg GP_axNode/KCNQ_GP_node GP_axNode CHANNEL Gk Ek
        setfield GP_axNode/KCNQ_GP_node Gbar	\
		{{G_KCNQ_GP}*surf*{G_mult_KCNQ_axon}*{G_mult}}

//	Dendritic prototype = dendrite_p
	len = 1 
	dia = 1 
	rad = {dia} / 2.0
	surf = 2*{PI}*rad*{len} 
	vol = {PI}*rad*rad*{len} 
	if (dia > {{shell_thick}*2})
		rad_core = rad - {shell_thick}
		core_vol = {PI}*rad_core*rad_core*{len} 
		shell_vol = vol - core_vol
	else
		shell_vol = vol
	end
	if (!({exists GP_dendrite_p}))
	    create compartment GP_dendrite_p
	end
	setfield GP_dendrite_p Cm {{CM}*surf} Ra {4.0*{RA}*{len}/({dia}*{dia}*{PI})}  \
        	Em {ELEAK_sd} initVm {EREST_ACT} Rm {{RM_sd}/surf} inject 0.0  \
        	dia {dia} len {len}

// Put shared channels in prototype dendrite
        copy Ca_HVA_GP GP_dendrite_p/Ca_HVA_GP
        addmsg GP_dendrite_p GP_dendrite_p/Ca_HVA_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Ca_HVA_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Ca_HVA_GP Gbar   \
                {{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}}

        copy K_ahp_GP GP_dendrite_p/K_ahp_GP
        addmsg GP_dendrite_p GP_dendrite_p/K_ahp_GP VOLTAGE Vm
        addmsg GP_dendrite_p/K_ahp_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/K_ahp_GP Gbar    \
                {{G_K_ahp_GP}*surf*{G_mult_SK_dend}*{G_mult}}

        copy Ca_GP_nernst GP_dendrite_p/Ca_GP_nernst
        copy Ca_GP_conc GP_dendrite_p/Ca_GP_conc
        addmsg GP_dendrite_p/Ca_HVA_GP GP_dendrite_p/Ca_GP_conc I_Ca Ik
        addmsg GP_dendrite_p/Ca_GP_conc GP_dendrite_p/Ca_HVA_GP CONCEN Ca
        addmsg GP_dendrite_p/Ca_GP_conc GP_dendrite_p/K_ahp_GP CONCEN Ca
        addmsg GP_dendrite_p/Ca_GP_conc GP_dendrite_p/Ca_GP_nernst CIN Ca
        addmsg GP_dendrite_p/Ca_GP_nernst GP_dendrite_p/Ca_HVA_GP EK E
        setfield GP_dendrite_p/Ca_GP_conc B {{B_Ca_GP_conc}/shell_vol}

        copy Na_fast_GP GP_dendrite_p/Na_fast_GP
        addmsg GP_dendrite_p GP_dendrite_p/Na_fast_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Na_fast_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Na_fast_GP Gbar  \
                {{G_Na_fast_GP}*surf*{G_mult_NaF_dend}*{G_mult}}

        copy Na_slow_GP GP_dendrite_p/Na_slow_GP
        addmsg GP_dendrite_p GP_dendrite_p/Na_slow_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Na_slow_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Na_slow_GP Gbar  \
                {{G_Na_slow_GP}*surf*{G_mult_NaS_dend}*{G_mult}}

        copy Kv3_GP GP_dendrite_p/Kv3_GP
        addmsg GP_dendrite_p GP_dendrite_p/Kv3_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Kv3_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Kv3_GP Gbar      \
                {{G_Kv3_GP}*surf*{G_mult_KV3_dend}*{G_mult}}

        copy Kv2_GP GP_dendrite_p/Kv2_GP
        addmsg GP_dendrite_p GP_dendrite_p/Kv2_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Kv2_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Kv2_GP Gbar      \
                {{G_Kv2_GP}*surf*{G_mult_KV2_dend}*{G_mult}}

        copy Kv4_fast_GP GP_dendrite_p/Kv4_fast_GP
        addmsg GP_dendrite_p GP_dendrite_p/Kv4_fast_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Kv4_fast_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Kv4_fast_GP Gbar \
                {{G_Kv4_fast_GP}*surf*{G_mult_KA_dend}*{G_mult}}

        copy Kv4_slow_GP GP_dendrite_p/Kv4_slow_GP
        addmsg GP_dendrite_p GP_dendrite_p/Kv4_slow_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Kv4_slow_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Kv4_slow_GP Gbar \
                {{G_Kv4_slow_GP}*surf*{G_mult_KA_dend}*{G_mult}}

        copy KCNQ_GP GP_dendrite_p/KCNQ_GP
        addmsg GP_dendrite_p GP_dendrite_p/KCNQ_GP VOLTAGE Vm
        addmsg GP_dendrite_p/KCNQ_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/KCNQ_GP Gbar     \
                {{G_KCNQ_GP}*surf*{G_mult_KCNQ_dend}*{G_mult}}

        copy h_HCN_GP GP_dendrite_p/h_HCN_GP
        addmsg GP_dendrite_p GP_dendrite_p/h_HCN_GP VOLTAGE Vm
        addmsg GP_dendrite_p/h_HCN_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/h_HCN_GP Gbar    \
                {{G_h_HCN_GP}*surf*{G_mult_HCN_dend}*{G_mult}}

        copy h_HCN2_GP GP_dendrite_p/h_HCN2_GP
        addmsg GP_dendrite_p GP_dendrite_p/h_HCN2_GP VOLTAGE Vm
        addmsg GP_dendrite_p/h_HCN2_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/h_HCN2_GP Gbar   \
                {{G_h_HCN2_GP}*surf*{G_mult_HCN_dend}*{G_mult}}
