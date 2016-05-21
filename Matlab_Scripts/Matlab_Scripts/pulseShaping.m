function pulsedArray = pulseShaping(array,coefficients)
%b = rcosdesign(beta,numPoints,samplesPerSymbol);
b = [
-0.037513	
-0.000532	
0.055452	
0.126288	
0.204577	
0.280729	
0.344536	
0.386975	
0.401856	
0.386975	
0.344536	
0.280729	
0.204577	
0.126288	
0.055452	
-0.000532	
-0.037513	
];
%x = upfirdn(array,b,samplesPerSymbol);
x = conv(array,b);
pulsedArray = x;
