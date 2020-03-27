function kf_filter = kf_update(kf_filter)
    % �������˲�����
    %predict
    x_=kf_filter.A*kf_filter.x+kf_filter.B*kf_filter.u;%״̬Ԥ�⹫ʽ����F����״̬ת�ƾ�������ʾ������������һ״̬���²⵱ǰ״̬����B���ǿ��ƾ�������ʾ������ u ���������ڵ�ǰ״̬��
    P_=kf_filter.A*kf_filter.P*kf_filter.A'+kf_filter.Q;%Ԥ��ģ�ͱ���Ҳ��������׼ȷ�ģ���������Ҫ����һ��Э������� Q ����ʾԤ��ģ�ͱ��������
    %update
    kf_filter.K=P_*kf_filter.H'*(kf_filter.H*P_ * kf_filter.H' + kf_filter.R)^-1;%K��Ϊ������ϵ������Ҳ��һ���������ǶԲв�ļ�Ȩ����Ҳ�ɽ��˲�������
    kf_filter.x=x_+kf_filter.K*(kf_filter.z-kf_filter.H * x_);%��������һ״̬�²�����ġ���������Ԥ��ֵ֮��Ĳ�������ǵ�ʽ�Ҷ˼Ӻ��Ҳ�Ĳ��֡���ʾʵ�ʹ۲�ֵ��Ԥ���Ĺ۲�ֵ֮��Ĳв����в��ٳ���һ��ϵ��K���ܹ�������Ԥ��ֵ����������
    kf_filter.P=P_-kf_filter.K*kf_filter.H*P_;%������Ԥ��ֵ�������ֲ����и���
end
