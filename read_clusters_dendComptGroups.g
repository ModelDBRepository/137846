//FILE IN USE 08/05/2004 -- present.

// script to add channel clusters to GP model without adding synapses.
// clusters are added to compartments read from file {clusterfname}

int i
str clustercomp
int num_cluster = 0
// open file to list compartment names for clusters
openfile {clusterfname} r 
echo cluster NaF density set to {G_mult_Na_cluster} times default density
clustercomp = {readfile {clusterfname}}
//cycle through selected compartments
while (! {eof {clusterfname}})

    num_cluster = {num_cluster} + 1
	//get existing channel densities for each compartment
//        echo "num_cluster = " {num_cluster}


//Adds clusters to conductances named with default naming scheme (not designated by dendrite and proximity to soma)
        if ({exists {cellpath}/{clustercomp}/Na_fast_GP})
            float Gbar_NaF = {getfield {cellpath}/{clustercomp}/Na_fast_GP Gbar}
//            echo {cellpath} "/" {clustercomp} "Na_fast_GP before setfield: " {getfield {cellpath}/{clustercomp}/Na_fast_GP Gbar}
            setfield {cellpath}/{clustercomp}/Na_fast_GP Gbar \
                {{Gbar_NaF}*{G_mult_Na_cluster}}
//            echo {cellpath} "/" {clustercomp} "Na_fast_GP after setfield: " {getfield {cellpath}/{clustercomp}/Na_fast_GP Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Na_fast_GP"
        end

        if ({exists {cellpath}/{clustercomp}/Na_slow_GP})
            float Gbar_NaP = {getfield {cellpath}/{clustercomp}/Na_slow_GP Gbar}
//            echo {cellpath} "/" {clustercomp} "Na_slow_GP before setfield: " {getfield {cellpath}/{clustercomp}/Na_slow_GP Gbar}
            setfield {cellpath}/{clustercomp}/Na_slow_GP Gbar \
                {{Gbar_NaP}*{G_mult_Na_cluster}}
