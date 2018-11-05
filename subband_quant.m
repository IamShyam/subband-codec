function q = subband_quant(sig)

%------------------------Input Arguments----------------------------------%
%                                                                         %
%   sig = The input signal                                                %
%                                                                         %
%-------------------------------------------------------------------------%

%   Mu Value for companding (default 255)
Mu = 255;

%   The max value of the signal
V = max(sig);

%   The number of bits to be encoded +1, raised to the power of 2
N = 2^9;

%   Manipulations for smooth companding
sig_min = min(sig) - 1/N;
sig_max = max(sig) + 1/N;

%   Companding
compsig = compand(sig, Mu, V, 'mu/compressor');

%   Partition and codebook for Quantisation
partition = sig_min:1/N:sig_max-1/N;
codebook = sig_min:1/N:sig_max;

%   Quantised signal
[~, q] = quantiz(compsig, partition, codebook);