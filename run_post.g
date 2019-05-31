// GENESIS SETUP FILE

silent

int i
str tstr, hstr, readcompartment


//initialize parameters
include ../common/genesis_funcs_nws.g
include ../common/GP1_defaults_nws_syn.g
//include ../common/simdefaults.g
//include ../common/simdefaults_NaF_art.g
include ../common/simdefaults_synBack.g

/* COMMENT
ALL intrinsic model params have now been initialized and set. 
They can be safely overwritten any time between now and the calling of
the make_GP_library file. Once the library has been created, parameter values
are set and cannot be changed except with explicit calls to setfield.
*/



int i
str tstr, hstr, readcompartment

//PARAMETERS:
float stimType = //set from parameter file
// 1, 2, 3, 4, or 5 for CIP, uniform EXC synaptic, uniform INH synaptic, weighted EXC synaptic, weighted INH synaptic

float stimMag = //set from parameter file
// in pA if CIP or pS if synaptic

float stimInterval = //set from parameter file

float stimDur = //set from parameter file
// unneccessary if stimType is synaptic

float stimComptsIdx = //set from parameter file
// a number reflecting a list of compartments receiving the stimulus
// (either soma, or a subset of dendritic compts)

//float modelType = {getarg {arglist {parrow}} -arg 6}
float modelType = 3
// 1 or 2 for nonspiking or spiking

float currentComptsIdx = //set from parameter file
// a number reflecting the grouping of compartment conductances to be saved
// 1 for FULL, 2 for THIRDS, 3 for SUB, etc.

float voltageComptsIdx = //set from parameter file
// a number reflecting the group of compartment voltages to be saved

float HVA_PRC_scalefac = //set from parameter file

float SK_PRC_scalefac = //set from parameter file

//float KV4F_PRC_scalefac = {getarg {arglist {parrow}} -arg 11}
float KV4F_PRC_scalefac = 1

//float KV4S_PRC_scalefac = {getarg {arglist {parrow}} -arg 12}
float KV4S_PRC_scalefac = 1

float store_mode = //set from parameter file
store_mode = 2

STN_rate = //set from parameter file

striatum_rate = //set from parameter file

// 0 is asynchronous and 1 is synchronous
//float synBack_synch = {getarg {arglist {parrow}} -arg 14}
float synBack_synch = 0

float spikeIdx = //set from parameter file
//spikeIdx = ({spikeIdx}+25)

float syngain = //set from parameter file

float NaF_base = //set from parameter file

float NaP_base = //set from parameter file

float KV2_base = //set from parameter file

//float KV3_base = {KV2_base}
float KV3_base = //set from parameter file
//KV3_base = ({KV2_base}*10)

float KV4_base = //set from parameter file
// Start with 75

float HVA_base = //set from parameter file

float SK_base = //set from parameter file

float KCNQ_base = //set from parameter file

float spiCurDist = //set from parameter file
//float spiCurDist = 11.11111
spiCurDist = ({spiCurDist}/100)

float dendSpiCurMult = //set from parameter file

float NaPdendmult = //set from parameter file

//float NaISMult = {getarg {arglist {parrow}} -arg 25}
float NaISMult = 57

//float KdrISMult = {getarg {arglist {parrow}} -arg 26}
float KdrISMult = 40

float SKsomaMult = //set from parameter file

float SKdendMult = //set from parameter file

//float NaF_dq10_m = {getarg {arglist {parrow}} -arg 22}
float NaF_dq10_m = .25
float dq10_NaF_m = {NaF_dq10_m}

//float NaF_dq10_h1 = {getarg {arglist {parrow}} -arg 23}
float NaF_dq10_h1 = .6667
float dq10_NaF_h1 = {NaF_dq10_h1}

//float NaF_dq10_h2 = {getarg {arglist {parrow}} -arg 24}
float NaF_dq10_h2 = 1
float dq10_NaF_h2 = {NaF_dq10_h2}

//float KV2_taunDiv = {getarg {arglist {parrow}} -arg 26}
float KV2_taunDiv = 1

//float KV3_taunDiv = {getarg {arglist {parrow}} -arg 27}
float KV3_taunDiv = 1

//float KV4_taunDiv = {getarg {arglist {parrow}} -arg 28}
float KV4_taunDiv = 1

