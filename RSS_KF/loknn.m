function [predictions, model]=loknn(data, labels, test_data, k)
    % KNN���з���
    labels=round(labels(:, 1)/100)*100 + round(labels(:, 2)/100); %������xyת��Ϊ��ǩ.
    model=ClassificationKNN.fit(data, labels, 'NumNeighbors', k);%ģ�����ɡ����������ͷ����ǩ���ط���ģ�͡�X��ÿ��X����һ������������ÿ�д���һ���۲�ֵ��Y��ÿ�д������X����������˵����ı�ǩ�����ࡣ NumNeighborsΪname��value����K��ֵ
    label_predict = predict(model, test_data);%�Ǵ�Ԥ��ģ���X����������һ�£�label��Ԥ��Xnew���ص����ǩ
    predictions = [floor(label_predict/100), label_predict-floor(label_predict/100) * 100]; %�������ȡ������Ԥ���ǩת��Ϊ����xy
    %disp(predictions);
    predictions = predictions * 100;
end

%label = predict(mdl,Xnew)��Xnew���Ǵ�Ԥ��ģ���X����������һ�£�label��Ԥ��Xnew���ص����ǩ