function outputArray = demodulator(data,samplesPerSymbol,numChannels)
    numSymbolPeriods=size(data,2)/samplesPerSymbol;
    outputArray=zeros(1,numSymbolPeriods*numChannels);
    for i = 1:numSymbolPeriods
       fftData=data((i-1)*samplesPerSymbol+1:i*samplesPerSymbol);
       fftResult=real(fft(fftData,samplesPerSymbol));
       outputArray((i-1)*numChannels+1:i*numChannels)=fftResult(2:numChannels+1);
    end
    
    for i = 1:size(outputArray,2)
        if (outputArray(i) < 0)
            outputArray(i) = -1;
        else
            outputArray(i) = 1;
        end
    end
end