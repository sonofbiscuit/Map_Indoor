function predictions = online_location(offline_rss, offline_location, online_rss)
%ģ�����߶�λ
%Offline_location offline_rss����ָ�ƿ⣬Online_rss����ָ�ƿ� 
    predictions = zeros(size(online_rss, 1), size(offline_location, 2));
    % KNN����
    k = 60;%60���ٽ�����
    predictions = loknn(offline_rss, offline_location, online_rss, k);
end