// Define simulation defaults that may need to be changed for optimization but
//	that will be the same for all morphologies and for both spiking and
//	non-spiking dendrite models.

// NaF: Fast sodium channel
// --> kinetics for 32 degrees C:


//Activation from Surmeier
//temperature correction for mtau made in GPchans 
float mpower_NaF	= 3
float Vhalfm_NaF	= -0.0388
float Km_NaF 		= 0.0073

float taummin_NaF	= 0.00004873
float taummax_NaF	= 0.000490
float V0taum_NaF        = -0.04178
float Ktaum1_NaF	= .00769
float Ktaum2_NaF	= -.02651


//Inactivation from Jeremy (NaFmod)
float hpower_NaF        = 1
float V0h_NaF           = -0.048
float Kh_NaF            = -0.0028
float tauhmin_NaF       = 0.00025
float tauhmax_NaF       = 0.004
float V0tauh_NaF        = -0.043
float Ktauh1_NaF        = 0.01
float Ktauh2_NaF        = -0.005

float spower_NaF        = 1
float mins_NaF          = 0.15
float V0s_NaF           = -0.040
float Ks_NaF            = -0.0054
float tausmin_NaF       = 0.01
float tausmax_NaF       = 1
float Ktaus1_NaF        = 0.0183
float Ktaus2_NaF        = -0.010

//float dq10_NaF                  = {NaF_dq10}
float dq10_NaF			= 1

// NaP: Persistant sodium channel
// --> kinetics for room temperature
float mpower_NaP	= 3
float Vhalfm_NaP	= -0.050
float Km_NaP		= 0.0057
float taummin_NaP	= 0.00003		// room temperature
float taummax_NaP	= 0.00043686	// room temperature
float V0taum_NaP	= -0.04264
float Ktaum1_NaP	= 0.0144
float Ktaum2_NaP	= -0.0144

float hpower_NaP 	= 1
float hmin_NaP		= 0.154
float V0h_NaP 		= -0.057
float Kh_NaP		= -0.004
float tauhmin_NaP	= 0.03			// room temp
float tauhmax_NaP	= 0.051			// room temp
float V0tauh_NaP	= -0.034
float Ktauh1_NaP	= 0.026
float Ktauh2_NaP	= -0.0319

// Couldn't get the same curve shape with the standard tau(V) equation.
float spower_NaP	= 1
float V0s_NaP		= -0.01
float Ks_NaP		= -0.0049
float Aalpha_NaP	= -2.88		// units of /volt/sec
float Balpha_NaP	= -0.049	// units of /sec
float Kalpha_NaP	= 0.00463	// units of volts
float Abeta_NaP		= 6.94		// units of /volt/sec
float Bbeta_NaP		= 0.447		// units of /sec
float Kbeta_NaP		= -0.00263	// units of volts

float dq10_NaP 		= 3				// divide all tau values by this number

// Kv2: Slow delayed rectifier Kv channel
// --> kinetics for 32 degrees C:
float npower_Kv2	= 4
float Vhalfn_Kv2	= -0.018
float Kn_Kv2		= 0.0091
float taunmin_Kv2	= 0.0001
float taunmax_Kv2	= 0.03
float Ktaun1_Kv2	= 0.02174
float Ktaun2_Kv2	= -0.01391

float hpower_Kv2	= 1
float hmin_Kv2		= 0.2
float V0h_Kv2		= -0.02
float Kh_Kv2		= -0.01
float tauhmin_Kv2	= 3.4
float tauhmax_Kv2	= 3.4
float V0tauh_Kv2	= 0		// irrelevant while tauhmin == tauhmax
float Ktauh1_Kv2	= 0.01	// irrelevant while tauhmin == tauhmax
float Ktauh2_Kv2	= -0.01 // irrelevant while tauhmin == tauhmax

float dq10_Kv2		= 1

// Kv3: Fast delayed rectifier Kv channel
// --> kinetics for 32 degrees C:
float npower_Kv3	= 4
float Vhalfn_Kv3	= -0.013	// Actual Vhalf
float Kn_Kv3		= 0.0078	// Yields K = 6 mV with Xpower = 4
float taunmin_Kv3	= 0.0001	// 32 degrees C
float taunmax_Kv3	= 0.014		// 32 degrees C
float Ktaun1_Kv3	= -0.012
float Ktaun2_Kv3	= -0.013

float hpower_Kv3	= 1
float hmin_Kv3		= 0.6
float V0h_Kv3		= -0.02
float Kh_Kv3		= -0.010
//float tauhmin_Kv3       = 3.4
//float tauhmax_Kv3       = 3.4
float tauhmin_Kv3	= 0.007	
float tauhmax_Kv3	= 0.033	
float V0tauh_Kv3	= 0
float Ktauh1_Kv3	= 0.01
float Ktauh2_Kv3	= -0.01

float dq10_Kv3		= 1

// Kv4: Transient (A-type) Kv channel 
// --> n gate (activation/deactivation) is the same for Kv4-fast and Kv4-slow
// --> kinetics for 32 degrees C:
float npower_Kv4	= 4
float V0n_Kv4		= -0.049	// Yields Vhalf = -27 mV when Xpower = 4
float Kn_Kv4		= 0.0125	// Yields K = 9.6 mV when Xpower = 4
float taunmin_Kv4	= 0.00025
float taunmax_Kv4	= 0.007	
float Ktaun1_Kv4	= 0.029
float Ktaun2_Kv4	= -0.029

