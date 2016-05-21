%Testbench Script
    %No Pulse Shaping
    %No Noise
    %No Shifting
   
%%
%Generate bitstream

numPoints = 128;
bitstream = genRandBitstream(numPoints);

%%
%Modulate (subcarriers from 1 Hz)

data = bitstream;
samplesPerSymbol = 16;
numChannels = 1;    
modulatedData = modulator(data,samplesPerSymbol,numChannels);
%plot
figure;
plot(modulatedData,'o')
title('modulatedData');

%%
%Channel (add noise, time shifts)
inputArray = modulatedData;
arrayShift = 4;
channelData =  addArrayShift(inputArray,arrayShift);
figure;
plot(channelData,'o')
title('symbolsInChannel');

%%
%Figure out symbol timing offset
shiftEstimate = getTimingOffsetv4(channelData,samplesPerSymbol);
numSamples=numPoints*samplesPerSymbol;
left=channelData(numSamples-shiftEstimate+1:end);
right=channelData(1:numSamples-shiftEstimate);
channelData =  [left right];
figure;
plot(channelData,'o')
title('recovered signal');


%%
%Demodulate
data = channelData;
demodulatedData = demodulator(data,samplesPerSymbol,numChannels);
%plot
% figure;
% stem(demodulatedData,'o')
% title('demodulatedData');

%%
%Compare with original bitstream
bitErrorRate=1-sum(bitstream==demodulatedData)/numPoints;
disp(['Bit Error Rate is ' num2str(bitErrorRate)]);

% figure;
% stem(bitstream,'o')
% title('Original Bitstream');


%%
%Cleanup
pause;
close all;
