function ret = subband_reconstruct(filter, sigl, sigh)

%---------------------------Input arguments-------------------------------%
%                                                               
%   filter = the reconstruction filter handler
%   sigl = First input signal (low)
%   sigh = Second input signal (high)
%
%-------------------------------------------------------------------------%

%   Template for upsampling
temp1 = zeros(1, 2*length(sigl));
temp2 = zeros(1, 2*length(sigh));

%   Upsampling
temp1(2:2:length(temp1)) = sigl;
temp2(2:2:length(temp2)) = sigh;

%   Passing through the filter
temp_filtered1 = conv(temp1, filter, 'same');
temp_filtered2 = conv(temp2, filter, 'same');

%   The returned signal
ret = temp_filtered1 + temp_filtered2;