function acc = acc_fina( predictions, labels )
%Labelsʵ��λ�� predictions����λ��
    acc = mean(sqrt(sum((predictions - labels).^2, 2)));%�о�ֵ
end