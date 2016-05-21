function [ totalShiftArray] = getTimingOffsetV4( samplesPerSymbol, numSymbols, array)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% a = load('badInput');
% array=a.array;
 periodInput = linspace(0,2*pi,samplesPerSymbol);

local_oscillator = [];
for i = periodInput 
     local_oscillator = [local_oscillator cos(i)];
end

currentShiftArray = [];

numAvgOver = 8;

shift = 0;

for i = 1:numSymbols-1
   if (i > 1)
        energy = [];
        temp_e = 0;
        if((i < numAvgOver-1 && (mod(i,numAvgOver) ~= 0)))
          upper =  ( (i-1)*samplesPerSymbol);
          lower = ( (i-2)*samplesPerSymbol)+1;
        else
           upper =  (totalShiftArray(end) + (i-1)*samplesPerSymbol);
           lower = (totalShiftArray(end) + (i-2)*samplesPerSymbol)+1;
        end
        
        for j = lower:1:upper 
            for k = 0:samplesPerSymbol-1
                temp_e = (temp_e + local_oscillator(k+1)*array(j+k));
            end
            energy = [energy temp_e];
            temp_e = 0;     
        end   
        
        figure;
        demod = array(lower:1:(upper + samplesPerSymbol)).*[local_oscillator local_oscillator];
        plot(demod, 'o');
        title('demod');
        
        figure;
        plot(energy, 'o');
        title('Integral');
%         
        
        energy = energy.^2;      
        
        
        figure;
        plot(energy, 'o');
        title('Energy');
        
        figure;
        plot(array(lower:1:(upper + samplesPerSymbol)), 'o');
        title('Array Subset');
        pause;

      
        
        e_max = find(energy==max(energy(:)),1) -1;
         error = e_max;
          close all;
%         if (e_max >= floor(samplesPerSymbol/2))
%             error = -(samplesPerSymbol-e_max) + 1;
%         else
%             error = e_max;
%         end
        shift = error;
        currentShiftArray = [currentShiftArray shift];
        if (i>=numAvgOver && (mod(i,numAvgOver) == 0))
            shift = (sum(currentShiftArray(size(currentShiftArray,2)-numAvgOver+1:end)))/numAvgOver;
            shiftAvg = round(   (3/4)*((shift+totalShiftArray(end))+ (1/4)*totalShiftArray(end)));
            totalShiftArray = [totalShiftArray shiftAvg]; 
        end
        
   else
       totalShiftArray = 0; 
       shiftAvg = 0;
       shift = 0;
       error = shift;
       currentShiftArray = [currentShiftArray shift];
   end
end

figure; 
plot(totalShiftArray,'o');
title('totalShiftArray');

% figure; 
% plot(energy,'o');
% title('Energy');

figure; 
plot(currentShiftArray,'o');
title('currentShiftArray');
% 
% if (shift ~= -10)
%     save('badInput', 'array');
% end

pause;
close all;
end

