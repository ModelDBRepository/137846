//default PRC_scale:
str PRC_scale = "../common/comptlists/25compts_uniform_weights.txt"

if ({stimComptsIdx}==11)
    stimComptsNum = 25
    str strStimLoc = "_d1p_"
    str PRCfilename = "../common/comptlists/dend1_proximal25compts.txt"
    PRC_scale = "../common/comptlists/25compts_uniform_weights.txt"
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "incomplete_masterScript"
    end
end

if ({stimComptsIdx}==12)
    stimComptsNum = 25
    str strStimLoc = "_d1d_"
    str PRCfilename = "../common/comptlists/dend1_distal25compts.txt"
    PRC_scale = "../common/comptlists/25compts_uniform_weights.txt"
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "incomplete_masterScript"
    end
end

if ({stimComptsIdx}==13)
    stimComptsNum = 25
    str strStimLoc = "_d2p_"
    str PRCfilename = "../common/comptlists/dend2_proximal25compts.txt"
    PRC_scale = "../common/comptlists/25compts_uniform_weights.txt"
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "incomplete_masterScript"
    end
end

if ({stimComptsIdx}==14)
    stimComptsNum = 25
    str strStimLoc = "_d2d_"
    str PRCfilename = "../common/comptlists/dend2_distal25compts.txt"
    PRC_scale = "../common/comptlists/25compts_uniform_weights.txt"
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "incomplete_masterScript"
    end
end

if ({stimComptsIdx}==15)
    stimComptsNum = 25
    str strStimLoc = "_d3p_"
    str PRCfilename = "../common/comptlists/dend3_proximal25compts.txt"
    PRC_scale = "../common/comptlists/25compts_uniform_weights.txt"
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "incomplete_masterScript"
    end
end

if ({stimComptsIdx}==16)
    stimComptsNum = 25
    str strStimLoc = "_d3m_"
    str PRCfilename = "../common/comptlists/dend3_mid25compts.txt"
    PRC_scale = "../common/comptlists/25compts_uniform_weights.txt"
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "incomplete_masterScript"
    end
end

if ({stimComptsIdx}==17)
    stimComptsNum = 25
    str strStimLoc = "_d3d_"
    str PRCfilename = "../common/comptlists/dend3_distal25compts.txt"
    PRC_scale = "../common/comptlists/25compts_uniform_weights.txt"
    if ({stimType}==4 || {stimType}==5)
        PRC_scale = "incomplete_masterScript"
    end
end
