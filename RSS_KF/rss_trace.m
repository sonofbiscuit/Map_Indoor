%����׷��
function r_all=rss_trace(room_X,room_Y,room_Z,trace_X,trace_Y,trace_Z,d_size,sig_frequence)
%����
%������ź�ǿ��
%���룺����x,y,z���ź�Դ����x,y,z,�źŴ���Ƶ��(MHz),���ӳߴ�(m)
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
    %��������ÿ������ź�ǿ��
    
    %��糣���͵絼��
    epsilon_c=10-1.2j;%������λ
    epsilon_w=6.1-1.2j;
    
    T=1/(sig_frequence*10^6);%MHz
    c=3.0e8;
    wavelength=c / (sig_frequence * 10^6);
    %��ȡ�ռ�������������λ�����꣬�̶�z���ź�Դ�ĸ߶�
    %�����������
    [X,Y] = meshgrid(d_size:d_size:(room_X-d_size), d_size:d_size:(room_Y-d_size));%1�׸߶ȵ����е�
    L = [X(:), Y(:)];%����������X(:)/Y(:) * 2�ľ���
    L = [L, zeros(size(X(:))) + trace_Z];
    
    %ֱ��·��
    %�ɷ����������λ�仯����ӵ��糡E�ļ����С�
    %����˥���������λ�仯
    d_direct = sqrt((L(:,1) - trace_X).^2 + (L(:,2)-trace_Y).^2 + (L(:,3) - trace_Z).^2); % ��������ź�Դ��ŷ����¾���
    t_direct_0 = d_direct./1000./c;  %ʱ��
    p_direct = mod(t_direct_0*2*pi/T,2*pi);% ��λ
    E_direct = (wavelength./(4.*pi.*d_direct./1000));% E����ȫ�ǳ�ǿ�����볡ǿ������
    E0=E_direct.* exp(1i.*(-p_direct));

    %�����L���������������ꡣÿ����Ϊ��һ�����ꡣ
    %Li��Ӧ��������������Ӧ�ľ���㣬�ֱ�������鷴��·����

    %ǰƽ�淴��·����ǰ�����ϣ��£��ϣ��£��ϣ�����ζ�ţ���վ�ڴ˿��У�����y�ᣬȻ������ƽ���Ϊǰ��������,��,�£�
    Li=[L(:,1) , 2.*room_Y-L(:,2) , L(:,3)]; %���㾵���
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);%����·������
    t_reflect_1 = d_reflect./1000./c;%ʱ��
    p_reflect = mod(t_reflect_1*2*pi/T,2*pi);%��λ
    thet = abs(atan((Li(:,2)-trace_Y)./(Li(:,1)-trace_X)));% �����
    reflect_coefficient = (sin(thet)-sqrt(epsilon_w-(cos(thet)).^2))./(sin(thet)+sqrt(epsilon_w-(cos(thet)).^2));%����ϵ��ҲΪ����
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E1=E_reflect .* exp(1i.*(-p_reflect)); % �ӳٵ���λ�뷴�������˥������λ�仯һ�𱻼��롣

    % ��ƽ�淴��·��
    Li=[L(:,1) , -L(:,2) , L(:,3)]; % ���㾵���
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_2 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_2*2*pi/T,2*pi);
    thet = abs(atan((Li(:,2)-trace_Y)./(Li(:,1)-trace_X)));
    reflect_coefficient = (sin(thet)-sqrt(epsilon_w-(cos(thet)).^2))./(sin(thet)+sqrt(epsilon_w-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E2=E_reflect .* exp(1i.*(-p_reflect));

    % ��
    Li=[-L(:,1) , L(:,2) , L(:,3)]; 
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_3 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_3*2*pi/T,2*pi);
    thet = abs(atan((Li(:,1)-trace_X)./(Li(:,2)-trace_Y)));
    reflect_coefficient = (sin(thet)-sqrt(epsilon_w-(cos(thet)).^2))./(sin(thet)+sqrt(epsilon_w-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E3=E_reflect .* exp(1i.*(-p_reflect));

    % ��
    Li=[2*room_X-L(:,1) , L(:,2) , L(:,3)]; 
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_4 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_4*2*pi/T,2*pi);
    thet = abs(atan((Li(:,1)-trace_X)./(Li(:,2)-trace_Y)));
    reflect_coefficient = (sin(thet)-sqrt(epsilon_w-(cos(thet)).^2))./(sin(thet)+sqrt(epsilon_w-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E4=E_reflect .* exp(1i.*(-p_reflect));

    % ��
    Li=[L(:,1) , L(:,2) , 2*room_Z-L(:,3)]; 
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_5 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_5*2*pi/T,2*pi);
    thet = abs(atan((Li(:,3)-trace_Z)./sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2)));
    reflect_coefficient = (-sin(thet).*epsilon_c+sqrt(epsilon_c-(cos(thet)).^2))./(epsilon_c.*sin(thet)+sqrt(epsilon_c-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E5=E_reflect .* exp(1i.*(-p_reflect));
    E5=E5  .*   cos(pi*sin(thet)/2)./(cos(thet)+0.00001)  .*  cos(thet); %����ͼ���ʹ�ֱ�ֽ⣬�糡������ƽ����Ҫ��������
    % ��
    Li=[L(:,1) , L(:,2) , -L(:,3)]; 
    d_reflect = sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2+(Li(:,3)-trace_Z).^2);
    t_reflect_6 = d_reflect./1000./c;
    p_reflect = mod(t_reflect_6*2*pi/T,2*pi);
    thet = abs(atan((Li(:,3)-trace_Z)./sqrt((Li(:,1)-trace_X).^2+(Li(:,2)-trace_Y).^2)));
    reflect_coefficient = (-sin(thet).*epsilon_c+sqrt(epsilon_c-(cos(thet)).^2))./(epsilon_c.*sin(thet)+sqrt(epsilon_c-(cos(thet)).^2));
    E_reflect = (wavelength./(4.*pi.*d_reflect./1000)) .*  reflect_coefficient;
    E6=E_reflect .* exp(1i.*(-p_reflect));
    E6=E6  .*   cos(pi*sin(thet)/2)./(cos(thet)+0.00001)  .*  cos(thet); 

    E = E0 + E1 + E2 + E3 + E4 + E5 + E6; % ���еĵ糡ǿ�ȶ�������·���ͷ������ʧ������
    r_all = 20 * log10(abs(E)) + 2 * 2.15;%r_allʵ������˥�����ӣ�żȻ���������������棬����Ϊ2.15dbi��
    
    r_all = reshape(r_all, room_Y/d_size-1,room_X/d_size-1)';%r_all���о���
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    