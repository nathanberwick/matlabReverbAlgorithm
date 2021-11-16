function delayedBuffer = Delay(inputBuffer, delayInSamples)

zeroBuffer = zeros(1,delayInSamples);

rotatedAudio = circshift(inputBuffer, delayInSamples);
delayedBuffer = [zeroBuffer, rotatedAudio(delayInSamples+1:length(inputBuffer))];