
array = [];
for i = 0:.1:2*pi 
    array = [array cos(i)]
end

for i = 0:.1:2*pi 
    array = [array -cos(i)]
end

figure;
plot(array,'o');
title('BPSK symbols');

local_oscillator = [];
for i = 0:.1:2*pi 
     local_oscillator = [local_oscillator cos(i)];
end

figure;
plot(local_oscillator,'o');
title('local_oscillator ');

energy = [];    
temp_e = 0;
for i = 0:1:(size(array,2) - size(local_oscillator,2)) 
   for j = 1:size(0:.1:2*pi,2)
       temp_e = (temp_e + local_oscillator(j)*array(i+j));
   end
   energy = [energy temp_e];
   temp_e = 0;
end

energy = energy.^2;

figure; 
plot(energy,'o');
title('Energy');

pause;
close all;