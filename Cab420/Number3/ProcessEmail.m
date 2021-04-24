function [ word_indices ] = ProcessEmail( email, words )
%PROCESSEMAIL Summary of this function goes here
%   Detailed explanation goes here

n = length(words);
word_indices=[];

for j = 1:length(email)
for i = 1:n
      if(strcmp(email(j), words(i)))
        word_indices = [ word_indices ; i];
      end
end
end

end

