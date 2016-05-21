%Testbench Script
    %No Pulse Shaping
    %No Noise
    %No Shifting
   
%%
%Generate bitstream

numSymbols= 1024;
bitstream = genRandBitstream(numSymbols);

%Generate known bitstream
% bitstream = [];
% for i = 1:numSymbols
%     if(mod(floor(i/32), 2) ==0)
%         bitstream = [bitstream 1];
%     else
%         if(mod(i,2) == 1)
%             bitstream = [bitstream -1];
%         else
%             bitstream = [bitstream 1];
%         end
%     end
% end

%%
%Modulate (subcarriers from 1 Hz)

data = bitstream;
samplesPerSymbol = 64;
numChannels = 1;    
numAvgOver = 16;
filterLength=16;
modulatedData = modulator(data,samplesPerSymbol,numChannels);
% plot
% figure;
% plot(modulatedData,'o')
% title('modulatedData');

%%
%Channel (add noise, time shifts)
inputArray = modulatedData;
arrayShift =   5;
% arrayShift = randi(samplesPerSymbol,1)-1;
inputArray=pulseShaping(inputArray);
inputArray=inputArray/max(inputArray);
channelData = addArrayShift(inputArray,arrayShift);     
    noiseSNR = 5   ;      
Eb_N0_db=noiseSNR;
Eb_N0=10^(Eb_N0_db/10);
sigma=sqrt((samplesPerSymbol/4)/Eb_N0);
noise=randn(size(channelData)) * sigma;
channelData = channelData + noise;
% channelData = awg n(channelData, noiseSNR);  %Adds AWGN by SNR in dB

% figure;
% plot(channelData,'o')
% title('Pulse Shaping with Noise');

%%
%Match filter
channelData=matchFiltering(channelData);
channelData=channelData(filterLength:size(channelData,2)-filterLength-1);
% figure;
% plot(channelData,'o')
% title('Matched Filtering with Noise');

%%
%%figure out symbol timing offset
[shiftArray, errorArray] = getTimingOffsetV5(samplesPerSymbol, numSymbols, channelData, numAvgOver);
shiftEstimate = shiftArray(end);

numSamples=numSymbols*samplesPerSymbol;
if shiftEstimate < 0
    channelData = channelData(shiftEstimate+samplesPerSymbol+1:end);
end
if shiftEstimate > 0
    channelData = channelData(shiftEstimate+1:end-(samplesPerSymbol-shiftEstimate));
end
%     left=channelData(numSamples+shiftEstimate+1:end);
%     right=channelData(1:numSamples+shiftEstimate);
%     channelData =  [left right];
% disp(['Shift is ' num2str(shiftEstimate)]);

% figure;
% plot(channelData,'o')
% title('recovered signal');


%%
%Demodulate
data = channelData;
demodulatedData = demodulator(data,samplesPerSymbol,numChannels);
%%plot
% figure;
% stem(demodulatedData,'o')
% title('demodulatedData');

%%
%Compare with original bitstream
originalBitstream = bitstream;
if shiftEstimate < 0
    bitstream = bitstream(2:end);
elseif shiftEstimate > 0
        bitstream = bitstream(1:end-1);
end
bitErrorRate=1-sum(bitstream==demodulatedData)/numSymbols;
% disp(['Bit Error Rate is ' num2str(bitErrorRate)]);

% figure;
% stem(bitstream,'o')
% title('Original Bitstream');


%%
%Cleanup
% pause;
close all;
