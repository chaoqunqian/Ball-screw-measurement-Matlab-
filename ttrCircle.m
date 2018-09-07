function [xc3,yc3] = ttrCircle(xc1,yc1,r1,xc2,yc2,r2,r3)
%��������ԲԲ�ġ��뾶,����������뾶,xc1,yc1,r1,xc2,yc2,r2,r3

r1=r1-r3;
r2=r2-r3;
% syms x y
% [x,y]=solve((x-xc1)^2+(y-yc1)^2==r1^2,(x-xc2)^2+(y-yc2)^2==r2^2);
% if real(double(y(1)))>real(double(y(2)))%ѡ����Ǹ�
%     ind=1;
% else
%     ind=2;
% end
% xc3=real(double(x(ind)));
% yc3=real(double(y(ind)));
%%%%%%%%%%%%%%%%��Ϊԭ,����

% % ��Ϊ�£��ֲ�����ϵԭ����ȫ������ϵ��λ�úͽǶ�
theta = atan((yc1 - yc2) / (xc1 - xc2));
local_base = [xc2, yc2, theta];
d = norm([xc1, yc1] - [xc2, yc2]);
a = (r2^2 - r1^2 + d^2) / (2*d);
h = sqrt(r2^2 - a^2);

position_local_1 = [a, h];
position_local_2 = [a, -h];
position_global_1 = cvt_local_to_global(position_local_1, local_base);
position_global_2 = cvt_local_to_global(position_local_2, local_base);
if position_global_1(2)>position_global_2(2)
    xc3=position_global_1(1);
    yc3=position_global_1(2);
else
    xc3=position_global_2(1);
    yc3=position_global_2(2);
end
end

function position_global = cvt_local_to_global(position_local, local_base)
% �Ӿֲ�����ϵת����ȫ������ϵ
% ����: position_local �ֲ�����ϵ��λ��[x_local, y_local]
% ����: local_base �ֲ�����ϵԭ�㼰�Ƕ�[base_local, y_local, theta]
% ���: position_global ȫ������ϵ��λ��[x_global, y_global]

x_local = position_local(1);
y_local = position_local(2);

x_base = local_base(1);
y_base = local_base(2);
theta = local_base(3);

x_global = x_base + x_local * cos(theta) - y_local * sin(theta);
y_global = y_base + x_local * sin(theta) + y_local * cos(theta);

position_global = [x_global, y_global];


end

