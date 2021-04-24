function [ data ] = LoadEmails(query)
%LOADEMAILS Used to load the eron emails dataset
%   Assumes that the emails folder is in the same directory
%   and is known as emails
%   param query - folder directory to be searched i.e. _sent_mail
listing = dir('emails/maildir');
listing = listing(3:end,:);
data = zeros(1,2);
for i=1:length(listing)
    user = listing(i).name;
    sent_mail = char("emails/maildir/"+user+"/"+query);
    contents_of_user = dir(sent_mail);
    contents_of_user = contents_of_user(3:end,:);
        for j=1:length(contents_of_user)
            file = contents_of_user(j).name;
            file = sent_mail+"\"+char(file);
            file = char(file);
            try
                data= [data;i, string(fileread(file))];
            catch
                warning('Could not read a file')
            end
        end
end
data = data(2:end,:);

end

