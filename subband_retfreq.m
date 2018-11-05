function f_sig = subband_retfreq(sig, len)

%-------------------------Input Arguments---------------------------------%
%   sig = Input signal to get the frequency representation
%   len = Length of the entire signal
%-------------------------------------------------------------------------%

%   Return the computed value
f_sig = fftshift(fft(sig, len));