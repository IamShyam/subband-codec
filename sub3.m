clear all
close all

%------------------------Analysis of the Read data------------------------%
[data, fs, bit] = wavread('D:\College Academia\5th Sem\Projects\Subbandcoding\tests\test2.wav');

%   Choosing one channel from the stereo audio for simplicity
data = data(:,1);

%   Frequency range defined
freq_range = -pi:2*pi/(length(data)-1):pi;

%   First level filtering
[el, eh] = subband_returncomp(data);

%   Second Level filtering
[ell, elh] = subband_returncomp(el);
[ehl, ehh] = subband_returncomp(el);

%   Coded and quantized form of the filtered outputs
ell_quant = subband_quant(ell);
elh_quant = subband_quant(elh);
ehl_quant = subband_quant(ehl);
ehh_quant = subband_quant(ehh);

%--------------------------Synthesis of the data--------------------------%

%   Arbitrary order of the filter is chosen
ord = 25;
reconstruction_filter = fir1(ord-1, 0.5, 'low');

%   All encoded bands are now being decoded
dll = compand(ell_quant, 255, max(ell_quant), 'mu/expander');
dlh = compand(elh_quant, 255, max(elh_quant), 'mu/expander');
dhl = compand(ehl_quant, 255, max(ehl_quant), 'mu/expander');
dhh = compand(ehh_quant, 255, max(ehh_quant), 'mu/expander');

%   The decoded bands are now passed through the reconstruction filter -
%   Level 1
dl = subband_reconstruct(reconstruction_filter, dll, dhl);
dh = subband_reconstruct(reconstruction_filter, dlh, dhh);

%   Final reconstruction - Level 2
sub = subband_reconstruct(reconstruction_filter, dl, dh);

%-------------------------Simulation Results------------------------------%

figure(1)
subplot(221)
plot(data)
title('Original Signal - Time Domain')
ylabel('Amplitude')
xlabel('time')
grid on

subplot(222)
plot(sub)
title('Compressed Signal - Time Domain')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(223)
plot(freq_range/pi, abs(subband_retfreq(data, length(data))))
title('Original Signal - Freq Domain')
ylabel('Amplitude')
xlabel('Frequency')
grid on

subplot(224)
plot(freq_range/pi, abs(subband_retfreq(sub, length(data))))
title('Compressed Signal - Freq Domain')
ylabel('Amplitude')
xlabel('Frequency')
grid on

figure(2)
subplot(221)
plot(ehl)
title('Encoded Band 3')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(222)
plot(dhl)
title('Decoded Band 3')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(223)
plot(ehh)
title('Encoded Band 4')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(224)
plot(dhh)
title('Decoded Band 4')
ylabel('Amplitude')
xlabel('Time')
grid on

figure(3)
subplot(221)
plot(ell)
title('Encoded Band 1')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(222)
plot(dll)
title('Decoded Band 1')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(223)
plot(elh)
title('Encoded Band 2')
ylabel('Amplitude')
xlabel('Time')
grid on

subplot(224)
plot(dlh)
title('Decoded Band 2')
ylabel('Amplitude')
xlabel('Time')
grid on

pause;
subband_player(data, fs)
subband_player(2*sub, fs)
%wavwrite(sub, fs, bit, 'Compressed2')