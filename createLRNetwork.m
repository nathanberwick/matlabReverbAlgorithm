function [LRleft, LRright] = createLRNetwork(ERAudio, dryAudio, delayedAudioForLRTaps, params, numberCombs, modalDensity, numberAllPass, targetEchoDensity, Fs)
%% variable calculation
offset                = params.latestER + params.LROffset + params.preDelay;
currentEchoDensity    = numberCombs^2 / modalDensity;
msDelay               = (numberCombs / currentEchoDensity) * 1000;
combGain              = combGainCalculate(msDelay, params.reverbTime);
combMatrix            = round(linspace(msDelay, msDelay*1.5, numberCombs)*(Fs/1000));
combMatrix            = nextprime(combMatrix); %make prime
APSampleDelays        = APSampleDelayCalculator(currentEchoDensity, targetEchoDensity, numberAllPass, Fs);
LRInput               = ERAudio + dryAudio + delayedAudioForLRTaps;

%% all pass
allPasses = createAllPasses(LRInput, params.spread, APSampleDelays, numberAllPass);

%% create combs
combsLeft  = createCombs(allPasses, combMatrix, combGain, params.HFDamping, false, Fs);
combsRight = createCombs(allPasses, combMatrix, combGain, params.HFDamping, true, Fs);

%% sum combs
LRleft  = sum(combsLeft, 1)  / size(combsLeft,1); % - inputAudio; %remove dry audio
LRright = sum(combsRight, 1) / size(combsRight,1);

%% delay

offset  = round(offset * (Fs/1000));
LRleft =  Delay(LRleft, offset);
LRright = Delay(LRright, offset);
     
%% EQ
LRleft  = EQ(LRleft,  params.LRLFGain, params.LRMidsGain, params.LRHFGain, Fs);
LRright = EQ(LRright, params.LRLFGain, params.LRMidsGain, params.LRHFGain, Fs);
