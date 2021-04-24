function [ email ] = CleanEmail( email )
%CLEANEMAIL Summary of this function goes here
%   Detailed explanation goes here
email = lower(email);
email = regexprep(email,'\s+',' ');
email = regexprep(email,'[0-9]',' ');
email = strrep(email,'.','');
email = strrep(email,',','');
email = strrep(email,'?','');
email = strrep(email,'"','');
email = strrep(email,"'",'');
email = strrep(email,'!','');
email = strrep(email,'-','');
email = strrep(email,':','');
email = strrep(email,'=','');
email = strrep(email,'(','');
email = strrep(email,')','');
email = strrep(email,'&','');
email = strrep(email,'%','');
email = strrep(email,'$','');
email = strrep(email,'#','');
email = strrep(email,'>','');
email = strrep(email,'<','');
email = strrep(email,'/','');
email = strrep(email,'\','');
email = strrep(email,'[','');
email = strrep(email,']','');
email = strrep(email,'{','');
email = strrep(email,'}','');
email = strrep(email,'|','');
email = strsplit(email, " ");
email = email(1:end-1);

end

