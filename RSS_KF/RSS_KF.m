%1������20x20x3�ռ��ڵ�ָ�ƿ�
%2��RSSָ�ƿ���ȡ�������ݼ�
%3����2����ȡ�����ݼ���ΪKNN��ѵ������
%4����������켣
%5����ȡ�켣���RSS
%6����ΪKNN�����ݲ���ģ��Ĺ켣��
%7��ʹ�ÿ������˲����˶��켣����У������ͼ�Ƚ�ǰ��켣�仯���
function RSS_KF(roomL,roomW)
%default

time=100;
if nargin==0
    roomL=20;
    roomW=20;
end

if ~exist('data_1.mat','file')%�������򹹽�
    disp('loading');
    normal_data(0.01);
end

load data_1.mat;%��Ϊָ�ƿ�����finger
%��ȡoffline����
[offline_rss,offline_loca]=get_offline_data(finger);
save('offline_data','offline_rss','offline_loca');

[disp1,disp2]=dispose(finger,offline_rss,offline_loca,time);
fprintf('AVG_knn:%f\n',disp1/100);
fprintf('AVG_knn_kf:%f\n',disp2/100);
end

    