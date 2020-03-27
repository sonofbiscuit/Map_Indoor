%1、构建20x20x3空间内的指纹库
%2、RSS指纹库提取离线数据集
%3、以2内提取的数据集作为KNN的训练数据
%4、随机产生轨迹
%5、获取轨迹点的RSS
%6、作为KNN的数据产生模拟的轨迹点
%7、使用卡尔曼滤波对运动轨迹进行校正，绘图比较前后轨迹变化情况
function RSS_KF(roomL,roomW)
%default

time=100;
if nargin==0
    roomL=20;
    roomW=20;
end

if ~exist('data_1.mat','file')%不存在则构建
    disp('loading');
    normal_data(0.01);
end

load data_1.mat;%作为指纹库数据finger
%获取offline数据
[offline_rss,offline_loca]=get_offline_data(finger);
save('offline_data','offline_rss','offline_loca');

[disp1,disp2]=dispose(finger,offline_rss,offline_loca,time);
fprintf('AVG_knn:%f\n',disp1/100);
fprintf('AVG_knn_kf:%f\n',disp2/100);
end

    