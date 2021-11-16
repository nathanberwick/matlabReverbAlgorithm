function Hd = filterGenLP(Fc, Fs, N) %cutoffFreq, sampleRate, order
%TEST Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.2 and the Signal Processing Toolbox 7.4.
% Generated on: 26-Oct-2018 10:10:22

% Butterworth Lowpass filter designed using FDESIGN.LOWPASS.

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass('N,F3dB', N, Fc, Fs);
Hd = design(h, 'butter');

% Get the transfer function values.
[b, a] = tf(Hd);

% Convert to a singleton filter.
Hd = dfilt.df2(b, a);



% [EOF]
