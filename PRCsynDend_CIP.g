
//NWS: adds synapses for PRC inputs 

//NWS: type of synapses (exc or inh)
//will be overwritten in masterscript as necessary

float Gmax_PRC = 0
float synTime = 1100
float scalefacPRC,totscalePRC,meanscalePRC
int num_PRC = 0


// Get mean value of scale factors for syn inputs (PRC)

openfile {PRC_scale} r
scalefacPRC = {readfile {PRC_scale}}
totscalePRC = 0
int PRC_num = 0

while (! {eof {PRC_scale}})
        totscalePRC = {totscalePRC} + {scalefacPRC}
        PRC_num = {PRC_num} + 1
        scalefacPRC = {readfile {PRC_scale}}
end

closefile {PRC_scale}

meanscalePRC = {totscalePRC} / {PRC_num}

echo "totscalePRC: " {totscalePRC}
echo "PRC_num: " {PRC_num}
echo "meanscalePRC: " {meanscalePRC}


openfile {PRCfilename} r
str PRCcompartment = {readfile {PRCfilename}}
openfile {PRC_scale} r
scalefacPRC = {readfile {PRC_scale}}

create neutral /inputs/PRC
//setup timetable
create timetable /inputs/PRCsynsTT
call /inputs/PRCsynsTT TABCREATE 1
    setfield /inputs/PRCsynsTT                \
    *timetable {{synTime}/1000} act_val 1.0 method 3
echo "PRC timetable filled with: " {getfield /inputs/PRCsynsTT *timetable}
//cycle through PRC input compartments
while (! {eof {PRCfilename}})

        num_PRC = {num_PRC} + 1
        //Add {valence} synapses
        copy /library/{valence} {cellpath}/{PRCcompartment}/{{valence} @ "prc"}
        addmsg  {cellpath}/{PRCcompartment}/{{valence} @ "prc"} \
            {cellpath}/{PRCcompartment} CHANNEL Gk Ek
        addmsg  {cellpath}/{PRCcompartment} \
            {cellpath}/{PRCcompartment}/{{valence} @ "prc"} VOLTAGE Vm

        // scale synapse amplitude
        setfield {cellpath}/{PRCcompartment}/{{valence} @ "prc"} gmax {{Gmax_PRC}*{scalefacPRC}/({meanscalePRC})}
        echo "gmax for " {PRCcompartment} ": " {getfield {cellpath}/{PRCcompartment}/{{valence} @ "prc"} gmax}
        
        create neutral /inputs/PRC/{PRCcompartment}
        //set up spikegen
        create spikegen /inputs/PRC/{PRCcompartment}/spikegen
        setfield /inputs/PRC/{PRCcompartment}/spikegen                  \
                output_amp 1 thresh 0.5
        //connect timetables to {valence} synapses
                addmsg /inputs/PRCsynsTT \
                        /inputs/PRC/{PRCcompartment}/spikegen INPUT activation
                addmsg /inputs/PRC/{PRCcompartment}/spikegen \
                        {cellpath}/{PRCcompartment}/{{valence} @ "prc"} SPIKE

        // get next compartment name
        PRCcompartment = {readfile {PRCfilename}}
        scalefacPRC = {readfile {PRC_scale}}
        if ({eof {PRC_scale}})
                echo "eof scale"
        end
end
closefile {PRCfilename}
closefile {PRC_scale}
if ({num_PRC} != {PRC_num})
        echo "ERROR: number of PRC scale factors doesn't match number of PRC synapses."
        quit
end

