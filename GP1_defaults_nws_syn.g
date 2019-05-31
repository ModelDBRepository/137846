//GPdefaults - set default param values for GP simulations.
//	Any param value can be overwritten subsequently.
// THIS VERSION CURRENT 06/25/2004 to present.
// Modified 08/02/2004: add filename strings to this file, remove them from
//	other files (read_STN_syns_Kv.g, add_striatum_syns.g)

str snapshot_act = "../common/gp1_act_spont_snapshot.save"
str snapshot_pas = "../common/gp1_pas_spont_snapshot.save"

str allcompsfilename 	= "../common/comptlists/GP1/gp1allcompnames.asc"
int ncomps 			= 585	// total # compartments in model. 
					// Keep this up to date!

str dendfilename 	= "../common/comptlists/GP1/gp1dendritenames.asc"
int num_dendcomps 		= 511	// total # dendritic compartments

str outputcompsfname 	= "../common/comptlists/GP1/gp1_outputcomps_20060213.asc"

// NWS: STNfilename is set by default to same path as clusters but will be overwritten
// NWS: in masterscript to specify subsets of dendritic synapses
str STNfilename 	= "../common/comptlists/GP1/gp1_STNinputcomps.asc"
str STN_sub_comps 	= "none"
int num_STN			= 100	// # STN inputs
int maxlen_STN_subgroup = 100	// max number of syns to include in subgroup
str STN_scale		= "../common/STNweights/ones.asci"
int STNwt			= 1
str ttab_idx_STN	= "../common/ttab_idxs/ttabidx_STN_indep.asc"
str ttab_idx_STNsub = "none"
str ttab_fname_STN 	= "../utilities/timetables/STN/nojitter/0_HzSTN"
str ttab_fname_STNsub = {ttab_fname_STN}

// NWS: clusterfname should be fixed so path is explicitly given
str clusterfname 	= "../common/comptlists/GP1/gp1_STNinputcomps.asc"
int num_clusters 		= 100	// # compts receiving clusters
float mean_cluster_level	= 6   	// overall cluster level to maintain
float G_mult_Na_cluster       	= 6 	// Na cluster level at synapse subset
float G_mult_Kdr_cluster 	= 6	// Kdr cluster level at same synapses
float G_mult_KA_cluster		= 1

str striatumfname 	= "../common/comptlists/GP1/gp1dendritenames.asc"
str ttab_fname_Str = "../utilities/timetables/striatum/" @ 	\
							"0_HzStr_group"
str ttab_idx_Str = "../common/ttab_idxs/ttabidx_striatum_indep.asc"
int num_striatum_compts 	= 511
int num_striatum_per_comp 	= 2

float num_pallidal		= 10	// all in soma


float PI = 3.14159

//Passive properties
float RA = 1.74		// uniform
float CM = 0.024	// all unmyelinated regions
float CM_my = 0.00024	// myelinated axon segments.
float RM_sd = 1.47 	// soma
float RM_ax = 1.47	// unmyelinated axonal regions
float RM_my = 10	// myelinated axon segments.
float ELEAK_sd  = -0.060	// soma & dend
float ELEAK_ax	= -0.060	// axon
float EREST_ACT = -0.060

/* Channel densities now set in either actpars.g or paspars.g for
	active or passive model.
*/
