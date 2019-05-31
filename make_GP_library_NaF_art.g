//make_GP_library: create the library of components for GP simulation
//	IN USE SINCE 01/17/2005
//	New changes since last version:
//		Changed SK channel

/* Note that include statements are called from the directory in which the
main genesis file (the run file, e.g.) is located. So path must be either
fully explicit (/home/jedgerton/...) or else relative to the run directories.
*/
include ../common/GPchans_NaF_art
include ../common/GPsyns
include ../common/GPcomps_newGP

if (!{exists /library})
        create neutral /library
        disable /library
end

pushe /library
	make_Na_fast_GP
    make_Na_slow_GP
	make_Kv3_GP
	make_Kv2_GP
    make_Kv4_fast_GP
	make_Kv4_slow_GP
	make_KCNQ_GP
    make_Ca_GP_conc
	make_Ca_GP_nernst
    make_Ca_HVA_GP
    make_SK_GP
    make_h_HCN_GP
	make_h_HCN2_GP
    make_GP_comps
	make_GP_syns
pope
/*
include ./write_chankin
write_kinetics "Na_fast_GP" 3
write_kinetics "Na_slow_GP" 3
write_kinetics "Kv3_GP" 1
write_kinetics "Kv2_GP" 1
write_kinetics "Kv4_fast_GP" 1
write_kinetics "Kv4_slow_GP" 1
write_kinetics "KCNQ_GP" 0
write_kinetics "Ca_HVA_GP" 0
write_kinetics "K_ahp_GP" 2
write_kinetics "h_HCN_GP" 0
write_kinetics "h_HCN2_GP" 0
*/
