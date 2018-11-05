function [lpcomp, hpcomp] = subband_returncomp(sig)

%   The order is arbitrarily taken to be 25
ord = 25;

% using the inbuilt command fir
lp = fir1(ord-1, 0.5, 'low');
%[lpcomp, wlp] = freqz(lp, 1);

hp = fir1(ord-1, 0.5, 'high');
%[hpcomp, whp] = freqz(hp, 1);

lpcomp = conv(sig, lp, 'same');
hpcomp = conv(sig, hp, 'same');

lpcomp = lpcomp(2:2:length(lpcomp));
hpcomp = hpcomp(2:2:length(hpcomp));
