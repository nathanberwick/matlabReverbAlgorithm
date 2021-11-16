function output = setParameters(params)
params.preDelay              = 20; %value in ms. 0ms to 5000ms
params.tempo                 = 120; %bpm 1 - 320
params.wetDry                = 0.5; %wet = value. dry = 1-value %between 0 and 1

%early reflections
params.ERMasterGain          = 1;   % 0 to 1
params.ERLFGain              = 0.7;   % 0 to 4
params.ERMidsGain            = 1;   % 0 to 4
params.ERHFGain              = 1;   % 0 to 4
params.isEROn                = true;
params.roomSize              = 20; %metres
params.latestER              = 80; %in ms 0 to 200
params.numberERs             = 4; %between 1 and 15 for 80ms
params.absorptionCoefficient = 0.8; %between 0 and 1.

%late reflections
params.LRMasterGain          = 0.2; % 0 to 1
params.LRLFGain              = 1; % 0 to 4
params.LRMidsGain            = 1.0; % 0 to 4
params.LRHFGain              = 0.7; % 0 to 4
params.HFDamping             = 0.3; % use 0 to 1, 1 = max damping
params.LROffset              = 0; %cannot begin before audio. Can have minimum -maxERDelay
params.reverbTime            = 1000;  %in ms between 20 and 10000
params.spread                = 0.5; %between 0 and 0.9

%delayed IIR for tapped inputs to LRNetwork
params.delayLineGain         = 0; %between 0 and 1
params.delayLineFeedback     = 0.7; %between 0 and 0.9
params.division              = 2; % 1 = whole note, 2 = half note, 4 = quarter note, 8 = eigth note, 16 = sixteenth note, 32 = thirty second note
params.isDotted              = true;
params.isTripleted           = false;
params.isDelayFiltered       = true;
params.delayCutoff           = 16000;

params.chorusIntensity       = 0.7; %0 to 1
params.chorusDepth           = 0.5; %0 to 1

output = params;