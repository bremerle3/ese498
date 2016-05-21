function maxIndex = getTimingOffsetv2(array,samplesPerSymbol)
numSymbols = size(array,2)/samplesPerSymbol;
numAverages=numSymbols-1;
maxIndex=1;
maxEnergy=0;
energyArray = [];
for i = 1:samplesPerSymbol
    %tempE = array((i-1)*samplesPerSymbol+1:i*samplesPerSymbol).*array((i-1)*samplesPerSymbol+1:i*samplesPerSymbol);
    %TSum = 0;
    subarray=array(i:i+samplesPerSymbol*numAverages-1);
    oscillator=cos(2*pi/numAverages*linspace(0,1,samplesPerSymbol*numAverages));
    subarray=subarray.*oscillator;
    subarray=subarray.*subarray;
    TSum=sum(subarray);
%     for j = 1:samplesPerSymbol
%        % TSum = TSum + array(i+j-1)*array(i+j-1);
%         TSum = TSum + array(i+j-1);
%     end
    if (TSum>maxEnergy)
        maxEnergy=TSum;
        maxIndex=i+1;
    end
    %energyArray = [energyArray TSum];
end 

%plot(energyArray)