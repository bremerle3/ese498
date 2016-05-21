
samplesPerSymbol = 128;
numSymbols = 8;
periodInput = linspace(0,2*pi,samplesPerSymbol);
randArray = [];
for i = 1:numSymbols
    if (rand()>.5)
        temp = 1;
    else
        temp = -1;
    end
    randArray = [randArray temp];
end
array = [];
for i = 1:numSymbols
    for j = periodInput
        array = [array cos(j)*randArray(i)];
    end
end
% 
% figure;
% plot(array,'o');
% title('BPSK symbols');

local_oscillator = [];
for i = periodInput 
     local_oscillator = [local_oscillator cos(i)];
end
% 
% figure;
% plot(local_oscillator,'o'); 
% title('local_oscillator ');


array = [[0 0 0 0] array(1:end-4)];


shift_array = [];

shift = 0;
for i = 1:numSymbols-1
   if (i > 1)
        energy = [];
        temp_e = 0;
        for j = samplesPerSymbol*(i-1)+1:1:samplesPerSymbol*(i+1) 
                for k = 1:samplesPerSymbol
                    temp_e = (temp_e + local_oscillator(k)*array(j+k+floor(shift)));
                end
            energy = [energy temp_e];
            temp_e = 0;
        end
        energy = energy.^2;
        error = shift - (find(energy == max(energy(:)),1) - 1);
        if (abs(error) > floor(samplesPerSymbol/2))
            error = mod(samplesPerSymbol, abs(error));
        end
        shift = ((shift + error) + shift)/2;
        shift_array = [shift_array shift];
   else
       shift = 0;
       error = shift;
       shift = ((shift + error) + shift)/2;
       shift_array = [shift_array shift];
   end
end

    

% energy = [];    
% temp_e = 0;
% for i = 0:1:(size(array,2) - size(periodInput,2)) 
%    for j = 1:size(periodInput,2)
%        temp_e = (temp_e + local_oscillator(j)*array(i+j));
%    end
%    energy = [energy temp_e];
%    temp_e = 0;
% end

%energy = energy.^2;

% figure; 
% plot(energy,'o');
% title('Energy');

pause;
close all;