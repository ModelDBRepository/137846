// In use 10/10/2004 -- present
// Add striatal synapses, but normalize rate by compartment surface area.
/* The following params must be set prior to calling this file:
	str striatumfname: file name of compartments to get striatal inputs
	int num_striatum_compts: number of compartments to get striatal inputs
	int num_striatum_per_comp: # striatal syns per selected compartment.

   All are currently initialized and set in GP$1_defaults.g, but can be
   overwritten as needed.

   Modified 10/10/2004: made the rate of each compartment's striatal inputs
   normalized by that compartment's surface area relative to the mean surface
   area for all compartments receiving striatal input. So the total number of
   events arriving at the "average" compartment = 
   {striatum_rate} * {num_striatum_per_comp}
   
   This input rate can be translated to a constant, uniform input in units of
   events / sec / micron2 by dividing {striatum_rate} * {num_striatum_per_comp}
   by the total surface area of the dendritic compartments receiving input. 
*/

if ({snapgate}==0)
    if ({synBack_synch}==0)
        randseed {({rseed_striatum_postsnap}+{spikeIdx})}
        echo
        echo post snapshot random seed is {({rseed_striatum_postsnap}+{spikeIdx})}
        echo
    end
else
//    randseed {rseed_striatum}   NWS: I think this is a mistake, there is no rseed_striatum in simdefaults
    randseed {rseed_Str}
    echo
        echo snapshot random seed is {rseed_Str}
    echo
end

 
int i
float d,l,surf
float totsurf, meansurf, thisrate
str striatumcompartment

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/striatum

// get sum total surface area of all compartments receiving striatal input
totsurf = 0
openfile {striatumfname} r
for (i = 1; i <= {num_striatum_compts}; i = i + 1)
        striatumcompartment = {readfile {striatumfname}}
	
	// get compt params
	d = {getfield {cellpath}/{striatumcompartment} dia}
	l = {getfield {cellpath}/{striatumcompartment} len}
	surf = {PI}*{l}*{d}
	totsurf = {totsurf} + {surf}
end
closefile {striatumfname}

meansurf = {totsurf}/{num_striatum_compts}
echo "Total dendritic surface area (microns2): " {{totsurf}*1e12}
echo "Mean surface area of dendritic compartments (microns2): " {{meansurf}*1e12}
echo "Total number of striatal input events per second: " {{striatum_rate}*{num_striatum_per_comp}*{num_striatum_compts}}
echo "Striatal events per second for average compartment: " {{striatum_rate}*{num_striatum_per_comp}}
echo "Striatal events per second per square micron: " {{striatum_rate}*{num_striatum_per_comp}*{num_striatum_compts}/({totsurf}*1e12)}

//cycle through each selected compartment and add synapses
openfile {striatumfname} r
//openfile "rates_GABA.asc" w
echo
echo G_GABA is {G_GABA}
echo
echo syngain is {syngain}
echo

for (i = 1; i <= {num_striatum_compts}; i = i + 1)
        striatumcompartment = {readfile {striatumfname}}
	
	// get compt params
	d = {getfield {cellpath}/{striatumcompartment} dia}
	l = {getfield {cellpath}/{striatumcompartment} len}
	surf = {PI}*{l}*{d}
	
        copy /library/GABA {cellpath}/{striatumcompartment}/GABA
        addmsg  {cellpath}/{striatumcompartment}/GABA \
                {cellpath}/{striatumcompartment} CHANNEL Gk Ek
        addmsg  {cellpath}/{striatumcompartment} \
                {cellpath}/{striatumcompartment}/GABA VOLTAGE Vm

//echo
//echo striatal gmax before is {getfield {cellpath}/{striatumcompartment}/GABA gmax}
	setfield {cellpath}/{striatumcompartment}/GABA	\
		gmax {{G_GABA}*{syngain}}
//echo striatal gmax after is {getfield {cellpath}/{striatumcompartment}/GABA gmax}
//echo 

	//set up timetables with rates scaled by compartment surface area  
	create neutral /inputs/striatum/{striatumcompartment}
        create timetable /inputs/striatum/{striatumcompartment}/timetable 
	if ({striatum_rate} > 0)
		thisrate = {striatum_rate} * {surf} / {meansurf}
//		writefile "rates_GABA.asc" {thisrate}
		setfield /inputs/striatum/{striatumcompartment}/timetable \
                     maxtime 20 act_val 1.0 method 2		\
                     meth_desc1 {1/{{thisrate}*{num_striatum_per_comp}}} \
		     meth_desc2 0 meth_desc3 3
        	call /inputs/striatum/{striatumcompartment}/timetable TABFILL
	end
	
	//set up spikegen
        create spikegen /inputs/striatum/{striatumcompartment}/spikegen
        setfield /inputs/striatum/{striatumcompartment}/spikegen	\
		output_amp 1 thresh 0.5
        //connect timetables to GABA synapses
	if ({striatum_rate} > 0)
           addmsg /inputs/striatum/{striatumcompartment}/timetable	\
		/inputs/striatum/{striatumcompartment}/spikegen INPUT activation
           addmsg /inputs/striatum/{striatumcompartment}/spikegen	\
		{cellpath}/{striatumcompartment}/GABA SPIKE
	end
end
closefile {striatumfname}
//closefile "rates_GABA.asc"

