function out=imrotate_pot(im,pot,angle)
%��ֵͼ��������������ת
[row,col]=size(im);
[y,x]=find(im==1);  %������
BW=[x'-pot(1);y'-pot(2)];        %��potΪԭ��ĵ�����
BW_rotated=rotate2D(BW,angle);  %����������ԭ����ת
pot_restore=[BW_rotated(1,:)+pot(1);BW_rotated(2,:)+pot(2)];   %�ָ�������ƫ��
im_new=zeros(size(im));%�����µĶ�ֵ��ͼ��
pot_restore=ceil(pot_restore);%����ȡ��
x_=pot_restore(1,:);y_=pot_restore(2,:);
ind=find(x_<1);
x_(ind)=[];
y_(ind)=[];
ind=find(y_<1);
x_(ind)=[];
y_(ind)=[];
ind=find(x_>col);
x_(ind)=[];
y_(ind)=[];
ind=find(y_>row);
x_(ind)=[];
y_(ind)=[];

% for i=1:length(x_)
% im_new(y_(i),x_(i))=1;
% end
% im_new=imdilate(im_new,ones(2));
% out=logical(im_new);
out=[x_;y_];
end