//float Eshift = {getarg {arglist {parrow}} -arg 28}
//float Eshift = 0
float Eshift = {getarg {arglist {parrow}} -arg 28}
echo
echo Eshift is {Eshift} mV
echo
Eshift = {Eshift}/1000

//float constcurr_loc = {getarg {arglist {parrow}} -arg 28}
float constcurr_loc = 1

//float NaPdendmult = {getarg {arglist {parrow}} -arg 27}

E_AMPA            = 0+{Eshift}
E_NMDA            = 0+{Eshift}
E_GABA            = -0.080+{Eshift}


float GsynMult = 0
float Esyn = -0.06
float Rmembr = {RM_sd}
float Gcomb = ({GsynMult}+1)*(1/{Rmembr})

float Ecomb = ({ELEAK_sd}+{GsynMult}*{Esyn})/({GsynMult}+1)

RM_sd = 1/{Gcomb}
//RM_ax = 1/{Gcomb}
ELEAK_sd = {Ecomb}
//ELEAK_ax = {Ecomb}



echo
echo spikeidx {spikeIdx}
echo syngain {syngain}
echo

include ../common/calc_syn_integ.g
float unitary_gSTN = {calc_syn_integ 250 .001 .003}
echo unitary_gSTN is {unitary_gSTN}
float unitary_gSTR = {calc_syn_integ 250 .0005 .00491}
echo unitary_gSTR is {unitary_gSTR}

//quit


float snapgate = 0

if ({snapgate}==1)
    str out_dir = "/data/snapshots/simData_synGrid_alldata/"
    str spktime_dest_dir = "/data/snapshots/spiketimes_synGrid_alldata/"
    mkdir {spktime_dest_dir}
    mkdir {out_dir}
else
    str out_dir = "/data/simData_synGrid_alldata/"
    str spktime_dest_dir = "/data/spiketimes_synGrid_alldata/"
    mkdir {spktime_dest_dir}
    mkdir {out_dir}
end

if ({store_mode}==1)
    str strStoreMode = "currents_"
end
if ({store_mode}==2)
    str strStoreMode = "conductances_"
end

// use conductance scalefacs from par file to set multipliers
include ../common/g_mult_PRC2


// Nonspiking or spiking model?  Include appropriate passive or active parameters:
if ({modelType}==1)
    include ../common/paspars.g
    str strModel = "_nonspiking_"
end
if ({modelType}==2)
    include ../common/actpars.g
    str strModel = "_spiking_"
end
if ({modelType}==3)
//    include ../common/varpars_newGP_dendNaP.g
    include ../common/varpars_GPbase_synback.g
    str strModel = "_GPbase_"
end


// stimComptsNum reflects the number of compartments receiving a stimulus
float stimComptsNum
if ({stimComptsIdx}==1)
    include ../common/stimComptsIdxs1toTen
else
    include ../common/stimComptsIdxs11toSeventeen
end


if ({stimType}==1)
    str strStim = "_cipStim_"
end
if ({stimType}==2)
    str strStim = "_EXCsynStim_"
end
if ({stimType}==3)
    str strStim = "_INHsynStim_"
end

// include list of control spike times for calculation of stimTimes:
//include ../common/dendComptGroups/control_spikeTimes_PRC
//include ../common/dendComptGroups/control_spikeTimes_dendComptGroups
//include ../common/control_spikeTimes_GPbase_synback_oscillator
//include ../common/control_spikeTimes_GPbase_synback_Eshift
//include ../common/control_spikeTimes_synback_Eshift_CNS09_paper2
include ../common/control_spikeTimes_synback_synGrid


// if CIP stimulus:
if ({stimType}==1)
    float cip = {stimMag}
    cip = {cip}/{stimComptsNum}
    float cipTime = {{spike1time}+{{({stimInterval}-1)}*{({spike2time}-{spike1time})}/72}}
    echo
    echo Stimulus time is {cipTime}
    float cipDur = {stimDur}
    echo The current injected into each compartment of {strStimLoc} is {cip} pA
    echo
else

//if synaptic stimulation:
    float Gmax_PRC = {stimMag}
    Gmax_PRC = {Gmax_PRC}/((1e12)*{stimComptsNum})
    float synTime = {spike1time} + {{({stimInterval}-1)}*{({spike2time}-{spike1time})}/72}
