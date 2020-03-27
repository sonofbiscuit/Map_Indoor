function [predictions, model]=loknn(data, labels, test_data, k)
    % KNN进行分类
    labels=round(labels(:, 1)/100)*100 + round(labels(:, 2)/100); %将坐标xy转换为标签.
    model=ClassificationKNN.fit(data, labels, 'NumNeighbors', k);%模型生成。基于特征和分类标签返回分类模型。X：每列X代表一个特征向量，每行代表一个观察值。Y：每行代表的是X中特征向量说代表的标签或种类。 NumNeighbors为name，value代表K的值
    label_predict = predict(model, test_data);%是待预测的，跟X中特征向量一致，label是预测Xnew返回的类标签
    predictions = [floor(label_predict/100), label_predict-floor(label_predict/100) * 100]; %负无穷方向取整，将预测标签转换为坐标xy
    %disp(predictions);
    predictions = predictions * 100;
end

%label = predict(mdl,Xnew)：Xnew：是待预测的，跟X中特征向量一致，label是预测Xnew返回的类标签