function [ vector ] = RemoveTermsBefore( vector, term )
%REMOVETERMS removes part of the string
%   Finds a search term and removes the rest of the string
%   Useful for getting rid of messages that contain forwarded emails
%   or reply messages
for i=1:length(vector)
    currentEmail = vector(i,2);
    locations = strfind(currentEmail, term);
    if(~isempty(locations))
        currentEmail = extractBefore(currentEmail, locations(1));
    end
    vector(i,2) = currentEmail;
end

end