end


// Now that all params have been established, create library objects.
//	Intrinsic params should be left alone from this point forward.
echo
echo cci is {currentComptsIdx}
echo

include ../common/make_GP_library_NaF_art.g



//filename based on variable parameters (don't include path!)
if ({stimType}==1) 
    if ({stimMag}==0)
        str basefilename = {stimMag} @ "_pA_" @ {strStimLoc} @ {spikeIdx} @ "_spikeIdx_" @ {syngain} @ "_syngain_" @ {STN_rate} @ "_STNrate_" @ {striatum_rate} @ "_STRIATUMrate_" @ {spiCurDist} @ "_dist_" @ {Eshift} @ "_Eshift_" @ {dendSpiCurMult} @ "_dendIspikeMult_" @ {NaPdendmult} @ "_NaPdendmult_" @ {SKsomaMult} @ "_SKsomaX_" @ {SKdendMult} @ "_SKdendX_" @ {stimType} @ {strStim} @ "GPbase_baseModels_SynBackControl_"
    else
        str basefilename = {pad_num_gen {stimInterval} 3} @ "_stimInt_" @ {stimMag} @ "_pA_" @ {cipTime} @ "_msTime_" @ {cipDur} @ "_msDur" @ {strStimLoc} @ {spikeIdx} @ "_spikeIdx_" @ {syngain} @ "_syngain_" @ {STN_rate} @ "_STNrate_" @ {striatum_rate} @ "_STRIATUMrate_" @ {spiCurDist} @ "_dist_" @ {Eshift} @ "_Eshift_" @ {dendSpiCurMult} @ "_dendIspikeMult_" @ {NaPdendmult} @ "_NaPdendmult_" @ {SKsomaMult} @ "_SKsomaX_" @ {SKdendMult} @ "_SKdendX_" @ {stimType} @ {strStim} @ "GPbase_baseModels_SynBack_"
    end
end
if (! ({stimType}==1))
    if ({stimMag}==0)
        str basefilename = {stimMag} @ "_pS_" @ {strStimLoc} @ {spikeIdx} @ "_spikeIdx_" @ {syngain} @ "_syngain_" @ {STN_rate} @ "_STNrate_" @ {striatum_rate} @ "_STRIATUMrate_" @ {spiCurDist} @ "_dist_" @ {Eshift} @ "_Eshift_" @ {dendSpiCurMult} @ "_dendIspikeMult_" @ {NaPdendmult} @ "_NaPdendmult_" @ {SKsomaMult} @ "_SKsomaX_" @ {SKdendMult} @ "_SKdendX_" @ {stimType} @ {strStim} @ "GPbase_baseModels_SynBackControl_"
    else
        str basefilename = {pad_num_gen {stimInterval} 3} @ "_stimInt_" @ {stimMag} @ "_pS_" @ {synTime} @ "_msTime_" @ {stimDur} @ "_msDur" @ {strStimLoc} @ {spikeIdx} @ "_spikeIdx_" @ {syngain} @ "_syngain_" @ {STN_rate} @ "_STNrate_" @ {striatum_rate} @ "_STRIATUMrate_" @ {spiCurDist} @ "_dist_" @ {Eshift} @ "_Eshift_" @ {dendSpiCurMult} @ "_dendIspikeMult_" @ {NaPdendmult} @ "_NaPdendmult_" @ {SKsomaMult} @ "_SKsomaX_" @ {SKdendMult} @ "_SKdendX_" @ {stimType} @ {strStim} @ "GPbase_baseModels_SynBack_"
    end
end

if ({currentComptsIdx}==4)
    str strCurrentsLoc = {currentComptsIdx} @ "_dend1" @ {strStoreMode}
    str strCaLoc = {currentComptsIdx} @ "_dend1calcium_"
end
if ({currentComptsIdx}==5)
    str strCurrentsLoc = {currentComptsIdx} @ "_dend2" @ {strStoreMode}
    str strCaLoc = {currentComptsIdx} @ "_dend2calcium_"
end
if ({currentComptsIdx}==6)
    str strCurrentsLoc = {currentComptsIdx} @ "_dend3" @ {strStoreMode}
    str strCaLoc = {currentComptsIdx} @ "_dend3calcium_"
