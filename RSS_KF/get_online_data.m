function [trace,rss]=get_online_data(finger,d_size,roomL,roomW,tim)
%��ȡģ��λ��ָ�Ƶ�����,���λ�õ�켣���Լ��켣��ÿ�����rss
    trace=random_trace(roomL,roomW,tim);
    rss=zeros(size(trace,1), size(finger,3));
    
    for i=1:size(trace,1);
        x = round(trace(i,1)/d_size);
        y = round(trace(i,2)/d_size);
        if x<1
            x=1;
        elseif x>size(finger,1)
            x = size(finger,1);
        end
        if y<1
            x=1;
        elseif y>size(finger,2)
            y=size(finger,2);
        end
        rss(i,:)=finger(x,y,:);
        trace(i,:)=[x,y];
    end
end