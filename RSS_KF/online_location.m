function predictions = online_location(offline_rss, offline_location, online_rss)
%模拟在线定位
%Offline_location offline_rss离线指纹库，Online_rss在线指纹库 
    predictions = zeros(size(online_rss, 1), size(offline_location, 2));
    % KNN分类
    k = 60;%60个临近样本
    predictions = loknn(offline_rss, offline_location, online_rss, k);
end