end

if ({voltageComptsIdx}==1)
    str strVoltagesLoc = {voltageComptsIdx} @ "_somaVm_"
end
if ({voltageComptsIdx}==2)
    str strVoltagesLoc = {voltageComptsIdx} @ "_stimlocVms_"
end
if ({voltageComptsIdx}==3)
    str strVoltagesLoc = {voltageComptsIdx} @ "_dend1voltages_"
end
if ({voltageComptsIdx}==4)
    str strVoltagesLoc = {voltageComptsIdx} @ "_dend2voltages_"
end
if ({voltageComptsIdx}==5)
    str strVoltagesLoc = {voltageComptsIdx} @ "_dend3voltages_"
end



echo {basefilename}
str filename_v = {basefilename} @ {strVoltagesLoc} @ "v.bin"
str filename_gtot = {basefilename} @ {strCurrentsLoc} @ "itot.bin"
str filename_ca = {basefilename} @ {strCaLoc} @ "ca.bin"
str filename_gsyns = {basefilename} @ "_gsyns.bin"
str filename_mhhnn = {basefilename} @ "mhhnn.bin"

dt = 2e-5
if ({snapgate}==1)
    dt = 1e-5
    echo
    echo This should not be happening except for snapshot simulations!!!!!!!
    echo
end
//set up clocks
setclock 0 {dt}	  	// simulation
//output set to 1e-4 under normal circumstances
setclock 1 {1e-4} 	// output
//rundur = 13.5		// simulation length
//rundur = {({spike6time}/1000)+(.05)}
rundur=1
if ({snapgate}==1)
    rundur = 10
end
if (({snapgate}==0) & ({stimMag}==0))
    rundur = 2
end

//load compartments with ion channels
//if ({currentComptsIdx}==1)
//    readcell ../common/GP1/GP1_FULLdendsort.p {cellpath} -hsolve
//end
//if ({currentComptsIdx}==2)
//    readcell ../common/GP1/GP1_THIRDSdendsort.p {cellpath} -hsolve
//end
//if ({currentComptsIdx}==3)
//    readcell ../common/GP1/GP1_SUBdendsort.p {cellpath} -hsolve
//end
if (({currentComptsIdx}>=4) & ({currentComptsIdx}<=6))
    readcell ../common/GP1_dendComptGroups.p {cellpath} -hsolve
end



//add synapses to appropriate compartments	
include ../common/read_STN_nocluster_ratescaled_nws_Kopell

/*
if ({currentComptsIdx}==1)
    include ../common/read_clusters_FULLdendsort
end
if ({currentComptsIdx}==2)
    include ../common/read_clusters_THIRDSdendsort
end
if ({currentComptsIdx}==3)
    include ../common/read_clusters_SUBdendsort
end
if (({currentComptsIdx}>=4) & ({currentComptsIdx}<=6))
    include ../common/read_clusters_dendComptGroups
end
*/

include ../common/read_striatum_syns_ratescaled_nws_Kopell
include ../common/add_pallidum_syns

create pulsegen /constantcurrent
    setfield /constantcurrent \
            level1          {0e-12}  \
            width1          11       \
            delay1          0            \
            delay2          50      \
            baselevel       0   \
            trig_mode       0

str readcompartment
if ({constcurr_loc}==1)
    str constcurr_filename = "../common/comptlists/constcurr_soma.txt"
end
if ({constcurr_loc}==2)
    str constcurr_filename = "../common/comptlists/constcurr_axIS.txt"
end
openfile {constcurr_filename} r
readcompartment = {readfile {constcurr_filename}}
while (! {eof {constcurr_filename}})
    addmsg /constantcurrent {cellpath}/{readcompartment} INJECT output
    readcompartment = {readfile {constcurr_filename}}
end
closefile {constcurr_filename}

