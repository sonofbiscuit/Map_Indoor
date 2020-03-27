function kf_filter = kf_update(kf_filter)
    % 卡尔曼滤波方程
    %predict
    x_=kf_filter.A*kf_filter.x+kf_filter.B*kf_filter.u;%状态预测公式，而F就是状态转移矩阵。它表示我们怎样从上一状态来猜测当前状态。而B则是控制矩阵，它表示控制量 u 怎样作用于当前状态。
    P_=kf_filter.A*kf_filter.P*kf_filter.A'+kf_filter.Q;%预测模型本身也并不绝对准确的，所以我们要引入一个协方差矩阵 Q 来表示预测模型本身的噪声
    %update
    kf_filter.K=P_*kf_filter.H'*(kf_filter.H*P_ * kf_filter.H' + kf_filter.R)^-1;%K称为卡尔曼系数，它也是一个矩阵，它是对残差的加权矩阵。也可叫滤波增益阵
    kf_filter.x=x_+kf_filter.K*(kf_filter.z-kf_filter.H * x_);%是依据上一状态猜测而来的。它与最优预计值之间的差距如今就是等式右端加号右侧的部分。表示实际观察值与预估的观测值之间的残差。这个残差再乘以一个系数K就能够用来对预计值进行修正。
    kf_filter.P=P_-kf_filter.K*kf_filter.H*P_;%对最优预计值的噪声分布进行更新
end
