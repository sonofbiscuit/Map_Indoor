function acc = acc_fina( predictions, labels )
%Labels实际位置 predictions估测位置
    acc = mean(sqrt(sum((predictions - labels).^2, 2)));%行均值
end