function out=calib_stick(BW,ex)
%�����궨
%���Ŷ�ֵͼ����ֱ�߼�⣬���ֱ��������������ط�ȫ��ɾ����Ȼ�����
%ת���ɻ��ȣ���ƽ��
global imNums ROI_row
row=size(BW,1)/imNums;
first_im=BW(1:row,:);
if row<ROI_row  %���ͼƬ��С������䣬�������任�����
    first_im=Filled(first_im);
end

first_im=imdilate(first_im,ones(2));
first_im=first_im';
[H,T,R] = hough(first_im, 'Theta', -15:0.5:15);
Peaks=houghpeaks(H,1);
lines=houghlines(first_im,T,R,Peaks);
xy=[lines(1).point1;lines(1).point2];  
%xy=[����� ����� �ҵ��� �ҵ���]

roi=zeros(size(first_im'));
ind=[min(xy(:,1)),max(xy(:,1))];  %��һ��Ϊԭʼͼ���row
roi(ind(1)-ex:ind(2)+ex,:)=1;roi=logical(roi);

angle=zeros(1,imNums);
b=zeros(1,imNums);
for i=1:imNums
    %��ÿ��ͼ�������Σ�Ȼ�����ֱ�ߣ������ƽ��
    im=BW(row*(i-1)+1:row*i,:);
    if row<ROI_row  %���ͼƬ��С������䣬�������任�����
        im=Filled(im);
    end
    im_roi=logical(im).*roi;
    [x,y]=find(im_roi==1);
    line=polyfit(y,x,1);
    angle(i)=atan(line(1));
    b(i)=line(2);
end
out=[mean(angle) mean(b)];

end