function plot2D3D(Z,AZarea,ELarea,Zcapture,plottitle);
%...............................................
% written by Dr A. Manikas (IC) 6-April-1994
% plot2D3D(Z,AZarea,ELarea,Zcapture,plottitle);
% plots the (Azimuth,Elevation,Z)-spectrum 
% It can be used to plot MuSIC spectrum (music.m)
% or, array pattern (pattern.m) etc 
%...............................................

if nargin<4, plottitle=' '; Zcapture=' ';end;
figure(1);
if length(ELarea)==1 | length(AZarea)==1 
 if length(ELarea)==1 
    [maxZ,x]=max(Z); Bestdirection=AZarea(x)
    plot(AZarea,Z),title(plottitle),
               xlabel('Azimuth Angle - degrees'),
               ylabel(Zcapture),grid
               
 else
   
  [maxZ,x]=max(Z); Bestdirection=ELarea(x)
   plot(ELarea,Z),
               xlabel('Elevation Angle - degrees'),
               ylabel(Zcapture),grid
 end;            
else 
    [maxZ,x]=maxmatr(Z);
    BestDirection=[ELarea(x(:,1)),AZarea(x(:,2))]
    cost=maxZ    
    subplot(211), mesh(AZarea,ELarea,Z),
         title(plottitle);
         xlabel('Azimuth Angle - degrees'),
         ylabel('Elevation Angle - degrees'),
         zlabel(Zcapture); view([0,0]);grid
     
    subplot(212), mesh(AZarea,ELarea,Z),
         xlabel('Azimuth Angle - degrees'),
         ylabel('Elevation Angle - degrees'),
         zlabel(Zcapture); view([90,0]); grid
    
    subplot

    figure(2),surf(AZarea,ELarea,Z),
         title(plottitle);
         xlabel('Azimuth Angle - degrees'),
         ylabel('Elevation Angle - degrees'),
         zlabel(Zcapture);grid; 
    figure(3),  contour(AZarea,ELarea,Z),
         title(plottitle);
         xlabel('Azimuth Angle - degrees'),
         ylabel('Elevation Angle - degrees'),grid;
end;