//set up current injection
if ({stimType}==1)
    create pulsegen /pulse
    setfield /pulse \
            level1          {{cip}*1e-12}  \
            width1          {{cipDur}*1e-3}       \
            delay1          {{cipTime}*1e-3}      	\
            delay2          50      \
            baselevel       0 	\
            trig_mode       0
    
    // NWS: add msg with while loop to distribute CIP
    str readcompartment
    if ({stimComptsIdx}==1)
        str CIPfilename = "../common/comptlists/nws_soma_only.txt"
    end
    if ({stimComptsIdx}==2)
        str CIPfilename = "../common/comptlists/nws_proximal_FULLdendcompts.txt"
    end
    if ({stimComptsIdx}==3)
        str CIPfilename = "../common/comptlists/nws_mid_FULLdendcompts.txt"
    end
    if ({stimComptsIdx}==4)
        str CIPfilename = "../common/comptlists/nws_distal_FULLdendcompts.txt"
    end
    if ({stimComptsIdx}==5)
        str CIPfilename = "../common/comptlists/nws_proximal_THIRDSdendcompts.txt"
    end
    if ({stimComptsIdx}==6)
        str CIPfilename = "../common/comptlists/nws_mid_THIRDSdendcompts.txt"
    end
    if ({stimComptsIdx}==7)
        str CIPfilename = "../common/comptlists/nws_distal_THIRDSdendcompts.txt"
    end
    if ({stimComptsIdx}==8)
        str CIPfilename = "../common/comptlists/nws_proximal_SUBdendcompts.txt"
    end
    if ({stimComptsIdx}==9)
        str CIPfilename = "../common/comptlists/nws_mid_SUBdendcompts.txt"
    end
    if ({stimComptsIdx}==10)
        str CIPfilename = "../common/comptlists/nws_distal_SUBdendcompts.txt"
    end

    if ({stimComptsIdx}==11)
        str CIPfilename = "../common/comptlists/dend1_proximal25compts.txt"
    end
    if ({stimComptsIdx}==12)
        str CIPfilename = "../common/comptlists/dend1_distal25compts.txt"
    end
    if ({stimComptsIdx}==13)
        str CIPfilename = "../common/comptlists/dend2_proximal25compts.txt"
    end
    if ({stimComptsIdx}==14)
        str CIPfilename = "../common/comptlists/dend2_distal25compts.txt"
    end
    if ({stimComptsIdx}==15)
        str CIPfilename = "../common/comptlists/dend3_proximal25compts.txt"
    end
    if ({stimComptsIdx}==16)
        str CIPfilename = "../common/comptlists/dend3_mid25compts.txt"
    end
    if ({stimComptsIdx}==17)
        str CIPfilename = "../common/comptlists/dend3_distal25compts.txt"
    end


    openfile {CIPfilename} r
    readcompartment = {readfile {CIPfilename}}
    while (! {eof {CIPfilename}})
        addmsg /pulse {cellpath}/{readcompartment} INJECT output
        readcompartment = {readfile {CIPfilename}}
    end
    closefile {CIPfilename}
end

//default valence (not used with CIP)
if ({stimType}==1)
    str valence = "AMPA"
end
if ({stimType}==2 || {stimType}==4)
    str valence = "AMPA"
end
if ({stimType}==3 || {stimType}==5)
    str valence = "GABA"
end
if ({stimType}==1)
    include ../common/PRCsynDend_CIP
else
    include ../common/PRCsynDend
end



silent -1
//set up hines solver
setfield {cellpath}							\
	path {cellpath}/##[][TYPE=compartment] 	\
        comptmode       1 			\
        chanmode        4 			\
        calcmode        0 			\
        outclock        1 			\
        storemode       {store_mode}
        call {cellpath} SETUP
        setmethod 11



//set up outputs
create disk_out /out_v
useclock /out_v 1
setfield /out_v filename {{out_dir} @ {filename_v}} flush 0 append 0 leave_open 1




create disk_out /out_gsyns
useclock /out_gsyns 1
setfield /out_gsyns filename {{out_dir} @ {filename_gsyns}} flush 0 append 0 leave_open 1



// NWS for simulations with tiny timestep when itot isn't needed, comment out:

create disk_out /out_gtot
useclock /out_gtot 1
setfield /out_gtot filename {{out_dir} @ {filename_gtot}} flush 0 append 0 leave_open 1


create disk_out /out_ca
useclock /out_ca 1
setfield /out_ca filename {{out_dir} @ {filename_ca}} flush 0 append 0 leave_open 1


