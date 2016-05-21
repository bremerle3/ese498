function outputArray = modulator(data,samplesPerSymbol,numChannels)
    numSymbolPeriods=size(data,2)/numChannels;
    outputArray=zeros(1,numSymbolPeriods*samplesPerSymbol);
    for i = 1:numSymbolPeriods
       fftData=[0 data((i-1)*numChannels+1:i*numChannels)];
       outputArray((i-1)*samplesPerSymbol+1:i*samplesPerSymbol)=real(ifft(fftData,samplesPerSymbol));
    end
end