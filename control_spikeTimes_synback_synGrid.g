
//default spike times to be overwritten with values read from control asci spiketime files

float spike1time = 10000.5
float spike2time = 10000.7
float spike3time = 10000.9
float spike4time = 10000.11
float spike5time = 10000.13
float spike6time = 10000.15

if ({snapgate}==0)
    if (! {{stimMag}*100}==0)
        if ({stimType}==1)
            str controlfilename = "/home/nschult/GP/run_paper2/control_spiketimes/" @ "0_pA_" @ {strStimLoc} @ {spikeIdx} @ "_spikeIdx_" @ {syngain} @ "_syngain_" @ {STN_rate} @ "_STNrate_" @ {striatum_rate} @ "_STRIATUMrate_" @ {spiCurDist} @ "_dist_" @ {Eshift} @ "_Eshift_" @ {dendSpiCurMult} @ "_dendIspikeMult_" @ {NaPdendmult} @ "_NaPdendmult_" @ {SKsomaMult} @ "_SKsomaX_" @ {SKdendMult} @ "_SKdendX_" @ {stimType} @ {strStim} @ "GPbase_baseModels_SynBackControl_spikehistory.asci"
        else
            str controlfilename = "/home/nschult/GP/run_paper2/control_spiketimes/" @ "0_pS_" @ {strStimLoc} @ {spikeIdx} @ "_spikeIdx_" @ {syngain} @ "_syngain_" @ {STN_rate} @ "_STNrate_" @ {striatum_rate} @ "_STRIATUMrate_" @ {spiCurDist} @ "_dist_" @ {Eshift} @ "_Eshift_" @ {dendSpiCurMult} @ "_dendIspikeMult_" @ {NaPdendmult} @ "_NaPdendmult_" @ {SKsomaMult} @ "_SKsomaX_" @ {SKdendMult} @ "_SKdendX_" @ {stimType} @ {strStim} @ "GPbase_baseModels_SynBackControl_spikehistory.asci" 
        end
        openfile {controlfilename} r
        spike1time = {1000*({getarg {readfile {controlfilename}} -arg 2})}
        for(i=0; i<=4; i=i+1)
            if ({i}==1)
                spike2time = {1000*({getarg {readfile {controlfilename}} -arg 2})}
            end
            if ({i}==2)
                spike3time = {1000*({getarg {readfile {controlfilename}} -arg 2})}
            end
            if ({i}==3)
                spike4time = {1000*({getarg {readfile {controlfilename}} -arg 2})}
            end
        end
        closefile {controlfilename}
    end
end

echo
echo control spike1time is {spike1time}
echo control spike2time is {spike2time}
echo control spike3time is {spike3time}
echo control spike4time is {spike4time}
echo control spike5time is {spike5time}
echo control spike6time is {spike6time}
echo