/*
//save Vm of selected compartments to file: soma, axon, dends
int n
openfile {outputcompsfname} r
readcompartment = {readfile {outputcompsfname}}
while (! {eof {outputcompsfname}})
	hstr={findsolvefield {cellpath} {cellpath}/{readcompartment} Vm}
	addmsg {cellpath} /out_v SAVE {hstr}
	readcompartment = {readfile {outputcompsfname}}
end
closefile {outputcompsfname}
*/



// Save Vm for a sample of compartments
if ({voltageComptsIdx}==1)
    str voltageCompts = "../common/comptlists/nws_soma_only.txt"
    str calciumCompts = "../common/comptlists/nws_soma_only.txt"
end
if ({voltageComptsIdx}==2)
    str voltageCompts = "../common/comptlists/nws_stimloc_subset.txt"
    str calciumCompts = "../common/comptlists/nws_noCaConc_in_ax.txt"
end
if ({voltageComptsIdx}==3)
    str voltageCompts = "../common/comptlists/save_dend1voltageCompts.txt"
    str calciumCompts = "../common/comptlists/save_dend1calciumCompts.txt"
end
if ({voltageComptsIdx}==4)
    str voltageCompts = "../common/comptlists/save_dend2voltageCompts.txt"
    str calciumCompts = "../common/comptlists/save_dend2calciumCompts.txt"
end
if ({voltageComptsIdx}==5)
    str voltageCompts = "../common/comptlists/save_dend3voltageCompts.txt"
    str calciumCompts = "../common/comptlists/save_dend3calciumCompts.txt"
end


openfile {voltageCompts} r
readcompartment = {readfile {voltageCompts}}
while(! {eof {voltageCompts}})
        // Vm
        hstr={findsolvefield {cellpath} {cellpath}/{readcompartment} Vm}
        addmsg {cellpath} /out_v SAVE {hstr}

        // Gsyn
        //hstr={findsolvefield {cellpath} {cellpath}/{readcompartment}/AMPA Gk}
        //addmsg {cellpath} /out_gsyns SAVE {hstr}

        // Get next compt name
        readcompartment = {readfile {voltageCompts}}
end

/*
USED THIS FOR POST-KOPELL WORKSHOP
create disk_out /out_mhhnn
useclock /out_mhhnn 1
setfield /out_mhhnn filename {{out_dir} @ {filename_mhhnn}} flush 0 append 0 leave_open 1
hstr = {findsolvefield {cellpath} {cellpath}/soma Vm}
addmsg {cellpath} /out_mhhnn SAVE {hstr}
//echo {showfield {cellpath}/soma *}
//echo {le {cellpath}/soma/ *}
//echo {showfield {cellpath}/soma/Na_fast_GP_somahill *}
hstr = {findsolvefield {cellpath} {cellpath}/soma/Na_fast_GP_somahill X}
addmsg {cellpath} /out_mhhnn SAVE {hstr}
hstr = {findsolvefield {cellpath} {cellpath}/soma/Na_fast_GP_somahill Y}
addmsg {cellpath} /out_mhhnn SAVE {hstr}
hstr = {findsolvefield {cellpath} {cellpath}/soma/Na_fast_GP_somahill Z}
addmsg {cellpath} /out_mhhnn SAVE {hstr}
hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv3_GP_somahill X}
addmsg {cellpath} /out_mhhnn SAVE {hstr}
hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv2_GP_somahill X}
addmsg {cellpath} /out_mhhnn SAVE {hstr}
*/


create neutral /PRCspiketimes
create spikegen /PRCspiketimes/soma_spikegen

setfield /PRCspiketimes/soma_spikegen        \
    output_amp 1 thresh 0 abs_refract .002
hstr={findsolvefield {cellpath} {cellpath}/soma Vm}
addmsg {cellpath} /PRCspiketimes/soma_spikegen INPUT {hstr}

create spikehistory /PRCspiketimes/soma_spikehistory
setfield /PRCspiketimes/soma_spikehistory    \
    filename {{spktime_dest_dir} @ {basefilename} @ "spikehistory.asci"}    \
    initialize 1 leave_open 1 flush 1 ident_toggle 1
 
addmsg /PRCspiketimes/soma_spikegen /PRCspiketimes/soma_spikehistory SPIKESAVE
call /PRCspiketimes/soma_spikehistory RESET
echo {showfield /PRCspiketimes/soma_spikehistory *}



