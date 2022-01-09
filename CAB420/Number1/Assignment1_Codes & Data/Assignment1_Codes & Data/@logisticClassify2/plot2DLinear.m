function plot2DLinear(obj, X, Y)
% plot2DLinear(obj, X,Y)
%   plot a linear classifier (data and decision boundary) when features X are 2-dim
%   wts are 1x3,  wts(1)+wts(2)*X(1)+wts(3)*X(2)
%
  [n,d] = size(X);
  if (d~=2) error('Sorry -- plot2DLogistic only works on 2D data...'); end;
  hold on
  plotClassify2D([],X,Y);

  m = length(X);
  axi = axis();
  lineVector = linspace(axi(1),axi(2),m);
  weight = [obj.wts];
  plot(lineVector,-weight(1)/weight(3) - weight(2)/weight(3) * lineVector,'k-'); % decision boundary 
  axis(axi); 
  hold off;
end