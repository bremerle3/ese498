
bits = binornd(1,0.5,[1 10]);
for i = 1:length(bits)
    if (bits(i) == 0)
        bits(i) = -1;
    end
end

samplesPerSymbol = 8;
data = zeros(1, samplesPerSymbol*length(bits));
for i = 1:bits
    for j = 1:samplesPerSymbol
       if (bits(i) == 1)
           data(i:i+samplesPerSymbol-1) = 1;
       elseif (bits(i) == -1)
           data(i:i+samplesPerSymbol-1) = -1;
       end
    end
end

periodInput = linspace(0,2*pi,samplesPerSymbol);
local_oscillator = [];
for i = periodInput 
     local_oscillator = [local_oscillator cos(i)];
end