//IF WE DO THE 'ENTRAINMENT TO PERIODIC STN INPUT EXPERIMENT', THIS WILL GET USED
// Save Gsyn AND Vm for every STN synapse to file
openfile {STNfilename} r
readcompartment = {readfile {STNfilename}}
while(! {eof {STNfilename}})
	// Vm
	hstr={findsolvefield {cellpath} {cellpath}/{readcompartment} Vm}
	addmsg {cellpath} /out_v SAVE {hstr}

	// Gsyn
	hstr={findsolvefield {cellpath} {cellpath}/{readcompartment}/AMPA Gk}
	addmsg {cellpath} /out_gsyns SAVE {hstr}

	// Get next compt name
	readcompartment = {readfile {STNfilename}}
end


// save the selected total conductances or currents into filename_g
// commented out when not saving itot
/*
if ({currentComptsIdx}==4)
    // stimulus to dendrite 1
    for(i=0; i<=0; i=i+1)
        addmsg {cellpath} /out_gtot SAVE itotal[{i}]
    end
    for(i=71; i<=92; i=i+1)
        addmsg {cellpath} /out_gtot SAVE itotal[{i}]
    end
    for(i=106; i<=117; i=i+1)
        addmsg {cellpath} /out_gtot SAVE itotal[{i}]
    end
end
if ({currentComptsIdx}==5)
    //stimulus to dendrite 2
    for(i=0; i<=0; i=i+1)
        addmsg {cellpath} /out_gtot SAVE itotal[{i}]
    end
    for(i=49; i<=70; i=i+1)
        addmsg {cellpath} /out_gtot SAVE itotal[{i}]
    end
    for(i=106; i<=117; i=i+1)
        addmsg {cellpath} /out_gtot SAVE itotal[{i}]
    end
end
if ({currentComptsIdx}==6)
    // stimulus to dendrite 3
    for(i=0; i<=0; i=i+1)
        addmsg {cellpath} /out_gtot SAVE itotal[{i}]
    end
    for(i=14; i<=48; i=i+1)
        addmsg {cellpath} /out_gtot SAVE itotal[{i}]
    end
    for(i=106; i<=117; i=i+1)
        addmsg {cellpath} /out_gtot SAVE itotal[{i}]
    end
end
*/



//for all currents (throughout dendrite) from dendComptGroups:
for(i=0; i<=117; i=i+1)
     addmsg {cellpath} /out_gtot SAVE itotal[{i}]
end


/*
//This block of channels to save in itot works for dend3_distal (prior to dendComptGroups)
for(i=0; i<=0; i=i+1)
     addmsg {cellpath} /out_gtot SAVE itotal[{i}]
end
for(i=14; i<=48; i=i+1)
     addmsg {cellpath} /out_gtot SAVE itotal[{i}]
end
for(i=62; i<=73; i=i+1)
     addmsg {cellpath} /out_gtot SAVE itotal[{i}]
end
*/

openfile {calciumCompts} r
readcompartment = {readfile {calciumCompts}}
while(! {eof {calciumCompts}})
        // Ca++
        hstr={findsolvefield {cellpath} {cellpath}/{readcompartment}/Ca_GP_conc Ca}
        addmsg {cellpath} /out_ca SAVE {hstr}

        // Get next compt name
        readcompartment = {readfile {calciumCompts}}
end



if ({modelType}==1)
    if ({currentComptsIdx}==1)
        str snapshotname = "../common/snapshots/nonspiking_FULLdendsort_snapshot.save"
    end
    if ({currentComptsIdx}==2)
        str snapshotname = "../common/snapshots/nonspiking_THIRDSdendsort_snapshot.save"
    end
    if ({currentComptsIdx}==3)
        str snapshotname = "../common/snapshots/nonspiking_SUBdendsort_snapshot.save"
    end
    if (({currentComptsIdx}>=4) & ({currentComptsIdx}<=6))
        str snapshotname = "../common/snapshots/dendComptGroups/synBack/Kopell/Kopell_nonspiking" @ {strStimLoc} @ {HVA_PRC_scalefac} @ "_xHVA_" @ {SK_PRC_scalefac} @ "_xSK_" @ {STN_rate} @ "_HzSTN_" @ {striatum_rate} @ "_HzSTR_" @ {synBack_synch} @ "_synch_snapshot.save"
    end
