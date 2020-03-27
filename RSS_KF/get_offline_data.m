function [data, labels] = get_offline_data(finger, d_size)
%模拟均匀数据采集，生成位置指纹库
    if nargin == 1
        d_size = 10;  %default 10(x1000)
    end
    [size_x, size_y, size_ap] = size(finger);%获取finger大小,(1999, 1999, 6)的数组
    
    figure(3)
    [x,y,z]=meshgrid(d_size:d_size:size_x,d_size:d_size:size_y, 0:1:6);
    z1=squeeze(finger(:,:,1));
    mesh(z1);
    hold on;
    v = x.^2+y.^2;
    xslice=1999; 
    yslice=1999;
    zslice=6;
    slice(x,y,z,v,xslice,yslice,zslice);
    view(30,30)
    
    fp = finger(d_size:d_size:size_x, d_size:d_size:size_y, :);%步长设置10........(10:10:1999,10,10,1999,:),finger全层赋值
    
    data = reshape(fp, [], size_ap);%fp转移到新数组data,规定z的大小为size_ap=6    size*6的矩阵
    [x, y] = meshgrid(d_size:d_size:size_x, d_size:d_size:size_y);%x,y网格化，
    
    x = x';%复共轭转置
    y = y';
    labels = [x(:), y(:)];%把x矩阵按列拆分后纵向排列成一个大的列向量，lables为x,y 的x*2  y*2的巨大数组
 
    figure(4)
    a=labels(:,1);
    b=labels(:,2);
    plot(a,b,'*');
    
    
end