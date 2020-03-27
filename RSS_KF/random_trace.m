function trace=random_trace(roomLength, roomWidth, t) %t 100
    path_length=zeros(t,1) + normrnd(0.3, 0.05);%服从正态分布的随机数，均值为MU,标准差为SIGMA，产生高斯随机矩阵
    path_angle =rand(t,1) * 2 * pi;%100x1,0~2pi
    sigma_angle=10;   %角度
    trace=zeros(t,2); %100x2
    %disp(trace);
    trace(1,:)=[randi(roomLength-1),randi(roomWidth-1)];%randi生成伪随机整数,trace矩阵的第一行替换
    %disp(trace(1,:));
    
    for i=2:t%(2,1)~(100,1)   (2,2)~(100,2)
        trace(i,1)=trace(i-1,1)+path_length(i-1).*cos(path_angle(i-1));%trace第一列替换
        trace(i,2)=trace(i-1,2)+path_length(i-1).*sin(path_angle(i-1));%trace第二列替换
        %逐个替换
        while(trace(i,1)<1||trace(i,1)>roomLength-1||trace(i,2)<1||(trace(i,2)>roomWidth-1))%防出界
            path_angle(i-1)=rand()*2*pi;
            trace(i,1)=trace(i-1,1)+path_length(i-1).*cos(path_angle(i-1));
            trace(i,2)=trace(i-1,2)+path_length(i-1).*sin(path_angle(i-1));
        end
        path_angle(i)=path_angle(i-1)+normrnd(0,sigma_angle*pi/180);
    end
    %disp(trace);
    
end