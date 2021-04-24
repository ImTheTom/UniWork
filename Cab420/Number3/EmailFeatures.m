function [ x ] = EmailFeatures( word_indices,words )
%EMAILFEATURES Summary of this function goes here
%   Detailed explanation goes here
n = length(words);
x = zeros(n, 1);
for i = 1: length(word_indices)
    x(word_indices(i)) = 1;
end
end

