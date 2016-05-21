function [ totalShiftArray] = getTimingOffsetV5( samplesPerSymbol, numSymbols, array, numAvgOver)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% a = load('badInput');
% array=a.array;
 periodInput = linspace(0,2*pi,samplesPerSymbol);

local_oscillator = [];
for i = periodInput 
     local_oscillator = [local_oscillator cos(i)];
end

energyAverage = zeros(1,samplesPerSymbol);

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
        
%         figure;
%         demod = array(lower:1:(upper + samplesPerSymbol)).*[local_oscillator local_oscillator];
%         plot(demod, 'o');
%         title('demod');
%         set(gcf, 'units','normalized','outerposition',[0 0 .5 .5]);
%         
%         figure;
%         plot(energy, 'o');
%         title('Integral');
%         
        energy = energy.^2;  
%           
%         figure;
%         plot(energy, 'o');
%         title('Energy');
%         set(gcf, 'units','normalized','outerposition',[0 .5 .5 .5]);
%         
%         figure;
%         plot(array(lower:1:(upper + samplesPerSymbol)), 'o');
%         title('Array Subset');
%         set(gcf, 'units','normalized','outerposition',[.5 .5 .5 .5]);
%         
         energyAverage=energyAverage+energy;
%         
%         figure;
%         plot(energyAverage, 'o');
%         title('energyAverage');
%         set(gcf, 'units','normalized','outerposition',[.5 0 .5 .5]);
%         pause;    
%         close all;
        
        if (i>=numAvgOver && (mod(i,numAvgOver) == 0))
            error = find(energyAverage==max(energyAverage(:)),1) -1;
            shift=mod(totalShiftArray(end)+error,floor(samplesPerSymbol/2));
            if (shift > floor(samplesPerSymbol/2))
                shift = -shift;
            end 
            energyAverage = zeros(1,samplesPerSymbol);
            totalShiftArray = [totalShiftArray shift]; 
        end
        
   else
       totalShiftArray = 0; 
   end
end

% figure; 
% plot(totalShiftArray,'o');
% title('totalShiftArray');
%pause;
close all;
end

