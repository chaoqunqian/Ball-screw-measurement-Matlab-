% % % %%
% % % %�����������롣���ر�˵����������λΪmm
% % % barDiaInput=dePara(5);%����ֱ��������ֵ��
% % % xScale=0.005;%��λ���ض�Ӧ�������ȣ�x����
% % % yScale=xScale;%��λ���ض�Ӧ�������ȣ�x����
% % % randProp=0.05;%���ݵ�ǰ����ȥ�������
% % % radCirStd=(barDiaInput/2)*(1/xScale);%���������뾶���ض�Ӧ����
% % % step_r=1;%����뾶����
% % % step_angle=0.1;%����ǶȲ���
% % % minr=dePara(5)*100;%����뾶��Сֵ
% % % maxr=dePara(1)*200+10;%����뾶���ֵ
% % % cir_num_thresh=1;%����ȡԲ�������ʣ�ԽСȡԽ��
% % % error_thresh=1;%����ȡԲ��ʵ�����ݵ���������ݵ�������ֵ���������ֶ�ֵ�������Ƿ�ΪԲ��һ���֣���λΪ����

%% ˫Բ������ѡ���������ĵ����
[le_r_measure,ri_r_measure, le_x,le_y,ball_x,ball_y,ri_x,ri_y] = imgDoubArcHough_par( imNums,radCirStd, randProp ,step_r,step_angle,minr,maxr,cir_num_thresh,error_thresh,handles);

%���ƽ��ֵ
ball_x=mean(ball_x);ball_y=mean(ball_y);
le_r_measure=mean(le_r_measure);ri_r_measure=mean(ri_r_measure);
le_x_measure=mean(le_x);le_y_measure=mean(le_y);
ri_x_measure=mean(ri_x);ri_y_measure=mean(ri_y);
%% ����������
%rePara1=[��뾶 �Ұ뾶 ��Բ��x ��Բ��y ����x ����y ��Բ��x ��Բ��y]
rePara1=[le_r_measure,ri_r_measure, le_x_measure,le_y_measure,ball_x,ball_y,ri_x_measure,ri_y_measure];
