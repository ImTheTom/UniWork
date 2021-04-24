function [ final_data ] = GetMostEmails( data, x  )
%GETMOSTEMAILS Used to get the most emails from dataset
%   Assumes email stirng is located in the second column
%   data is the vector and x is the number of people
unique_indexes = unique(data(:,1));
final_data = [];
for j=1:x
    current = [];
    pop_k_value=0;
        for k=1:length(unique_indexes)
        temp = [];
            for i=1:length(data)
                if(unique_indexes(k)==data(i))
                    temp= [temp;unique_indexes(k), data(i,2)];
                end
                if(length(temp)>length(current))
                    current =temp;
                    pop_k_value= k;
                end
            end
        end
    unique_indexes(pop_k_value)=[];
    final_data= [final_data;current];
end

end

