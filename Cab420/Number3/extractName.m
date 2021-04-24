function [data] = extractName(data)
%EXTRACTNAME 
% extracts the name
% removes messages that are less than 30

len = length(data);
for i = 1:len
   
    dataSplit = strsplit(data(i,2),char(10));
     
    dataBody = strjoin(dataSplit(3:end)); % rejoin into one string extracting the body
    data(i,3) = replace(dataBody,char(10),' '); % delete all the new lines
    data(i,3) = erase(data(i,3),'-'); % there is a bunch of these at the end of some emails
    data(i,3) = erase(data(i,3),'.'); % remove fullstops
    data(i,3) = lower(data(i,3)); % convert to lower case
    data(i,3) = regexprep(data(i,3), '-', ' ');
    data(i,3) = regexprep(data(i,3), '[0-9]+', 'number');
    data(i,3) = regexprep(data(i,3),'(http|https)://[^\s]*', 'httpaddr');
    data(i,3) = regexprep(data(i,3), '[^\s]+@[^\s]+', 'emailaddr');
    data(i,3) = regexprep(data(i,3), '[$]+', 'dollar');
    
    % extract the name
    personName = strsplit(dataSplit(1));
    data(i,2) = personName(2); % get the first value 
        
end

idx = find(strlength(data(:,3)) < 30 ); % delete if it is less than 30 char
data(idx,:) = [];



len2 = length(data);
for i = 1:len2

    
    email_contents = data(i,3);
    email_contents = char(email_contents); %convert to char vec
    
    email = {};
    count = 1;
    while ~isempty(email_contents)
    
            % Tokenize and also get rid of any punctuation
        [str, email_contents] = strtok(email_contents, [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);

        % Remove any non alphanumeric characters
        str = regexprep(str, '[^a-zA-Z0-9]', '');

        % Stem the word 
        % (the porterStemmer sometimes has issues, so we use a try catch block)
        %try str = normalizeWords(strtrim(str)); 
        %catch str = ''; continue;
        %end;

        % Skip the word if it is too short
        if length(str) < 1
           continue;
        end
    
    email{count} = str;
    count = count +1;
    
    end    
 
      
    data(i,3) = strjoin(email);

end



end

