function [data, labels] = get_offline_data(finger, d_size)
%ģ��������ݲɼ�������λ��ָ�ƿ�
    if nargin == 1
        d_size = 10;  %default 10(x1000)
    end
    [size_x, size_y, size_ap] = size(finger);%��ȡfinger��С,(1999, 1999, 6)������
    
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
    
    fp = finger(d_size:d_size:size_x, d_size:d_size:size_y, :);%��������10........(10:10:1999,10,10,1999,:),fingerȫ�㸳ֵ
    
    data = reshape(fp, [], size_ap);%fpת�Ƶ�������data,�涨z�Ĵ�СΪsize_ap=6    size*6�ľ���
    [x, y] = meshgrid(d_size:d_size:size_x, d_size:d_size:size_y);%x,y���񻯣�
    
    x = x';%������ת��
    y = y';
    labels = [x(:), y(:)];%��x�����в�ֺ��������г�һ�������������lablesΪx,y ��x*2  y*2�ľ޴�����
 
    figure(4)
    a=labels(:,1);
    b=labels(:,2);
    plot(a,b,'*');
    
    
end