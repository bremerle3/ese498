% Script to plot Pr(E) vs SNR

noiseSNRValue=-4:30;
pr_E_array=[];
n=1;
for noiseSNR=noiseSNRValue
    noiseSNR
    pr_E=0;
    numTrials=100;
    for i=1:numTrials
        testbench_noise
        pr_E=pr_E+bitErrorRate;
    end
    pr_E_array=[pr_E_array pr_E/numTrials];
    n=n+1;
end
semilogy(noiseSNRValue,pr_E_array,'bo-');
%plot(noiseSNRValue,log(pr_E_array),'bo-');
title('Probability of Error, Pr(E) vs. Signal to Noise Ratio(dB)')
ylabel('Probability of Error, Pr(E)')
xlabel('Signal to Noise Ratio(dB)')
% pause