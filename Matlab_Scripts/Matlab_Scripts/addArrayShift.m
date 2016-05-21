function outputArray = addArrayShift(inputArray,arrayShift)
n=size(arrayShift,2);
blockSize = floor(size(inputArray,2)/n);
outputArray=zeros(1,size(inputArray,2));
for i=1:n
%outputArray = inputArray(arrayShift:end)
%outputArray = [outputArray zeros(1,arrayShift-1)]
%outputArray = [outputArray inputArray(1:arrayShift-1)]
leftHalf=inputArray((i-1)*blockSize+1+arrayShift(i):i*blockSize);
rightHalf= inputArray((i-1)*blockSize+1:(i-1)*blockSize+arrayShift(i));
outputArray( (i-1)*blockSize+1 : i*blockSize)= [leftHalf rightHalf];
end