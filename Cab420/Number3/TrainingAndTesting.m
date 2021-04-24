function [ training, testing ] = TrainingAndTesting( data, split )
%TRAININGANDTESTING Summary of this function goes here
%   Detailed explanation goes here
unique_indexes = unique(data(:,1));
p=split;
training = [];
testing = [];
for k=1:length(unique_indexes)
    temp=[];
    for i=1:length(data)
        if(unique_indexes(k)==data(i))
            temp= [temp;unique_indexes(k), data(i,3)];
        end
    end
    N = length(temp);
    tf = false(N,1);
    tf(1:round(p*N)) = true;
    tf = tf(randperm(N));
    dataTraining = temp(tf,:);
    dataTesting = temp(~tf,:);
    training= [training;dataTraining];
    testing = [testing;dataTesting];
end

end

