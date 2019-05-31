//default multipliers of conductance densities in different regions of the dendrite
//these will be used for LOCAL upregulation or downregulation

float KV4F_PRC_scalefac=1
float KV4S_PRC_scalefac=1

float dend1_proximal_HVA_mult = 1
float dend1_distal_HVA_mult = 1
float dend1_proximal_SK_mult = 1
float dend1_distal_SK_mult = 1
float dend1_proximal_KV4F_mult = 1
float dend1_distal_KV4F_mult = 1
float dend1_proximal_KV4S_mult = 1
float dend1_distal_KV4S_mult = 1

float dend2_proximal_HVA_mult = 1
float dend2_distal_HVA_mult = 1
float dend2_proximal_SK_mult = 1
float dend2_distal_SK_mult = 1
float dend2_proximal_KV4F_mult = 1
float dend2_distal_KV4F_mult = 1
float dend2_proximal_KV4S_mult = 1
float dend2_distal_KV4S_mult = 1

float dend3_proximal_HVA_mult = 1
float dend3_mid_HVA_mult = 1
float dend3_distal_HVA_mult = 1
float dend3_proximal_SK_mult = 1
float dend3_mid_SK_mult = 1
float dend3_distal_SK_mult = 1
float dend3_proximal_KV4F_mult = 1
float dend3_mid_KV4F_mult = 1
float dend3_distal_KV4F_mult = 1
float dend3_proximal_KV4S_mult = 1
float dend3_mid_KV4S_mult = 1
float dend3_distal_KV4S_mult = 1



if ({stimComptsIdx}==11)
    dend1_proximal_HVA_mult = {HVA_PRC_scalefac}
    dend1_proximal_SK_mult = {SK_PRC_scalefac}
    dend1_proximal_KV4F_mult = {KV4F_PRC_scalefac}
    dend1_proximal_KV4S_mult = {KV4S_PRC_scalefac}
end

if ({stimComptsIdx}==12)
    dend1_distal_HVA_mult = {HVA_PRC_scalefac}
    dend1_distal_SK_mult = {SK_PRC_scalefac}
    dend1_distal_KV4F_mult = {KV4F_PRC_scalefac}
    dend1_distal_KV4S_mult = {KV4S_PRC_scalefac}
end

if ({stimComptsIdx}==13)
    dend2_proximal_HVA_mult = {HVA_PRC_scalefac}
    dend2_proximal_SK_mult = {SK_PRC_scalefac}
    dend2_proximal_KV4F_mult = {KV4F_PRC_scalefac}
    dend2_proximal_KV4S_mult = {KV4S_PRC_scalefac}
end

if ({stimComptsIdx}==14)
    dend2_distal_HVA_mult = {HVA_PRC_scalefac}
    dend2_distal_SK_mult = {SK_PRC_scalefac}
    dend2_distal_KV4F_mult = {KV4F_PRC_scalefac}
    dend2_distal_KV4S_mult = {KV4S_PRC_scalefac}
end

if ({stimComptsIdx}==15)
    dend3_proximal_HVA_mult = {HVA_PRC_scalefac}
    dend3_proximal_SK_mult = {SK_PRC_scalefac}
    dend3_proximal_KV4F_mult = {KV4F_PRC_scalefac}
    dend3_proximal_KV4S_mult = {KV4S_PRC_scalefac}
end

if ({stimComptsIdx}==16)
    dend3_mid_HVA_mult = {HVA_PRC_scalefac}
    dend3_mid_SK_mult = {SK_PRC_scalefac}
    dend3_mid_KV4F_mult = {KV4F_PRC_scalefac}
    dend3_mid_KV4S_mult = {KV4S_PRC_scalefac}
end

if ({stimComptsIdx}==17)
    dend3_distal_HVA_mult = {HVA_PRC_scalefac}
    dend3_distal_SK_mult = {SK_PRC_scalefac}
    dend3_distal_KV4F_mult = {KV4F_PRC_scalefac}
    dend3_distal_KV4S_mult = {KV4S_PRC_scalefac}
end



echo
echo dend1_proximal_HVA_mult is {dend1_proximal_HVA_mult}
echo dend1_proximal_SK_mult is {dend1_proximal_SK_mult}
echo dend1_proximal_KV4F_mult is {dend1_proximal_KV4F_mult}
echo dend1_proximal_KV4S_mult is {dend1_proximal_KV4S_mult}
echo dend1_distal_HVA_mult is {dend1_distal_HVA_mult}
echo dend1_distal_SK_mult is {dend1_distal_SK_mult}
echo dend1_distal_KV4F_mult is {dend1_distal_KV4F_mult}
echo dend1_distal_KV4S_mult is {dend1_distal_KV4S_mult}
echo dend2_proximal_HVA_mult is {dend2_proximal_HVA_mult}
echo dend2_proximal_SK_mult is {dend2_proximal_SK_mult}
echo dend2_proximal_KV4F_mult is {dend2_proximal_KV4F_mult}
echo dend2_proximal_KV4S_mult is {dend2_proximal_KV4S_mult}
echo dend2_distal_HVA_mult is {dend2_distal_HVA_mult}
echo dend2_distal_SK_mult is {dend2_distal_SK_mult}
echo dend2_distal_KV4F_mult is {dend2_distal_KV4F_mult}
echo dend2_distal_KV4S_mult is {dend2_distal_KV4S_mult}
echo dend3_proximal_HVA_mult is {dend3_proximal_HVA_mult}
echo dend3_proximal_SK_mult is {dend3_proximal_SK_mult}
echo dend3_proximal_KV4F_mult is {dend3_proximal_KV4F_mult}
echo dend3_proximal_KV4S_mult is {dend3_proximal_KV4S_mult}
echo dend3_mid_HVA_mult is {dend3_mid_HVA_mult}
echo dend3_mid_SK_mult is {dend3_mid_SK_mult}
echo dend3_mid_KV4F_mult is {dend3_mid_KV4F_mult}
echo dend3_mid_KV4S_mult is {dend3_mid_KV4S_mult}
echo dend3_distal_HVA_mult is {dend3_distal_HVA_mult}
echo dend3_distal_SK_mult is {dend3_distal_SK_mult}
echo dend3_distal_KV4F_mult is {dend3_distal_KV4F_mult}
echo dend3_distal_KV4S_mult is {dend3_distal_KV4S_mult}
echo

