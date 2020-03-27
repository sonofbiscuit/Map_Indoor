function [dispo1,dispo2] = dispose(finger,offline_rss,offline_loca,time)
disp1=0;
disp2=0;
roomL=20;
roomW=20;

for j=1:time
%生成移动轨迹
tim=100;%数据量
[trace,rss]=get_online_data(finger,0.01,roomL,roomW,tim); % 获取跟踪和相应的RSS
%KNN分类
predict_1=online_location(offline_rss,offline_loca,rss);
disp1=disp1+acc_fina(predict_1,trace);
trace1=predict_1/100;

%卡尔曼滤波过滤位置
kf_filter_record=zeros(size(trace,1),4);
for i=1:tim
    if i==1
        kf_filter=kf_init(predict_1(i, 1), predict_1(i, 2), 0, 0); % 初始化
    else
        kf_filter.z=predict_1(i,1:2)'; %
        kf_filter=kf_update(kf_filter); % kf
    end
    kf_filter_record(i, :) = kf_filter.x';
    %disp(kf_filter_record);
end
kf_trace = kf_filter_record(:, 1:2);
trace2 = kf_trace/100;
disp2 = disp2 + acc_fina(kf_trace, trace);
end
dispo1 = disp1/time;
dispo2 = disp2/time;

%绘制
figure(1);
plot(trace(:,1)/100,trace(:,2)/100,'r-o',trace1(:,1),trace1(:,2),'b-*');
xlabel('x/m');
ylabel('y/m');
axis([0 20 0 20])
legend('trace without kf')

figure(2);
plot(trace(:,1)/100,trace(:,2)/100,'r-o',trace2(:,1),trace2(:,2),'m-*');
xlabel('x/m');
ylabel('y/m');
axis([0 20 0 20])
legend('trace with kf')

%disp(trace);
end