// for confirming distribution of spike currents from soma to dendrite:
str mycompt
float NaF_soma_Gtot = 0
float NaS_soma_Gtot = 0
float KV2_soma_Gtot = 0
float KV3_soma_Gtot = 0
float NaF_dend_Gtot = 0
float NaS_dend_Gtot = 0
float KV2_dend_Gtot = 0
float KV3_dend_Gtot = 0

float Na_fast_GP_tmpVal
float Na_fast_GP_somahill_tmpVal
float Na_fast_GP_dend3_distal25compts_tmpVal
float Na_fast_GP_dend3_mid25compts_tmpVal
float Na_fast_GP_dend3_proximal25compts_tmpVal
float Na_fast_GP_dend2_distal25compts_tmpVal
float Na_fast_GP_dend2_proximal25compts_tmpVal
float Na_fast_GP_dend1_distal25compts_tmpVal
float Na_fast_GP_dend1_proximal25compts_tmpVal

float Na_slow_GP_tmpVal
float Na_slow_GP_somahill_tmpVal
float Na_slow_GP_dend3_distal25compts_tmpVal
float Na_slow_GP_dend3_mid25compts_tmpVal
float Na_slow_GP_dend3_proximal25compts_tmpVal
float Na_slow_GP_dend2_distal25compts_tmpVal
float Na_slow_GP_dend2_proximal25compts_tmpVal
float Na_slow_GP_dend1_distal25compts_tmpVal
float Na_slow_GP_dend1_proximal25compts_tmpVal

float Kv2_GP_tmpVal
float Kv2_GP_somahill_tmpVal
float Kv2_GP_dend3_distal25compts_tmpVal
float Kv2_GP_dend3_mid25compts_tmpVal
float Kv2_GP_dend3_proximal25compts_tmpVal
float Kv2_GP_dend2_distal25compts_tmpVal
float Kv2_GP_dend2_proximal25compts_tmpVal
float Kv2_GP_dend1_distal25compts_tmpVal
float Kv2_GP_dend1_proximal25compts_tmpVal

float Kv3_GP_tmpVal
float Kv3_GP_somahill_tmpVal
float Kv3_GP_dend3_distal25compts_tmpVal
float Kv3_GP_dend3_mid25compts_tmpVal
float Kv3_GP_dend3_proximal25compts_tmpVal
float Kv3_GP_dend2_distal25compts_tmpVal
float Kv3_GP_dend2_proximal25compts_tmpVal
float Kv3_GP_dend1_distal25compts_tmpVal
float Kv3_GP_dend1_proximal25compts_tmpVal


float echoGate = 0

