function output = createAllPasses(inputAudio, APgain, APSampleDelays, numberAllPass)

for n=1:numberAllPass
    inputAudio = AllPassFilter(inputAudio, APgain, APSampleDelays(n));
end

output = inputAudio;