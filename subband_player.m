function subband_player(sig, freq)

%-----------------------Input Arguments-----------------------------------%
%   sig = The signal to be played
%   freq = the frequency to which the signal should be played at
%-------------------------------------------------------------------------%

%   Signal player handler
player = audioplayer(sig, freq);

%   Playing sound
play(player)

pause;