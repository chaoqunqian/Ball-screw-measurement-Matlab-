function [ r1,r2,fitCirCord_x,fitCirCord_y] = imgDoubArcHough( path,radCirStd, randProp,step_r,step_angle,minr,maxr,cir_num_thresh,error_thresh )

%path,radCirStd, randProp,step_r,step_angle,minr,maxr,thresh 
%%
%��ȡָ���ļ�����ͼƬ��Ϣ
randProp=randProp/2;
file_path =  path;% ͼ���ļ���·��
img_path_list = dir(strcat(file_path,'*.bmp'));%��ȡ���ļ���������bmp��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������
%%
%����ѡȡ��ܻ�׼
img=imread([file_path,img_path_list(1).name]);
[rectWhole] = imgRectDrag(rgb2gray(img));
tic
rectWhole=round(rectWhole);
img=img(min(rectWhole(2),rectWhole(4)):max(rectWhole(2),rectWhole(4)),min(rectWhole(1),rectWhole(3)):max(rectWhole(1),rectWhole(3)));
img = imadjust(img,[double(min(min(img)))/255 double(max(max(img)))/255],[0 1]);
BW=edge(img,'canny',graythresh(img));
[num,circleParaXYR]=hough_circle(BW,step_r,step_angle,minr,maxr,cir_num_thresh);
assert(num==1,'�ּ����󣬲�ֹһ��Բ�������»���')
assert(circleParaXYR(1)>1,'�ϱ����Ŀ�̫С��')

BW_left=BW;BW_left(:,circleParaXYR(2):end)=0;
[num,circleParaXYR_left]=hough_circle(BW_left,step_r,step_angle,minr,maxr,cir_num_thresh);
assert(num==1,'��Բ�������󣬲�ֹһ��Բ')
roi1_=autoRect(BW_left,circleParaXYR_left,error_thresh);

BW_right=BW;BW_right(:,1:circleParaXYR(2))=0;
[num,circleParaXYR_right]=hough_circle(BW_right,step_r,step_angle,minr,maxr,cir_num_thresh);
assert(num==1,'��Բ�������󣬲�ֹһ��Բ')
roi2_=autoRect(BW_right,circleParaXYR_right,error_thresh);



% % img = imadjust(img,[double(min(min(img)))/255 double(max(max(img)))/255],[0 1]);
% % img_edge=edge(img,'canny',graythresh(img));
% % [rect] = imgRectDrag(img_edge);
% % roi1_(1,:)=[min(rect(2),rect(4)) max(rect(2),rect(4)) min(rect(1),rect(3)) max(rect(1),rect(3))];
% % [rect] = imgRectDrag(img_edge);
% % roi2_(1,:)=[min(rect(2),rect(4)) max(rect(2),rect(4)) min(rect(1),rect(3)) max(rect(1),rect(3))];
% % roi1_=round(roi1_);roi2_=round(roi2_);
%%
%��������ÿ��ͼƬ����
for i=1:5
    img=imread([file_path,img_path_list(i).name]);
    img=img(min(rectWhole(2),rectWhole(4)):max(rectWhole(2),rectWhole(4)),min(rectWhole(1),rectWhole(3)):max(rectWhole(1),rectWhole(3)));
    img = imadjust(img,[double(min(min(img)))/255 double(max(max(img)))/255],[0 1]);
    img_edge=edge(img,'canny',graythresh(img));
    %%
    %ȡ�˸������
    Leftrand1stNum=round(rand*abs(roi1_(2)-roi1_(4))*randProp);%��������
    Leftrand2ndNum=round(rand*abs(roi1_(1)-roi1_(3))*randProp);%��������
    Leftrand3rdNum=round(rand*abs(roi1_(2)-roi1_(4))*randProp);%��������
    Leftrand4thNum=round(rand*abs(roi1_(1)-roi1_(3))*randProp);%��������
    lenProp=abs(roi2_(2)-roi2_(4))/abs(roi1_(2)-roi1_(4));
    Rightrand1stNum=round(rand*abs(roi2_(2)-roi2_(4))*randProp*0.5);%�ҿ������
    Rightrand2ndNum=round(rand*abs(roi2_(1)-roi2_(3))*randProp*0.5);%�ҿ������
    Rightrand3rdNum=round(rand*abs(roi2_(2)-roi2_(4))*randProp*0.5);%�ҿ������
    Rightrand4thNum=round(rand*abs(roi2_(1)-roi2_(3))*randProp*0.5);%�ҿ������
    %%
    %�������������Χ
    roi1=zeros(size(img));roi2=roi1;
    roi1(roi1_(1)+Leftrand1stNum:roi1_(2)-Leftrand2ndNum,roi1_(3)+Leftrand3rdNum:roi1_(4)-Leftrand4thNum)=1;
    roi2(roi2_(1)+Rightrand1stNum:roi2_(2)-Rightrand2ndNum,roi2_(3)+Rightrand3rdNum:roi2_(4)-Rightrand4thNum)=1;
    i3_roi1=img_edge.*logical(roi1);
    i3_roi2=img_edge.*logical(roi2);
    [y1,x1]=find(i3_roi1==1);
    [y2,x2]=find(i3_roi2==1);
    [x_cir1,y_cir1]=remove_noise(circleParaXYR_left,x1,y1,error_thresh);%���û���任������ȥ�������������
    [xc1(i),yc1(i),r1(i)]=CircleFit(x_cir1,y_cir1);
