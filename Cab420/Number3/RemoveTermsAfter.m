function [ vector ] = RemoveTermsAfter( vector, term )
%REMOVETERMSAFTER removes part of the string
%   Finds a search term and removes the rest of the string before the
%   string
%   Useful for getting rid of messages header info
for i=1:length(vector)
    currentEmail = vector(i,2);
    locations = strfind(currentEmail, term);
    if(~isempty(locations))
        currentEmail = extractAfter(currentEmail, locations(1));
    end
    vector(i,2) = currentEmail;
end

end

