function [xc,yc,R]=CircleFit(x,y)
%x���У�y���У�ͼ���е�xy����ϵ
t=0:0.01:pi;  
%plot(x,y,'.'); hold on; 
x=x(:);  
y=y(:);  
m=[x y ones(size(x))]\[-(x.^2+y.^2)]; 
xc = -.5*m(1);%���Բ��X����ֵ 
yc = -.5*m(2);%���Բ��Y����ֵ  
R  =  sqrt((m(1)^2+m(2)^2)/4-m(3));%��ϰ뾶��ֵ 
%plot(xc,yc,'r-x',(xc+R*cos(t)),(yc+R*sin(t)),'r.'); 



return





t=0:0.01:pi;  
a=20;%�趨Բ��X����ֵ 
b=30;%�趨Բ��Y����ֵ 
r=5;%�趨Բ�뾶��ֵ 
x=a+r*cos(t)+randn(1,315); 
y=b+r*sin(t)+randn(1,315); 
plot(x,y,'.'); hold on; 
x=x(:);  
y=y(:);  
m=[x y ones(size(x))]\[-(x.^2+y.^2)]; 
xc = -.5*m(1)%���Բ��X����ֵ 
yc = -.5*m(2)%���Բ��Y����ֵ  
R  =  sqrt((m(1)^2+m(2)^2)/4-m(3))%��ϰ뾶��ֵ 
plot(xc,yc,'r-x',(xc+R*cos(t)),(yc+R*sin(t)),'r.'); 
axis equal;