%     [xc1(i),yc1(i),r1(i)]=CircleFit(x1,y1);
% % % %     
    [x_cir2,y_cir2]=remove_noise(circleParaXYR_right,x2,y2,error_thresh);
    [xc2(i),yc2(i),r2(i)]=CircleFit(x_cir2,y_cir2);
%      [xc2(i),yc2(i),r2(i)]=CircleFit(x2,y2);
    [xc3(i),yc3(i)] = ttrCircle(xc1(i),yc1(i),r1(i),xc2(i),yc2(i),r2(i),radCirStd);
% %     imshow(img_edge);%test
% %     [xc3(i),yc3(i)]=ginput(1);r1=10;r2=10;%test
%test_plot
% % hFigure = figure('Visible', 'on', 'Position', [0 0 600 500]);
% % movegui(hFigure, 'center');
% % hAxes = axes('Visible', 'off', 'Position', [0.01 0.2 0.98 0.79], 'Drawmode', 'fast');
% % imshow(img_edge); 
% % axis on
% % t = -pi:0.1:pi;x = xc1(i) + r1(i)*sin(t);y = yc1(i) + r1(i)*cos(t);
% % hold on;plot(x,y,'-');plot(xc1(i),yc1(i),'r*');
% % t = -pi:0.1:pi;x = xc2(i) + r2(i)*sin(t);y = yc2(i) + r2(i)*cos(t);
% % plot(x,y,'-');plot(xc2(i),yc2(i),'r*');
% % t = -pi:0.1:pi;x = xc3(i) + radCirStd*sin(t);y = yc3(i) + radCirStd*cos(t);
% % plot(x,y,'-m');plot(xc3(i),yc3(i),'m*');
    fitCirCord_x(i)=xc3(i)+min(rectWhole(1),rectWhole(3))-1;
    fitCirCord_y(i)=yc3(i)+min(rectWhole(2),rectWhole(4))-1;
end
end

function [roi_]=autoRect(BW,YXR,thresh)
%���û���任�õ���Բ�İ뾶���ݣ��Զ�ѡ����Χ
[y,x]=find(BW==1);
[x_cir,y_cir]=remove_noise(YXR,x,y,thresh);
len=length(y_cir);

y_cir=y_cir(round(len/30-thresh):end-round(len/30-thresh));
x_cir=x_cir(round(len/30-thresh):end-round(len/30-thresh));

roi_(1)=min(y_cir);
roi_(2)=max(y_cir);
roi_(3)=min(x_cir);
roi_(4)=max(x_cir);


end

function [x_cir,y_cir]=remove_noise(YXR,x,y,thresh)
Y=y-YXR(1);X=x-YXR(2);
d=abs(sqrt(Y.^2+X.^2)-YXR(3));
ind=find(d<thresh);

y_cir=y(ind);
x_cir=x(ind);
end