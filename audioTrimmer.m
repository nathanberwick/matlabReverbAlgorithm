function output = audioTrimmer(inputAudio, lengthMs, Fs)
%trims audio to length in ms, padding rest of  file with 0s

sizeSamples = round(lengthMs * (Fs/1000));

remainder = zeros(length(inputAudio)-sizeSamples, 1);
audio = inputAudio(1:sizeSamples);

output = [audio; remainder];