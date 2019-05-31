
// stimComptsNum reflects the number of compartments receiving a stimulus

str PRC_scale = "../common/comptlists/25compts_uniform_weights.txt"
//soma stimulus
if ({stimComptsIdx}==1)
    stimComptsNum = 1
    str strStimLoc = "_soma_"
    str PRCfilename = "../common/comptlists/nws_soma_only.txt"
    str PRC_scale = "../common/comptlists/soma_weight.txt"
end


//FULL (dendsort) dendrite divided into thirds of the range of electrotonic distances
if ({stimComptsIdx}==2)
    stimComptsNum = 247
    str strStimLoc = "proximal_FULL"
    str PRCfilename = "../common/comptlists/nws_proximal_FULLdendcompts.txt"
    if ({stimType}==2 || {stimType}==3)
        PRC_scale = "../common/comptlistsFULLproximal_uniform_weights.txt"
    end
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "../common/comptlists/FULLproximal_weights.txt"
    end
end

if ({stimComptsIdx}==3)
    stimComptsNum = 227
    str strStimLoc = "mid_FULL"
    str PRCfilename = "../common/comptlists/nws_mid_FULLdendcompts.txt"
    if ({stimType}==2 || {stimType}==3)
        PRC_scale = "../common/comptlists/FULLmid_uniform_weights.txt"
    end
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "../common/comptlists/FULLmid_weights.txt"
    end
end

if ({stimComptsIdx}==4)
    stimComptsNum = 37
    str strStimLoc = "distal_FULL"
    str PRCfilename = "../common/comptlists/nws_distal_FULLdendcompts.txt"
    if ({stimType}==2 || {stimType}==3)
        PRC_scale = "../common/comptlists/FULLdistal_uniform_weights.txt"
    end
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "../common/comptlists/FULLdistal_weights.txt"
    end
end


//THIRDS (dendsort) dendrite divided into thirds of compartments sorted by ED
if ({stimComptsIdx}==5)
    stimComptsNum = 171
    str strStimLoc = "proximal_THIRDS"
    str PRCfilename = "../common/comptlists/nws_proximal_THIRDSdendcompts.txt"
    if ({stimType}==2 || {stimType}==3)
        PRC_scale = "../common/comptlists/THIRDSproximal_uniform_weights.txt"
    end
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "../common/comptlists/THIRDSproximal_weights.txt"
    end
end

if ({stimComptsIdx}==6)
    stimComptsNum = 170
    str strStimLoc = "mid_THIRDS"
    str PRCfilename = "../common/comptlists/nws_mid_THIRDSdendcompts.txt"
    if ({stimType}==2 || {stimType}==3)
        PRC_scale = "../common/comptlists/THIRDSmid_uniform_weights.txt"
    end
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "../common/comptlists/THIRDSmid_weights.txt"
    end
end

if ({stimComptsIdx}==7)
    stimComptsNum = 170
    str strStimLoc = "distal_THIRDS"
    str PRCfilename = "../common/comptlists/nws_distal_THIRDSdendcompts.txt"
    if ({stimType}==2 || {stimType}==3)
        PRC_scale = "../common/comptlists/THIRDSdistal_uniform_weights.txt"
    end
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "../common/comptlists/THIRDSdistal_weights.txt"
    end
end


//SUB (dendsort) a random sample of 33 compartments chosen from THIRDS divisions
if ({stimComptsIdx}==8)
    stimComptsNum = 33
    str strStimLoc = "proximal_SUB"
    str PRCfilename = "../common/comptlists/nws_proximal_SUBdendcompts.txt"
    if ({stimType}==2 || {stimType}==3)
        PRC_scale = "../common/comptlists/SUBuniform33_weights.txt"
    end
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "../common/comptlists/SUBproximal_weights.txt"
    end
end

if ({stimComptsIdx}==9)
    stimComptsNum = 33
    str strStimLoc = "mid_SUB"
    str PRCfilename = "../common/comptlists/nws_mid_SUBdendcompts.txt"
    if ({stimType}==2 || {stimType}==3)
        PRC_scale = "../common/comptlists/SUBuniform33_weights.txt"
    end
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "../common/comptlists/SUBmid_weights.txt"
    end
end

if ({stimComptsIdx}==10)
    stimComptsNum = 33
    str strStimLoc = "distal_SUB"
    str PRCfilename = "../common/comptlists/nws_distal_SUBdendcompts.txt"
    if ({stimType}==2 || {stimType}==3)
        PRC_scale = "../common/comptlists/SUBuniform33_weights.txt"
    end
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "../common/comptlists/SUBdistal_weights.txt"
    end
end


