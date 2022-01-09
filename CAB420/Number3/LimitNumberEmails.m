function [ finData ] = LimitNumberEmails( data )
%LIMITNUMBEREMAILS Summary of this function goes here
%   Detailed explanation goes here
unique_indexes = unique(data(:,1));
final_data = [];
current = 1000000;
smallest = 0;
for k=1:length(unique_indexes)
    temp = [];
    for i=1:length(data)
        if(unique_indexes(k)==data(i))
            temp= [temp;unique_indexes(k), data(i,2), data(i,3)];
        end
    end
      if(length(temp)<current)
            current =length(temp);
            smallest = unique_indexes(k);
        end
end

finData = [];
for k=1:length(unique_indexes)
    temp = [];
    for i=1:length(data)
        if(unique_indexes(k)==data(i))
            temp= [temp;unique_indexes(k), data(i,2), data(i,3)];
        end
    end
    temp = temp(1:current,:,:);
    finData =[finData;temp];
end

end

