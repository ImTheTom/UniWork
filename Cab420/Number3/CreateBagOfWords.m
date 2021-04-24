function [ bag ] = CreateBagOfWords(start, number)
%CREATEBAGOFWORDS Summary of this function goes here
%   Detailed explanation goes here
words=importdata('vocab.enron.txt');
words = string(words);

word_info= importdata('docword.enron.txt');
word_info = reshape(word_info,[3, length(word_info)/3])';
word_info=word_info(2:end,:);

wordcount = zeros(length(words),1);
indexs = ones(length(words),1);
for i =1:length(words)
    indexs(i) = i;
end
wordcount = [indexs,wordcount];

for i=1:length(word_info)
    wordcount(word_info(i,2),2) = wordcount(word_info(i,2),2) + word_info(i,3);
end
wordcount = sortrows(wordcount,2, 'descend');
wordcount = wordcount(start:number,:);
bag = [];
for i=1:length(wordcount)
    index = wordcount(i,1);
    word = words(index);
    bag = [bag;word];
end

end

