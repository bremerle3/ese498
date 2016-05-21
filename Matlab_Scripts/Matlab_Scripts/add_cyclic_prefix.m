function outputArray = add_cyclic_prefix(array,samplesPerSymbol,prefixLength)
n=size(array,2)/samplesPerSymbol;
prefixLength=floor(prefixLength);
blockSize=samplesPerSymbol+prefixLength;
outputArray=zeros(1,blockSize*n);
for i=1:n
a=array(i*samplesPerSymbol-prefixLength+1:i*samplesPerSymbol);
b=array((i-1)*samplesPerSymbol+1:i*samplesPerSymbol);
outputArray(blockSize*(i-1)+1:blockSize*(i-1)+prefixLength)=a;
outputArray(blockSize*(i-1)+1+prefixLength:blockSize*i)=b;
end
end