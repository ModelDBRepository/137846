//actpars - set conductance densities for the non-spiking dendrite model
//	Any param value can be overwritten subsequently.
// THIS VERSION CURRENT 08/09/2005 to present.

str snapshotname = {snapshot_pas}

//Voltage-gated ion channel densities
//float G_Na_fast_GP  	= 350 	 
float G_Na_fast_GP      = {NaF_base}
//float G_Na_slow_GP  	= 1.015*{NaP_globalMult}
float G_Na_slow_GP	= {NaP_base}
//float G_Kv3_GP  	= 11.25
float G_Kv3_GP		= {KV3_base}
//float G_Kv2_GP	= 1
float G_Kv2_GP  	= {KV2_base}

//float G_Kv4_fast_GP     = 100
//float G_Kv4_fast_GP     = 75
//float G_Kv4_fast_GP     = 35
//float G_Kv4_fast_GP     = 20
float G_Kv4_fast_GP 	= {KV4_base}
float G_Kv4_slow_GP = {G_Kv4_fast_GP}*1.5

//float G_KCNQ_GP 	= 2
float G_KCNQ_GP         = {KCNQ_base}
//float G_Ca_HVA_GP   	= 0.3	
float G_Ca_HVA_GP     = {HVA_base}
//float G_K_ahp_GP    	= 4
float G_K_ahp_GP        = {SK_base}
float G_h_HCN_GP    	= 0.2
float G_h_HCN2_GP   	= {G_h_HCN_GP}*2.5

//Multipliers for conductance densities
float G_mult 		= 1

//Surface areas of soma and total dendrite
float initSegSA = 9.424777960769378e-11
float somaSA = 5.641043768785834e-10
float dendSA = 7.402779507244005e-9
float axhillSA = 7.461282552275759e-11
float somahillSA = somaSA + axhillSA
float dendSomaSAratio = dendSA/somahillSA
float ISsomaSAratio = initSegSA/somahillSA
echo
echo dendSomaSAratio is {dendSomaSAratio}
echo

//G_mult_Na_dend broken into NaF and NaS
float G_mult_NaF_dend   = {spiCurDist}*{dendSpiCurMult}
float G_mult_NaS_dend   = {spiCurDist}*{dendSpiCurMult}*{NaPdendmult}

//G_mult_Kdr_dend broken into KV3 and KV2
float G_mult_KV3_dend   = spiCurDist*{dendSpiCurMult}
float G_mult_KV2_dend   = spiCurDist*{dendSpiCurMult}

float G_mult_KA_dend   	= 2
float G_mult_KCNQ_dend	= 1
//float G_mult_SK_dend	= 0.87
float G_mult_SK_dend    = {SKdendMult}
float G_mult_Ca_dend 	= 0.44
float G_mult_HCN_dend	= 1

//G_mult_Na_soma broken into NaF and NaS
//float G_mult_NaF_soma   = ((23 - (dendSomaSAratio*spiCurDist))*spiCurDiv)
//float G_mult_NaS_soma   = ((23 - (dendSomaSAratio*spiCurDist))*spiCurDiv)

//float G_mult_NaF_soma   = {(1-spiCurDist)}
//float G_mult_NaS_soma   = {(1-spiCurDist)}
float G_mult_NaF_soma   = {{(1-spiCurDist)} + ((57 - NaISMult) * ISsomaSAratio)}
float G_mult_NaS_soma   = {{(1-spiCurDist)} + ((57 - NaISMult) * ISsomaSAratio)}

//G_mult_Kdr_soma broken into KV3 and KV2
//float G_mult_KV3_soma   = ((23 - (dendSomaSAratio*spiCurDist))*spiCurDiv)
//float G_mult_KV2_soma   = ((23 - (dendSomaSAratio*spiCurDist))*spiCurDiv)

//float G_mult_KV3_soma   = {(1-spiCurDist)}
//float G_mult_KV2_soma   = {(1-spiCurDist)}
float G_mult_KV3_soma   = {{(1-spiCurDist)} + ((40 - KdrISMult) * ISsomaSAratio)}
float G_mult_KV2_soma   = {{(1-spiCurDist)} + ((40 - KdrISMult) * ISsomaSAratio)}

float G_mult_KA_soma    = 2
float G_mult_KCNQ_soma	= 5.2
float G_mult_SK_soma	= {SKsomaMult}
//float G_mult_SK_soma    = 39.6

float G_mult_Ca_soma	= 1.29

float G_mult_Na_axon 	= 57
// this one is applied to the node only
float G_mult_Kdr_axon	= 40
// this one is applied to the node only

float G_mult_Na_IS	= {NaISMult}
float G_mult_Kdr_IS	= {KdrISMult}
float G_mult_KA_axon 	= 40
float G_mult_KCNQ_axon	= 40