//            echo {cellpath} "/" {clustercomp} "Na_slow_GP after setfield: " {getfield {cellpath}/{clustercomp}/Na_slow_GP Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Na_slow_GP"
        end

        if ({exists {cellpath}/{clustercomp}/Kv2_GP})
            float Gbar_Kv2 = {getfield {cellpath}/{clustercomp}/Kv2_GP Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv2_GP before setfield: " {getfield {cellpath}/{clustercomp}/Kv2_GP Gbar}
            setfield {cellpath}/{clustercomp}/Kv2_GP Gbar \
                {{Gbar_Kv2}*{G_mult_Kdr_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv2_GP after setfield: " {getfield {cellpath}/{clustercomp}/Kv2_GP Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv2_GP"
        end

        if ({exists {cellpath}/{clustercomp}/Kv3_GP})
            float Gbar_Kv3 = {getfield {cellpath}/{clustercomp}/Kv3_GP Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv3_GP before setfield: " {getfield {cellpath}/{clustercomp}/Kv3_GP Gbar}
            setfield {cellpath}/{clustercomp}/Kv3_GP Gbar \
                {{Gbar_Kv3}*{G_mult_Kdr_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv3_GP after setfield: " {getfield {cellpath}/{clustercomp}/Kv3_GP Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv3_GP"
        end

        if ({exists {cellpath}/{clustercomp}/Kv4_fast_GP})
            float Gbar_Kv4f = {getfield {cellpath}/{clustercomp}/Kv4_fast_GP Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv4_fast_GP before setfield: " {getfield {cellpath}/{clustercomp}/Kv4_fast_GP Gbar}
            setfield {cellpath}/{clustercomp}/Kv4_fast_GP Gbar \
                {{Gbar_Kv4f}*{G_mult_KA_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv4_fast_GP after setfield: " {getfield {cellpath}/{clustercomp}/Kv4_fast_GP Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv4_fast_GP"
        end

        if ({exists {cellpath}/{clustercomp}/Kv4_slow_GP})
            float Gbar_Kv4s = {getfield {cellpath}/{clustercomp}/Kv4_slow_GP Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv4_slow_GP before setfield: " {getfield {cellpath}/{clustercomp}/Kv4_slow_GP Gbar}
            setfield {cellpath}/{clustercomp}/Kv4_slow_GP Gbar \
                {{Gbar_Kv4s}*{G_mult_KA_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv4_slow_GP after setfield: " {getfield {cellpath}/{clustercomp}/Kv4_slow_GP Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv4_slow_GP"
        end



// The 'for loop' will check for the existence of currents named according to dendrite branch
// j-values of 1 to 3 are used for dendrite branches 1 to 3
// and separate if statements within the 'for loop' will check for currents named by location (prox/mid/distal)
    int j
    for(j=1; j<=3; j=j+1)
//get NaF channel density as named for prox/mid/dist and multiply density by cluster value
        if ({exists {cellpath}/{clustercomp}/{"Na_fast_GP_dend" @ {j} @ "_proximal25compts"}})
            float Gbar_NaF = {getfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Na_fast_GP_dend"{j}"_proximal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend"@{j}@"_proximal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend" @ {j} @ "_proximal25compts"} Gbar \
                {{Gbar_NaF}*{G_mult_Na_cluster}}
//            echo {cellpath} "/" {clustercomp} "Na_fast_GP_dend"{j}"_proximal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend"@{j}@"_proximal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Na_fast_GP_dend"{j}"_proximal25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Na_fast_GP_dend" @ {j} @ "_mid25compts"}})
            float Gbar_NaF = {getfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend" @ {j} @ "_mid25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Na_fast_GP_dend"{j}"_mid25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend"@{j}@"_mid25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend" @ {j} @ "_mid25compts"} Gbar \
                {{Gbar_NaF}*{G_mult_Na_cluster}}
//            echo {cellpath} "/" {clustercomp} "Na_fast_GP_dend"{j}"_mid25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend"@{j}@"_mid25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Na_fast_GP_dend"{j}"_mid25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Na_fast_GP_dend" @ {j} @ "_distal25compts"}})
            float Gbar_NaF = {getfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend" @ {j} @ "_distal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Na_fast_GP_dend"{j}"_distal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend"@{j}@"_distal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend" @ {j} @ "_distal25compts"} Gbar \
                {{Gbar_NaF}*{G_mult_Na_cluster}}
//            echo {cellpath} "/" {clustercomp} "Na_fast_GP_dend"{j}"_distal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Na_fast_GP_dend"@{j}@"_distal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Na_fast_GP_dend"{j}"_distal25compts"
        end


//get NaP channel density as named for prox/mid/dist and multiply density by cluster value
        if ({exists {cellpath}/{clustercomp}/{"Na_slow_GP_dend" @ {j} @ "_proximal25compts"}})
            float Gbar_NaP = {getfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Na_slow_GP_dend"{j}"_proximal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend"@{j}@"_proximal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend" @ {j} @ "_proximal25compts"} Gbar \
                {{Gbar_NaP}*{G_mult_Na_cluster}}
//            echo {cellpath} "/" {clustercomp} "Na_slow_GP_dend"{j}"_proximal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend"@{j}@"_proximal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Na_slow_GP_dend"{j}"_proximal25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Na_slow_GP_dend" @ {j} @ "_mid25compts"}})
            float Gbar_NaP = {getfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend" @ {j} @ "_mid25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Na_slow_GP_dend"{j}"_mid25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend"@{j}@"_mid25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend" @ {j} @ "_mid25compts"} Gbar \
                {{Gbar_NaP}*{G_mult_Na_cluster}}
//            echo {cellpath} "/" {clustercomp} "Na_slow_GP_dend"{j}"_mid25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend"@{j}@"_mid25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Na_slow_GP_dend"{j}"_mid25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Na_slow_GP_dend" @ {j} @ "_distal25compts"}})
            float Gbar_NaP = {getfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend" @ {j} @ "_distal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Na_slow_GP_dend"{j}"_distal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend"@{j}@"_distal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend" @ {j} @ "_distal25compts"} Gbar \
                {{Gbar_NaP}*{G_mult_Na_cluster}}
//            echo {cellpath} "/" {clustercomp} "Na_slow_GP_dend"{j}"_distal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Na_slow_GP_dend"@{j}@"_distal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Na_slow_GP_dend"{j}"_distal25compts"
        end


//get Kv2 channel density as named for prox/mid/dist and multiply density by cluster value
        if ({exists {cellpath}/{clustercomp}/{"Kv2_GP_dend" @ {j} @ "_proximal25compts"}})
            float Gbar_Kv2 = {getfield {cellpath}/{clustercomp}/{"Kv2_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv2_GP_dend"{j}"_proximal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv2_GP_dend"@{j}@"_proximal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv2_GP_dend" @ {j} @ "_proximal25compts"} Gbar \
                {{Gbar_Kv2}*{G_mult_Kdr_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv2_GP_dend"{j}"_proximal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv2_GP_dend"@{j}@"_proximal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv2_GP_dend"{j}"_proximal25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Kv2_GP_dend" @ {j} @ "_mid25compts"}})
            float Gbar_Kv2 = {getfield {cellpath}/{clustercomp}/{"Kv2_GP_dend" @ {j} @ "_mid25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv2_GP_dend"{j}"_mid25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv2_GP_dend"@{j}@"_mid25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv2_GP_dend" @ {j} @ "_mid25compts"} Gbar \
                {{Gbar_Kv2}*{G_mult_Kdr_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv2_GP_dend"{j}"_mid25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv2_GP_dend"@{j}@"_mid25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv2_GP_dend"{j}"_mid25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Kv2_GP_dend" @ {j} @ "_distal25compts"}})
            float Gbar_Kv2 = {getfield {cellpath}/{clustercomp}/{"Kv2_GP_dend" @ {j} @ "_distal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv2_GP_dend"{j}"_distal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv2_GP_dend"@{j}@"_distal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv2_GP_dend" @ {j} @ "_distal25compts"} Gbar \
                {{Gbar_Kv2}*{G_mult_Kdr_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv2_GP_dend"{j}"_distal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv2_GP_dend"@{j}@"_distal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv2_GP_dend"{j}"_distal25compts"
        end


//get Kv3 channel density as named for prox/mid/dist and multiply density by cluster value
        if ({exists {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_proximal25compts"}})
            float Gbar_Kv3 = {getfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv3_GP_dend"{j}"_proximal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_proximal25compts"} Gbar \
                {{Gbar_Kv3}*{G_mult_Kdr_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv3_GP_dend"{j}"_proximal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv3_GP_dend"{j}"_proximal25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_mid25compts"}})
            float Gbar_Kv3 = {getfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_mid25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv3_GP_dend"{j}"_mid25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_mid25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_mid25compts"} Gbar \
                {{Gbar_Kv3}*{G_mult_Kdr_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv3_GP_dend"{j}"_mid25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_mid25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv3_GP_dend"{j}"_mid25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_distal25compts"}})
            float Gbar_Kv3 = {getfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_distal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv3_GP_dend"{j}"_distal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_distal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_distal25compts"} Gbar \
                {{Gbar_Kv3}*{G_mult_Kdr_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv3_GP_dend"{j}"_distal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv3_GP_dend" @ {j} @ "_distal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv3_GP_dend"{j}"_distal25compts"
        end


//get Kv4f channel density as named for prox/mid/dist and multiply density by cluster value
        if ({exists {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_proximal25compts"}})
            float Gbar_Kv4f = {getfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv4_fast_GP_dend"{j}"_proximal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_proximal25compts"} Gbar \
                {{Gbar_Kv4f}*{G_mult_KA_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv4_fast_GP_dend"{j}"_proximal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv4_fast_GP_dend"{j}"_proximal25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_mid25compts"}})
            float Gbar_Kv4f = {getfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_mid25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv4_fast_GP_dend"{j}"_mid25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_mid25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_mid25compts"} Gbar \
                {{Gbar_Kv4f}*{G_mult_KA_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv4_fast_GP_dend"{j}"_mid25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_mid25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv4_fast_GP_dend"{j}"_mid25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_distal25compts"}})
            float Gbar_Kv4f = {getfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_distal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv4_fast_GP_dend"{j}"_distal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_distal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_distal25compts"} Gbar \
                {{Gbar_Kv4f}*{G_mult_KA_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv4_fast_GP_dend"{j}"_distal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_fast_GP_dend" @ {j} @ "_distal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv4_fast_GP_dend"{j}"_distal25compts"
        end


//get Kv4s channel density as named for prox/mid/dist and multiply density by cluster value
        if ({exists {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_proximal25compts"}})
            float Gbar_Kv4s = {getfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv4_slow_GP_dend"{j}"_proximal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_proximal25compts"} Gbar \
                {{Gbar_Kv4s}*{G_mult_KA_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv4_slow_GP_dend"{j}"_proximal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_proximal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv4_slow_GP_dend"{j}"_proximal25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_mid25compts"}})
            float Gbar_Kv4s = {getfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_mid25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv4_slow_GP_dend"{j}"_mid25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_mid25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_mid25compts"} Gbar \
                {{Gbar_Kv4s}*{G_mult_KA_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv4_slow_GP_dend"{j}"_mid25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_mid25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv4_slow_GP_dend"{j}"_mid25compts"
        end

        if ({exists {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_distal25compts"}})
            float Gbar_Kv4s = {getfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_distal25compts"} Gbar}
//            echo {cellpath} "/" {clustercomp} "Kv4_slow_GP_dend"{j}"_distal25compts before setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_distal25compts"} Gbar}
            setfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_distal25compts"} Gbar \
                {{Gbar_Kv4s}*{G_mult_KA_cluster}}
//            echo {cellpath} "/" {clustercomp} "Kv4_slow_GP_dend"{j}"_distal25compts after setfield: " {getfield {cellpath}/{clustercomp}/{"Kv4_slow_GP_dend" @ {j} @ "_distal25compts"} Gbar}
        else
//            echo {cellpath} "/" {clustercomp} " has no Kv4_slow_GP_dend"{j}"_distal25compts"
        end

    end
	
	// get next compartment name
	clustercomp = {readfile {clusterfname}}
end
closefile {clusterfname} 

