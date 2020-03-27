%射线追踪
function r_all=rss_trace(room_X,room_Y,room_Z,trace_X,trace_Y,trace_Z,d_size,sig_frequence)
%输入
%输出：信号强度
%输入：房间x,y,z，信号源坐标x,y,z,信号传输频率(MHz),格子尺寸(m)
if nargin==0
    room_X=20;
    room_Y=20;
    room_Z=3;
    trace_X=10;
    trace_Y=10;
    trace_Z=1;%default
    sig_frequence=2500;
    d_size=0.01;
end
    room_X=1000*room_X;
    room_Y=1000*room_Y;
    room_Z=1000*room_Z;
    trace_X=1000*trace_X;
    trace_Y=1000*trace_Y;
    trace_Z=1000*trace_Z;
    sig_frequence=1000*sig_frequence;
    d_size=1000 * d_size;
    %大矩阵计算每个点的信号强度
    
    %介电常数和电导率
    epsilon_c=10-1.2j;%虚数单位
    epsilon_w=6.1-1.2j;
    
    T=1/(sig_frequence*10^6);%MHz
    c=3.0e8;
    wavelength=c / (sig_frequence * 10^6);
    %获取空间中所有网格点的位置坐标，固定z和信号源的高度
    %生成网格矩阵
    [X,Y] = meshgrid(d_size:d_size:(room_X-d_size), d_size:d_size:(room_Y-d_size));%1米高度的所有点
    L = [X(:), Y(:)];%列输出，组成X(:)/Y(:) * 2的矩阵
    L = [L, zeros(size(X(:))) + trace_Z];
    
    %直线路径
    %由反射引起的相位变化被添加到电场E的计算中。
    %距离衰减引起的相位变化
    d_direct = sqrt((L(:,1) - trace_X).^2 + (L(:,2)-trace_Y).^2 + (L(:,3) - trace_Z).^2); % 网格点与信号源的欧几里德距离
    t_direct_0 = d_direct./1000./c;  %时延
    p_direct = mod(t_direct_0*2*pi/T,2*pi);% 相位
    E_direct = (wavelength./(4.*pi.*d_direct./1000));% E不完全是场强而是与场强成正比
    E0=E_direct.* exp(1i.*(-p_direct));

    %计算的L是所有网格点的坐标。每个行为是一组坐标。
    %Li对应于与所有网格点对应的镜像点，分别计算六组反射路径。

    %前平面反射路径（前，后，上，下，上，下，上，下意味着：人站在此框中，面向y轴，然后六个平面称为前，后，左，右,上,下）
    Li=[L(:,1) , 2.*room_Y-L(:,2) , L(:,3)]; %计算镜像点
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);%反射路径长度
    t_reflect_1 = d_reflect./1000./c;%时延
    p_reflect = mod(t_reflect_1*2*pi/T,2*pi);%相位
    thet = abs(atan((Li(:,2)-trace_Y)./(Li(:,1)-trace_X)));% 入射角
    reflect_coefficient = (sin(thet)-sqrt(epsilon_w-(cos(thet)).^2))./(sin(thet)+sqrt(epsilon_w-(cos(thet)).^2));%反射系数也为矩阵
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E1=E_reflect .* exp(1i.*(-p_reflect)); % 延迟的相位与反射引起的衰减和相位变化一起被加入。

    % 后方平面反射路径
    Li=[L(:,1) , -L(:,2) , L(:,3)]; % 计算镜像点
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_2 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_2*2*pi/T,2*pi);
    thet = abs(atan((Li(:,2)-trace_Y)./(Li(:,1)-trace_X)));
    reflect_coefficient = (sin(thet)-sqrt(epsilon_w-(cos(thet)).^2))./(sin(thet)+sqrt(epsilon_w-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E2=E_reflect .* exp(1i.*(-p_reflect));

    % 左
    Li=[-L(:,1) , L(:,2) , L(:,3)]; 
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_3 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_3*2*pi/T,2*pi);
    thet = abs(atan((Li(:,1)-trace_X)./(Li(:,2)-trace_Y)));
    reflect_coefficient = (sin(thet)-sqrt(epsilon_w-(cos(thet)).^2))./(sin(thet)+sqrt(epsilon_w-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E3=E_reflect .* exp(1i.*(-p_reflect));

    % 右
    Li=[2*room_X-L(:,1) , L(:,2) , L(:,3)]; 
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_4 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_4*2*pi/T,2*pi);
    thet = abs(atan((Li(:,1)-trace_X)./(Li(:,2)-trace_Y)));
    reflect_coefficient = (sin(thet)-sqrt(epsilon_w-(cos(thet)).^2))./(sin(thet)+sqrt(epsilon_w-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E4=E_reflect .* exp(1i.*(-p_reflect));

    % 上
    Li=[L(:,1) , L(:,2) , 2*room_Z-L(:,3)]; 
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_5 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_5*2*pi/T,2*pi);
    thet = abs(atan((Li(:,3)-trace_Z)./sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2)));
    reflect_coefficient = (-sin(thet).*epsilon_c+sqrt(epsilon_c-(cos(thet)).^2))./(epsilon_c.*sin(thet)+sqrt(epsilon_c-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E5=E_reflect .* exp(1i.*(-p_reflect));
    E5=E5  .*   cos(pi*sin(thet)/2)./(cos(thet)+0.00001)  .*  cos(thet); %由于图案和垂直分解，电场的上下平面需要加上它。
    % 下
    Li=[L(:,1) , L(:,2) , -L(:,3)]; 
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_6 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_6*2*pi/T,2*pi);
    thet = abs(atan((Li(:,3)-trace_Z)./sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2)));
    reflect_coefficient = (-sin(thet).*epsilon_c+sqrt(epsilon_c-(cos(thet)).^2))./(epsilon_c.*sin(thet)+sqrt(epsilon_c-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E6=E_reflect .* exp(1i.*(-p_reflect));
    E6=E6  .*   cos(pi*sin(thet)/2)./(cos(thet)+0.00001)  .*  cos(thet); 

    E = E0 + E1 + E2 + E3 + E4 + E5 + E6; % 所有的电场强度都代表了路径和反射的损失倍数。
    r_all = 20 * log10(abs(E)) + 2 * 2.15;%r_all实际上是衰减因子，偶然加上两个天线增益，假设为2.15dbi。
    
    r_all = reshape(r_all, room_Y/d_size-1,room_X/d_size-1)';%r_all行列矩阵
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    