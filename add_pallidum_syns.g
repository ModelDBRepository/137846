// Modified 08/04/2004: if statements for pallidum_rate == 0 condition added.

/*script to add synapses to GP model*/

randseed {rseed_GP} 
int i
float d,l,surf
str pallidumcompartment

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/pallidum
create neutral /inputs/pallidum/soma

copy /library/GABA_GP {cellpath}/soma/GABA_GP
addmsg  {cellpath}/soma/GABA_GP {cellpath}/soma CHANNEL Gk Ek
addmsg  {cellpath}/soma {cellpath}/soma/GABA_GP VOLTAGE Vm

for (i = 1; i <= {num_pallidal}; i = i + 1)
	create timetable /inputs/pallidum/soma/timetable[{i}]
	if ({pallidum_rate} > 0)
           setfield /inputs/pallidum/soma/timetable[{i}]		\
           	maxtime 200 act_val 1.0 method 2                 	\
        	meth_desc1 {1/{pallidum_rate}} meth_desc2 0.005 meth_desc3 3
        	call /inputs/pallidum/soma/timetable[{i}] TABFILL 
	end
	
	//set up spikegen
        create spikegen /inputs/pallidum/soma/spikegen[{i}]
        setfield /inputs/pallidum/soma/spikegen[{i}]			\
                output_amp 1 thresh 0.5
		
        //connect timetables to GABA synapses
	if (({pallidum_rate} > 0) && ({isa leakage {cellpath}/soma/GABA_GP} != 1))
        	addmsg /inputs/pallidum/soma/timetable[{i}] 		\
			/inputs/pallidum/soma/spikegen[{i}] INPUT activation
        	addmsg /inputs/pallidum/soma/spikegen[{i}] 		\
                	{cellpath}/soma/GABA_GP SPIKE
	end
end


