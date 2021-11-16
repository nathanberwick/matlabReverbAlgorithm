function output = createCombs(inputAudio, combMatrix, gain, HFDamping, isRight, Fs)

output = zeros(length(combMatrix),length(inputAudio));

for n=1:length(combMatrix)
    if (isRight == true && (mod(n,2) == 0))
        output(n, :) = createIIRComb(inputAudio, -gain, combMatrix(n), HFDamping, Fs); 
        continue;
    end
    output(n, :) = createIIRComb(inputAudio, gain, combMatrix(n), HFDamping, Fs);   
end