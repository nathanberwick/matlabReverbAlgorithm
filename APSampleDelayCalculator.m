function output = APSampleDelayCalculator(currentEchoDensity, targetEchoDensity, numberAllPass, Fs)

APConst = nthroot(targetEchoDensity/currentEchoDensity, numberAllPass);
lowerAP = APConst - (APConst*0.1);
upperAP = APConst + (APConst*0.1);
output = round(linspace(lowerAP, upperAP, numberAllPass) * (Fs/1000));