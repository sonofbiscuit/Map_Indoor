%����RSSģ�⻷�����ݼ�
function finger=normal_data(d_size)
%function��ȡfinegr����
if nargin==0
   d_size=0.01;
end

%set room
room_X=20;
room_Y=20;
room_Z=3;
sig_frequence=2500;%�ź�Ƶ��
APS=[
    1,1
    10,1
    19,1
    1,19
    10,19
    19,19
    ];
finger=zeros(room_X/d_size-1,room_Y/d_size-1,size(APS,1));%����room_X/d_size-1 * room_Y/d_size-1 * aps������ȫ�����
for i=1:size(APS,1)%6
    trace_X=APS(i,1);
    trace_Y=APS(i,2);%�ź�Դ����
    trace_Z=1;%default 1
    rss=rss_trace(room_X,room_Y,room_Z,trace_X,trace_Y,trace_Z,d_size,sig_frequence);%����RSS
    finger(:, :, i) = rss;%ָ�ƿⰴ�㸳ֵ
end
    save('data_1', 'finger');
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    