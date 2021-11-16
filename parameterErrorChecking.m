function output = parameterErrorChecking(params, Fs)
%% Master settings

% pre delay
if(params.preDelay < 0)
    params.preDelay = 0;
elseif (params.preDelay > 5000)
    params.preDelay = 5000;
end

% tempo
if (params.tempo < 1)
    params.tempo = 1;
elseif (params.tempo > 320)
    params.tempo = 320;
end

% wet dry
params.wetDry = errorCheck01(params.wetDry);

%% Early reflections
% room size
if (params.roomSize < 0.1)
    params.roomSize = 0.1;
elseif (params.roomSize > 100)
    params.roomSize = 100;
end

% absorption coefficient
if (params.absorptionCoefficient < 0)
    params.absorptionCoefficient = 0;
elseif (params.absorptionCoefficient > 1)
    params.absorptionCoefficient = 1;
end

% max ER Delay must be positive
if(params.latestER < 0)
    params.latestER = 0;
elseif(params.latestER > 200)
    params.latestER = 200;
end


% number ERs
if (params.numberERs < 1)
    params.numberERs = 1;
end
params.numberERs = round(params.numberERs); %MUST BE WHOLE NUMBER

% gains and EQ
params.ERMasterGain = errorCheck01(params.ERMasterGain);
params.ERLFGain     = gainErrorCheck(params.ERLFGain);
params.ERMidsGain   = gainErrorCheck(params.ERMidsGain);
params.ERHFGain     = gainErrorCheck(params.ERHFGain);

%% Late reflections

% LR Offset
if (params.LROffset < -(params.latestER + params.preDelay))
    params.LROffset = -(params.latestER + params.preDelay);
end

% spread
params.spread = errorCheckPoint9(params.spread);

% HF damping
params.HFDamping = errorCheck01(params.HFDamping);

% gains and EQ
params.LRMasterGain = errorCheck01(params.LRMasterGain);
params.LRLFGain     = gainErrorCheck(params.LRLFGain);
params.LRMidsGain   = gainErrorCheck(params.LRMidsGain);
params.LRHFGain     = gainErrorCheck(params.LRHFGain);

%% Late reflection delay network

% note division

if (params.division > 32 || (isPowerOfTwo(params.division) == false))
    params.division = 4;
end

% delay line gain
params.delayLineGain = errorCheck01(params.delayLineGain);
        
% feedback
params.delayLineFeedback = errorCheckPoint9(params.delayLineFeedback);

if (params.reverbTime < 20)
    params.reverbTime = 20;
elseif (params.reverbTime > 10000)
    params.reverbTime = 10000;
end

% delay cutoff
if (params.delayCutoff > (Fs/2))
    params.delayCutoff = Fs/2;
elseif (params.delayCutoff <= 0)
    params.delayCutoff = 1;
end
%% Chorus

% intensity
params.chorusIntensity = errorCheck01(params.chorusIntensity);

% depth
if (params.chorusDepth > 1)
    params.chorusDepth = 1;
elseif (params.chorusDepth < 0.1)
    params.chorusDepth = 0.1;
end

%% output
output = params;