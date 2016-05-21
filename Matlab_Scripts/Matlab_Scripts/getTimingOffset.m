function maxIndex = getTimingOffset(array,numPts)
maxIndex=0;
if (size(array,2)>=numPts*2)
sumOfSamples=sum(array(1:numPts));
%sumOfSamples=sum(fft(array(1:numPts)));
maxSum=abs(sumOfSamples);
for i=1:numPts
    sumOfSamples=sumOfSamples+array(i+numPts)-array(i);
    %sumOfSamples=sum(fft(array(i+1:i+numPts)).^2);
    %sumOfSamples=abs(sum(fft(array(i+1:i+numPts))));
    if (abs(sumOfSamples)>(maxSum+ 1e-6))
        maxSum=abs(sumOfSamples);
        maxIndex=i;
    end
end
end
end