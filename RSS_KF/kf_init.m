function kf_filter = kf_init(Px, Py, Vx, Vy)
% x(坐标x,坐标y,速度x,速度y),观测z坐标x，坐标y)

    kf_filter.B=0; %外部输入
    kf_filter.u=0; %同
    kf_filter.K=NaN; %卡尔曼增益
    kf_filter.z=NaN; %每次更新输入观察值
    kf_filter.P=zeros(4, 4); %初试P 4x4 0矩阵

    kf_filter.x = [Px;Py;Vx;Vy];%初始状态：函数外部提供初始化的状态，本例使用观察值进行初始化，Vx，Vy初始为0

    % 状态转移矩阵
    kf_filter.A=eye(4)+diag(ones(1,2),2); % 这与线性系统的预测机制有关，线性系统是上一刻的位置加上速度等于当前时刻的位置，而速度本身保持不变。4x4单位矩阵加上
    %预测噪声协方差矩阵Q：假设高斯噪声叠加在预测过程上，并且协方差矩阵是Q。 
    %假设y轴上移动目标的速度可能不均匀，则可以增加此对角矩阵的最终值。 有时你希望出现的轨迹更平滑，你可以使这个音调更小。
    kf_filter.Q=diag(ones(4,1)*0.001); 

    % 观察矩阵H，z = H * x
    kf_filter.H=eye(2,4); % 状态是（坐标x，坐标y，速度x，速度y），观测值是（坐标x，坐标y），所以H 2x4单位矩阵
    % 观测到的噪声协方差矩阵R：假设观测过程中存在高斯噪声，则协方差矩阵为R.
    kf_filter.R=diag(ones(2,1) * 2); %大小取决于观察过程中的信任程度。 假设观察中坐标的x值通常是准确的，矩阵R的第一个值应该更小。
end
%1阶原点矩 期望 2阶中心距 方差