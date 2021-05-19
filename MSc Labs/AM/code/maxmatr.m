function [maxZ,A]=maxmatr(Z,stepx,stepy);
%...............................................
% [maxZ,A]=maxmatr(Z,stepx,stepy);
% finds the maximum of a matrix and its location
% written by Dr A. Manikas (IC), 3-April-94
%...............................................

[maxZ,x]=max(max(Z));
[maxZ,y]=max(max(Z'));

[y,x]=find(Z==maxZ);
A=[y,x];