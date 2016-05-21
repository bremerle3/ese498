function output = genRandBitstream(numPoints)

output = [];
for i = 1:numPoints
    if (rand(1,1) < 0.5)
        output = [output -1];
    else
        output = [output 1];
    end 
end
