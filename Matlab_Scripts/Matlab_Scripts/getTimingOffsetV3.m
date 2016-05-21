function [ shift_array ] = getTimingOffsetV3( samplesPerSymbol, numSymbols, array)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


% samplesPerSymbol = 128;  
% numSymbols = 8;
 periodInput = linspace(0,2*pi,samplesPerSymbol);
% randArray = [];
% for i = 1:numSymbols
%     if (rand()>.5)
%         temp = 1;
%     else
%         temp = -1;
%     end
%     randArray = [randArray temp];
% end
% array = [];
% for i = 1:numSymbols
%     for j = periodInput
%         array = [array cos(j)*randArray(i)];
%     end
% end
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


%array = [zeros(1,32) array(1:end-4)];
%array = [array(58:end) array(1:57)];


shift_array = [];

shift = 0;
for i = 1:numSymbols-1
   if (i > 1)
        energy = [];
        temp_e = 0;
        if (shift + ((i-1)*samplesPerSymbol+1) > size(array,2))
            upper = size(array,2);
        else
            upper = shift + ((i-1)*samplesPerSymbol+1);
        end
%        figure;
%         plot(array(shift+(i-2)*samplesPerSymbol+1:2*samplesPerSymbol),'o');
%         x = linspace(0,size(array,2)-1,size(array,2));
%         y1 = array;
%         y1(shift+(i-2)*samplesPerSymbol+1:i*samplesPerSymbol+1+shift) = -2;
%         y2 = array;
%         figure;
%         plot(x,y1,'o',x, y2, 'x')
        for j = (shift + (i-2)*samplesPerSymbol+1):1:upper
            for k = 1:samplesPerSymbol
                temp_e = (temp_e + local_oscillator(k)*array(j+k));
            end
            energy = [energy temp_e];
            temp_e = 0;
        end
        energy = energy.^2;
        %error = shift - (find(energy == max(energy(:)),1) - 1);
        e_max = find(energy==max(energy(:)),1) -1;
        if (e_max > floor(samplesPerSymbol/2))
            error = -mod(samplesPerSymbol,e_max);
        else
            error = e_max;
        end
        %error = (find(energy==max(energy(:)),1) - 1); %- shift;
%         if (abs(error) > floor(samplesPerSymbol/2))
%             error = mod(samplesPerSymbol, abs(error));
%         end
        shift = ((shift + error) + shift)/2;
        shift = round(shift);
        shift_array = [shift_array shift];
   else
       shift = 0;
       error = 0;
       %shift = ((shift + error) + shift)/2;
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
end

