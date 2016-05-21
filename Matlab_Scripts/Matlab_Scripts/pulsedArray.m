function pulsedArray = pulseShaping(array,numSamplesPerSymbol,numSymbols,beta)
b = rcosdesign(beta,numSymbols,numSamplesPerSymbol);
x = upfirdn(array,b,numSamplesPerSymbol);
pulsedArray = x;
