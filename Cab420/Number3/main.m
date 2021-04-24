a=load('sent_mail');
data = a.data;
search_term = "Forwarded by"; %Original Message
data = RemoveTermsBefore(data, search_term);
search_term = "X-FileName:"; %Original Message
data = RemoveTermsAfter(data, search_term);