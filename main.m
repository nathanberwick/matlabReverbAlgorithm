clear all;

%% audio input
[dryAudio, Fs] = audioread('distortion.wav');
inputLengthMs = 5000;
dryAudio = audioTrimmer(dryAudio, inputLengthMs, Fs);
dryAudio = dryAudio';

%% variable declaration
targetEchoDensity            = 1000; %NON PARAM
numberCombs                  = 6;    %NON PARAM
modalDensity                 = 0.15; %NON PARAM
numberAllPass                = 2;    %NON PARAM
speedOfSound                 = 343;  %NON PARAM
params = createParameterStruct();    %creates parameters with default values

%USER PARAMETERS ARE AVAILABLE WITHIN setParameters.m
%% read in / save values
readInPreset          = true;
manuallySetParameters = false; %this overwrites the preset
saveSettings          = false;
writeAudioFile        = true;
wavFileName           = 'distortionverb.wav';
readInFileName        = 'church.mat';
    %readInFileName options:
    %bathroom.mat
    %church.mat
    %ambient.mat
    %hall.mat
saveFileName          = 'saveFile1.mat';
%% text file read in
if (readInPreset == true)
    params = presetIn(readInFileName, params);
end

%% manual parameter setting
if (manuallySetParameters == true)
    params = setParameters(params); % edit parameters within this function
end

%% error checking
params = parameterErrorChecking(params, Fs);

%% text file save
if (saveSettings == true)
    presetSave(saveFileName, params);
end

%% early reflections
ERNetwork = 0;
if (params.isEROn == true && params.latestER > 0)
    ERNetwork = createERMatrix(dryAudio, params, speedOfSound, Fs);
end

%% late reflections
delayedAudioForLRTaps = 0;
if(params.delayLineGain > 0) %only calculate if necessary (to save time)
    delayedAudioForLRTaps = createDelayTap(dryAudio, params, Fs);
    delayedAudioForLRTaps = delayedAudioForLRTaps * params.delayLineGain;
end

[LRleft, LRright] = createLRNetwork(ERNetwork, dryAudio, delayedAudioForLRTaps, params, numberCombs, modalDensity, numberAllPass, targetEchoDensity, Fs);

%chorus
if (params.chorusIntensity > 0)
    LRleft  = chorusLR(LRleft,  params, Fs);
    LRright = chorusLR(LRright, params, Fs);
end

%% audio output

%sum wet signal
wetL = (ERNetwork * params.ERMasterGain) + (LRleft  * params.LRMasterGain);
wetR = (ERNetwork * params.ERMasterGain) + (LRright * params.LRMasterGain);

%wet dry mix
audioOutL = (dryAudio * (1 - params.wetDry)) + (wetL * params.wetDry);
audioOutR = (dryAudio * (1 - params.wetDry)) + (wetR * params.wetDry);

%combine to stereo
audioOut = [audioOutL; audioOutR];

%normalise
audioOut = normalise(audioOut)'; %flip matrix for wavwrite

%write wav
if(writeAudioFile == true)
    audiowrite(wavFileName, audioOut, Fs);
end

%output
sound(audioOut, Fs);