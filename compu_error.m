function rePara2=compu_error(rePara1,dePara,stick)
%rePara1=[��뾶 �Ұ뾶 ��Բ��x ��Բ��y ����x ����y ��Բ��x ��Բ��y]
%rePara2=[��뾶 �Ұ뾶 ��ˮƽƫ ��ˮƽƫ ��ֱƫ �Ҵ�ֱƫ ��Ӵ��� �ҽӴ���]
%dePara=[��뾶 �Ұ뾶 ��ƫ�� ��ƫ�� ��ֱ�� ��Բֱ�� ����ֱ��]
%����Բ������������ת��������Ʋ�������ƫ��
pot=[rePara1(3) rePara1(7);rePara1(4) rePara1(8)];%le_x,ri_x;le_y,ri_y
pot(1,:)=pot(1,:)-rePara1(5);
pot(2,:)=pot(2,:)-rePara1(6);
pot=rotate2D(pot,stick(1));
pot=pot/200;
%��߶����ƫ�ķ���Ϊ������ά�����᷽�򣬷�ͼ��������
le_delta_y=-dePara(3)-pot(2,1);%��Բ�Ĵ�ֱƫ��
le_delta_x=pot(1,1)-dePara(3);%��Բ��ˮƽƫ��
ri_delta_y=-dePara(4)-pot(2,2);%��Բ�Ĵ�ֱƫ��
ri_delta_x=pot(1,2)+dePara(4);%��Բ��ˮƽƫ��
le_angle=90+rad2deg(atan(pot(2,1)/pot(1,1)));
ri_angle=90-rad2deg(atan(pot(2,2)/pot(1,2)));

rePara2=[rePara1(1)/200 rePara1(2)/200 le_delta_x ri_delta_x le_delta_y ri_delta_y le_angle ri_angle];
end