float hpower_Kv4	= 1
float V0h_Kv4		= -0.083
float Kh_Kv4		= -0.01	
float Ktauh1_Kv4	= 0.010
float Ktauh2_Kv4	= -0.010

// Only the inactivation time constants differ between Kv4f and Kv4s
float tauhmin_Kv4f	= 0.007
float tauhmax_Kv4f	= 0.021 
float tauhmin_Kv4s	= 0.050
float tauhmax_Kv4s	= 0.121

float dq10_Kv4		= 1

// KCNQ: M-type K channel
// --> kinetics for 32 degrees (Q10=3 adjusted from paper)
float npower_KCNQ	= 4
float Vhalfn_KCNQ 	= -0.0285
float Kn_KCNQ		= 0.0195	// Yields actual K = 15 when power = 4.
float taunmin_KCNQ	= 0.0067
float taunmax_KCNQ	= 0.100
float Ktaun1_KCNQ	= 0.035
float Ktaun2_KCNQ	= -0.025

float dq10_KCNQ		= 1

// SK: small conductance calcium-activated K channel
// --> kinetics for room temperature
float zpower_SK		= 1	
float EC50_SK = 0.00035		// SI unit = mM; default = 350 nM.
float hillslope_SK	= 4.6	// Hirschberg et al, 1999
float taumin_SK		= 0.008	// fastest activation kinetics in saturating Ca2+
float taumax_SK		= 0.076 // deactivation time constant in 0 Ca2+
float CaSat_SK		= 0.005	// calcium concentration at which tau-act reaches max.

float dq10_SK = 2

// CaHVA: generic high-threshold calcium channel
// --> kinetics for 32 degrees C (Q10=2.5 adjusted by Jesse)
float npower_CaHVA 	= 1
float Vhalfn_CaHVA 	= -0.02
float Kn_CaHVA 		= 0.007 
float taun_CaHVA	= 0.0002

float dq10_CaHVA	= 1

// HCN: hyperpolarization activated cation channels (H-current)
// --> kinetics for room temperature
// HCN1/2 heteromeric channels:
float mpower_HCN1	= 1
float V0m_HCN1		= -0.0764
float Km_HCN1		= -0.0033
float taumin_HCN1	= 0
float taumax_HCN1	= 14.5	// actual taumax 3.625 with Q10 adjustment
float Ktau1_HCN1	= 0.00656
float Ktau2_HCN1	= -0.00748
float dq10_HCN1		= 4

// HCN2 homomeric channels:
float mpower_HCN2	= 1
float V0m_HCN2		= -0.0875
float Km_HCN2		= -0.004
float taumin_HCN2	= 0
float taumax_HCN2	= 25.2	// actual taumax 6.3 with Q10 adjustment
float Ktau1_HCN2	= 0.0089
float Ktau2_HCN2	= -0.0082
float dq10_HCN2		= 4

//Voltage-gated ion channel reversal potentials
float ENa = 0.050
float ECa = 0.130
float EK = -0.090
float Eh = -0.03

//Calcium concentration parameters
float B_Ca_GP_conc = 5.2e-12  
float shell_thick  = 20e-9 	//	meters 
float tau_CaClearance = 0.001	// 	time constant for Ca2+ clearance (sec)

//Synaptic conductances
// STN excitatory inputs
float G_AMPA    	= 0.25e-9
float tauRise_AMPA 	= 0.001
float tauFall_AMPA	= 0.003

float G_NMDA    	= {{G_AMPA}*.05}  //not used yet!
float tauRise_NMDA	= 0.01
float tauFall_NMDA	= 0.03

// Striatal inhibitory inputs
float G_GABA    	= 0.25e-9
//float tauRise_GABA	= 0.001
//float tauFall_GABA	= 0.012
//to reflect Sims et al 2008:
float tauRise_GABA      = 0.0005
float tauFall_GABA      = 0.00491


// Pallidal inhibitory collaterals
float G_GABA_GP 	= 1.50e-9 	//pallidal inputs
//float tauRise_GABA_GP	= 0.001
//float tauFall_GABA_GP	= 0.012
//to reflect Sims et al 2008:
float tauRise_GABA_GP      = 0.0005
float tauFall_GABA_GP      = 0.00491


// Default input rates = 0
float STN_rate      	= 0
float striatum_rate 	= 0
float pallidum_rate 	= 0
float STN_subrate		= 0

// Default input synchrony
int distrib_STN     = 1     // no STN synchrony by default.
int distrib_STNsub	= 1		 
int distrib_Str     = 1     // no striatal synchrony by default.

// Random seeds for timetables
float rseed_STN = 	78923456
float rseed_Str = 	78123456
float rseed_GP = 	77715346
float rseed_STN_postsnap =     99999999
float rseed_striatum_postsnap =    111111111

// Reversal potentials
float E_AMPA 		= 0
float E_NMDA 		= 0
float E_GABA 		= -0.080

//simulation defaults 
str cellpath = "/GP"
float dt = 1e-5
float rundur = 3	// duration of each run (seconds)
str ttab_fpath_STN = "../../utilities/timetables/STN/nojitter/"
 