foreach mycompt ({el {cellpath}/##[][OBJECT=compartment]})

// NaFast

    if ({exists {mycompt}/Na_fast_GP})
        Na_fast_GP_tmpVal = {({getfield {mycompt}/Na_fast_GP Gbar})}
        NaF_dend_Gtot = {NaF_dend_Gtot} + {Na_fast_GP_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaF {({getfield {mycompt}/Na_fast_GP Gbar})}
        end
    end

    if ({exists {mycompt}/Na_fast_GP_somahill})
        Na_fast_GP_somahill_tmpVal = {({getfield {mycompt}/Na_fast_GP_somahill Gbar})}
        NaF_soma_Gtot = {NaF_soma_Gtot} + {Na_fast_GP_somahill_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaF {({getfield {mycompt}/Na_fast_GP_somahill Gbar})}
        end
    end

    if ({exists {mycompt}/Na_fast_GP_dend3_distal25compts})
        Na_fast_GP_dend3_distal25compts_tmpVal = {({getfield {mycompt}/Na_fast_GP_dend3_distal25compts Gbar})}
        NaF_dend_Gtot = {NaF_dend_Gtot} + {Na_fast_GP_dend3_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaF {({getfield {mycompt}/Na_fast_GP_dend3_distal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_fast_GP_dend3_mid25compts})
        Na_fast_GP_dend3_mid25compts_tmpVal = {({getfield {mycompt}/Na_fast_GP_dend3_mid25compts Gbar})}
        NaF_dend_Gtot = {NaF_dend_Gtot} + {Na_fast_GP_dend3_mid25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaF {({getfield {mycompt}/Na_fast_GP_dend3_mid25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_fast_GP_dend3_proximal25compts})
        Na_fast_GP_dend3_proximal25compts_tmpVal = {({getfield {mycompt}/Na_fast_GP_dend3_proximal25compts Gbar})}
        NaF_dend_Gtot = {NaF_dend_Gtot} + {Na_fast_GP_dend3_proximal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaF {({getfield {mycompt}/Na_fast_GP_dend3_proximal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_fast_GP_dend2_distal25compts})
        Na_fast_GP_dend2_distal25compts_tmpVal = {({getfield {mycompt}/Na_fast_GP_dend2_distal25compts Gbar})}
        NaF_dend_Gtot = {NaF_dend_Gtot} + {Na_fast_GP_dend2_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaF {({getfield {mycompt}/Na_fast_GP_dend2_distal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_fast_GP_dend2_proximal25compts})
        Na_fast_GP_dend2_proximal25compts_tmpVal = {({getfield {mycompt}/Na_fast_GP_dend2_proximal25compts Gbar})}
        NaF_dend_Gtot = {NaF_dend_Gtot} + {Na_fast_GP_dend2_proximal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaF {({getfield {mycompt}/Na_fast_GP_dend2_proximal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_fast_GP_dend1_distal25compts})
        Na_fast_GP_dend1_distal25compts_tmpVal = {({getfield {mycompt}/Na_fast_GP_dend1_distal25compts Gbar})}
        NaF_dend_Gtot = {NaF_dend_Gtot} + {Na_fast_GP_dend1_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaF {({getfield {mycompt}/Na_fast_GP_dend1_distal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_fast_GP_dend1_proximal25compts})
        Na_fast_GP_dend1_proximal25compts_tmpVal = {({getfield {mycompt}/Na_fast_GP_dend1_proximal25compts Gbar})}
        NaF_dend_Gtot = {NaF_dend_Gtot} + {Na_fast_GP_dend1_proximal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaF {({getfield {mycompt}/Na_fast_GP_dend1_proximal25compts Gbar})}
        end
    end


// NaSlow

    if ({exists {mycompt}/Na_slow_GP})
        Na_slow_GP_tmpVal = {({getfield {mycompt}/Na_slow_GP Gbar})}
        NaS_dend_Gtot = {NaS_dend_Gtot} + {Na_slow_GP_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaS {({getfield {mycompt}/Na_slow_GP Gbar})}
        end
    end

    if ({exists {mycompt}/Na_slow_GP_somahill})
        Na_slow_GP_somahill_tmpVal = {({getfield {mycompt}/Na_slow_GP_somahill Gbar})}
        NaS_soma_Gtot = {NaS_soma_Gtot} + {Na_slow_GP_somahill_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaS {({getfield {mycompt}/Na_slow_GP_somahill Gbar})}
        end
    end

    if ({exists {mycompt}/Na_slow_GP_dend3_distal25compts})
        Na_slow_GP_dend3_distal25compts_tmpVal = {({getfield {mycompt}/Na_slow_GP_dend3_distal25compts Gbar})}
        NaS_dend_Gtot = {NaS_dend_Gtot} + {Na_slow_GP_dend3_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaS {({getfield {mycompt}/Na_slow_GP_dend3_distal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_slow_GP_dend3_mid25compts})
        Na_slow_GP_dend3_mid25compts_tmpVal = {({getfield {mycompt}/Na_slow_GP_dend3_mid25compts Gbar})}
        NaS_dend_Gtot = {NaS_dend_Gtot} + {Na_slow_GP_dend3_mid25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaS {({getfield {mycompt}/Na_slow_GP_dend3_mid25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_slow_GP_dend3_proximal25compts})
        Na_slow_GP_dend3_proximal25compts_tmpVal = {({getfield {mycompt}/Na_slow_GP_dend3_proximal25compts Gbar})}
        NaS_dend_Gtot = {NaS_dend_Gtot} + {Na_slow_GP_dend3_proximal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaS {({getfield {mycompt}/Na_slow_GP_dend3_proximal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_slow_GP_dend2_distal25compts})
        Na_slow_GP_dend2_distal25compts_tmpVal = {({getfield {mycompt}/Na_slow_GP_dend2_distal25compts Gbar})}
        NaS_dend_Gtot = {NaS_dend_Gtot} + {Na_slow_GP_dend2_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaS {({getfield {mycompt}/Na_slow_GP_dend2_distal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_slow_GP_dend2_proximal25compts})
        Na_slow_GP_dend2_proximal25compts_tmpVal = {({getfield {mycompt}/Na_slow_GP_dend2_proximal25compts Gbar})}
        NaS_dend_Gtot = {NaS_dend_Gtot} + {Na_slow_GP_dend2_proximal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaS {({getfield {mycompt}/Na_slow_GP_dend2_proximal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Na_slow_GP_dend1_distal25compts})
        Na_slow_GP_dend1_distal25compts_tmpVal = {({getfield {mycompt}/Na_slow_GP_dend1_distal25compts Gbar})}
        NaS_dend_Gtot = {NaS_dend_Gtot} + {Na_slow_GP_dend1_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} NaS {({getfield {mycompt}/Na_slow_GP_dend1_distal25compts Gbar})}
        end
    end


// KV2

    if ({exists {mycompt}/Kv2_GP})
        Kv2_GP_tmpVal = {({getfield {mycompt}/Kv2_GP Gbar})}
        KV2_dend_Gtot = {KV2_dend_Gtot} + {Kv2_GP_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV2 {({getfield {mycompt}/Kv2_GP Gbar})}
        end
    end

    if ({exists {mycompt}/Kv2_GP_somahill})
        Kv2_GP_somahill_tmpVal = {({getfield {mycompt}/Kv2_GP_somahill Gbar})}
        KV2_soma_Gtot = {KV2_soma_Gtot} + {Kv2_GP_somahill_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV2 {({getfield {mycompt}/Kv2_GP_somahill Gbar})}
        end
    end

    if ({exists {mycompt}/Kv2_GP_dend3_distal25compts})
        Kv2_GP_dend3_distal25compts_tmpVal = {({getfield {mycompt}/Kv2_GP_dend3_distal25compts Gbar})}
        KV2_dend_Gtot = {KV2_dend_Gtot} + {Kv2_GP_dend3_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV2 {({getfield {mycompt}/Kv2_GP_dend3_distal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv2_GP_dend3_mid25compts})
        Kv2_GP_dend3_mid25compts_tmpVal = {({getfield {mycompt}/Kv2_GP_dend3_mid25compts Gbar})}
        KV2_dend_Gtot = {KV2_dend_Gtot} + {Kv2_GP_dend3_mid25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV2 {({getfield {mycompt}/Kv2_GP_dend3_mid25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv2_GP_dend3_proximal25compts})
        Kv2_GP_dend3_proximal25compts_tmpVal = {({getfield {mycompt}/Kv2_GP_dend3_proximal25compts Gbar})}
        KV2_dend_Gtot = {KV2_dend_Gtot} + {Kv2_GP_dend3_proximal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV2 {({getfield {mycompt}/Kv2_GP_dend3_proximal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv2_GP_dend2_distal25compts})
        Kv2_GP_dend2_distal25compts_tmpVal = {({getfield {mycompt}/Kv2_GP_dend2_distal25compts Gbar})}
        KV2_dend_Gtot = {KV2_dend_Gtot} + {Kv2_GP_dend2_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV2 {({getfield {mycompt}/Kv2_GP_dend2_distal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv2_GP_dend2_proximal25compts})
        Kv2_GP_dend2_proximal25compts_tmpVal = {({getfield {mycompt}/Kv2_GP_dend2_proximal25compts Gbar})}
        KV2_dend_Gtot = {KV2_dend_Gtot} + {Kv2_GP_dend2_proximal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV2 {({getfield {mycompt}/Kv2_GP_dend2_proximal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv2_GP_dend1_distal25compts})
        Kv2_GP_dend1_distal25compts_tmpVal = {({getfield {mycompt}/Kv2_GP_dend1_distal25compts Gbar})}
        KV2_dend_Gtot = {KV2_dend_Gtot} + {Kv2_GP_dend1_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV2 {({getfield {mycompt}/Kv2_GP_dend1_distal25compts Gbar})}
        end
    end


// KV3

    if ({exists {mycompt}/Kv3_GP})
        Kv3_GP_tmpVal = {({getfield {mycompt}/Kv3_GP Gbar})}
        KV3_dend_Gtot = {KV3_dend_Gtot} + {Kv3_GP_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV3 {({getfield {mycompt}/Kv3_GP Gbar})}
        end
    end

    if ({exists {mycompt}/Kv3_GP_somahill})
        Kv3_GP_somahill_tmpVal = {({getfield {mycompt}/Kv3_GP_somahill Gbar})}
        KV3_soma_Gtot = {KV3_soma_Gtot} + {Kv3_GP_somahill_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV3 {({getfield {mycompt}/Kv3_GP_somahill Gbar})}
        end
    end

    if ({exists {mycompt}/Kv3_GP_dend3_distal25compts})
        Kv3_GP_dend3_distal25compts_tmpVal = {({getfield {mycompt}/Kv3_GP_dend3_distal25compts Gbar})}
        KV3_dend_Gtot = {KV3_dend_Gtot} + {Kv3_GP_dend3_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV3 {({getfield {mycompt}/Kv3_GP_dend3_distal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv3_GP_dend3_mid25compts})
        Kv3_GP_dend3_mid25compts_tmpVal = {({getfield {mycompt}/Kv3_GP_dend3_mid25compts Gbar})}
        KV3_dend_Gtot = {KV3_dend_Gtot} + {Kv3_GP_dend3_mid25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV3 {({getfield {mycompt}/Kv3_GP_dend3_mid25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv3_GP_dend3_proximal25compts})
        Kv3_GP_dend3_proximal25compts_tmpVal = {({getfield {mycompt}/Kv3_GP_dend3_proximal25compts Gbar})}
        KV3_dend_Gtot = {KV3_dend_Gtot} + {Kv3_GP_dend3_proximal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV3 {({getfield {mycompt}/Kv3_GP_dend3_proximal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv3_GP_dend2_distal25compts})
        Kv3_GP_dend2_distal25compts_tmpVal = {({getfield {mycompt}/Kv3_GP_dend2_distal25compts Gbar})}
        KV3_dend_Gtot = {KV3_dend_Gtot} + {Kv3_GP_dend2_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV3 {({getfield {mycompt}/Kv3_GP_dend2_distal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv3_GP_dend2_proximal25compts})
        Kv3_GP_dend2_proximal25compts_tmpVal = {({getfield {mycompt}/Kv3_GP_dend2_proximal25compts Gbar})}
        KV3_dend_Gtot = {KV3_dend_Gtot} + {Kv3_GP_dend2_proximal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV3 {({getfield {mycompt}/Kv3_GP_dend2_proximal25compts Gbar})}
        end
    end

    if ({exists {mycompt}/Kv3_GP_dend1_distal25compts})
        Kv3_GP_dend1_distal25compts_tmpVal = {({getfield {mycompt}/Kv3_GP_dend1_distal25compts Gbar})}
        KV3_dend_Gtot = {KV3_dend_Gtot} + {Kv3_GP_dend1_distal25compts_tmpVal}

        if ({echoGate} == 1)
            echo {mycompt} KV3 {({getfield {mycompt}/Kv3_GP_dend1_distal25compts Gbar})}
        end
    end

end

echo
echo NaF_soma_Gtot {NaF_soma_Gtot}
echo NaS_soma_Gtot {NaS_soma_Gtot}
echo KV2_soma_Gtot {KV2_soma_Gtot}
echo KV3_soma_Gtot {KV3_soma_Gtot}
echo NaF_dend_Gtot {NaF_dend_Gtot}
echo NaS_dend_Gtot {NaS_dend_Gtot}
echo KV2_dend_Gtot {KV2_dend_Gtot}
echo KV3_dend_Gtot {KV3_dend_Gtot}
echo
