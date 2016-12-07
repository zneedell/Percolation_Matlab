function [ outmat ] = AddCorrelations( randmat, alpha )
%Takes in a random uncorrelated matrix (values between 0 and 1), and
%returns the same matrix with negative exponential smoothing, with a
%correlation distance of 1/alpha

%sizein = size(randmat);
sizein = [100,100]; % ignore very weak long range correlations to speed up the code
[XX,YY] = meshgrid(1:sizein(1),1:sizein(2));
XX = XX - sizein(1)/2+0.5; % Shift slightly to avoid infinity in center
YY = YY - sizein(2)/2+0.5;
R = sqrt(XX.^2 + YY.^2);
kernel = R.^(-alpha);
kernel = kernel/sum(kernel(:));
outmat = imfilter(randmat,kernel,'circular');
outmat = outmat - min(outmat(:));
outmat = outmat/max(outmat(:));
end

