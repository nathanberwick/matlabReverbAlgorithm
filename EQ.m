function output = EQ(inputAudio, LFGain, midsGain, HFGain ,Fs)

LPFc = 400;
HPFc = 4000;
N=4; %FILTER ORDER MUST BE EVEN

lowPass  = filterGenLP(LPFc, Fs, N);
bandPass = filterGenBP(LPFc, HPFc, Fs, N);
highPass = filterGenHP(HPFc, Fs, N);

lows  = filter(lowPass.numerator, lowPass.denominator, inputAudio);
mids  = filter(bandPass.numerator, bandPass.denominator, inputAudio);
highs = filter(highPass.numerator, highPass.denominator, inputAudio);

output = (lows * LFGain) + (mids * midsGain) + (highs * HFGain);



