function out=rotate2D(pot,angle)
%��Ϊx;y����Ϊ����,������
%��ԭ��

M=[cos(angle)   sin(angle);
   -sin(angle)   cos(angle)];
out=M*pot;
end