end

if ({modelType}==2)
    if ({currentComptsIdx}==1)
        str snapshotname = "../common/snapshots/spiking_FULLdendsort_snapshot.save"
    end
    if ({currentComptsIdx}==2)
        str snapshotname = "../common/snapshots/spiking_THIRDSdendsort_snapshot.save"
    end
    if ({currentComptsIdx}==3)
        str snapshotname = "../common/snapshots/spiking_SUBdendsort_snapshot.save"
    end
    if (({currentComptsIdx}>=4) & ({currentComptsIdx}<=6))
        str snapshotname = "../common/snapshots/dendComptGroups/synBack/spiking" @ {strStimLoc} @ {HVA_PRC_scalefac} @ "_xHVA_" @ {SK_PRC_scalefac} @ "_xSK_" @ {STN_rate} @ "_HzSTN_" @ {striatum_rate} @ "_HzSTR_" @ {synBack_synch} @ "_synch_" @ "snapshot.save"
    end
end

if ({modelType}==3)
    if (({currentComptsIdx}>=4) & ({currentComptsIdx}<=6))
        str snapshotname = "../common/snapshots/GP" @ {strStimLoc} @ {syngain} @ "_syngain_" @ {STN_rate} @ "_STNrate_" @ {striatum_rate} @ "_STRIATUMrate_" @ {spiCurDist} @ "_dist_" @ {Eshift} @ "_Eshift_" @ {dendSpiCurMult} @ "_dendIspikeMult_" @ {NaPdendmult} @ "_NaPdendmult_" @ {SKsomaMult} @ "_SKsomaX_" @ {SKdendMult} @ "_SKdendX" @ {strStim} @ "synback_baseModels_snapshot.save"
    end
end


echo
echo Snapshot to be made or used by this simulation is
echo {snapshotname}
echo


include ../common/snapshotGP_nws




/* for getting axial resistance of each compt:
str thiscompt
foreach thiscompt ({el {cellpath}/##[][OBJECT=compartment]})
    echo {thiscompt} {getfield {thiscompt} Ra}
end
quit
*/


/* for getting surface areas of each compt:
str thiscompt
foreach thiscompt ({el {cellpath}/##[][OBJECT=compartment]})
    echo {thiscompt} {({getfield {thiscompt} len})*({getfield {thiscompt} dia})*3.141592653589793}
end
quit
*/


include ../common/spiCurDist_echoDist.g



/*
echo somaNaFGbar {getfield /GP/soma/Na_fast_GP_somahill Gbar}
echo somaNaSGbar {getfield /GP/soma/Na_slow_GP_somahill Gbar}
echo somaKV3Gbar {getfield /GP/soma/Kv3_GP_somahill Gbar}
echo somaKV2Gbar {getfield /GP/soma/Kv2_GP_somahill Gbar}
echo somaRM {getfield /GP/soma Rm}
echo somaCM {getfield /GP/soma Cm}
*/


if ({snapgate}==1)
    reset
    step {rundur} -time
    take_snapshot
//compress data files
//    str filename_v_c = {compress_data_file {{out_dir} @ {filename_v}}}
//    str filename_gtot_c = {compress_data_file {{out_dir} @ {filename_gtot}}}
//    str filename_ca_c = {compress_data_file {{out_dir} @ {filename_ca}}}
// Copy file from temporary location (on nodes) to desired location (on /scratch)
//    mv {filename_v_c} {dest_dir}
//    mv {filename_gtot_c} {dest_dir}&
//    mv {filename_ca_c} {dest_dir}&
    quit

else
    //run the simulation
    reset
    restore_snapshot
    step {rundur} -time
//compress data files
//    str filename_v_c = {compress_data_file {{out_dir} @ {filename_v}}}
//    str filename_gtot_c = {compress_data_file {{out_dir} @ {filename_gtot}}}
//    str filename_ca_c = {compress_data_file {{out_dir} @ {filename_ca}}}
// Copy file from temporary location (on nodes) to desired location (on /scratch)
//    mv {filename_v_c} {dest_dir}
//    mv {filename_gtot_c} {dest_dir}&
//    mv {filename_ca_c} {dest_dir}&

    quit

end

