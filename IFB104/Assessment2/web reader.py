from urllib import urlopen
from re import findall, match, search

def worldnews():
    world = 'http://feeds.skynews.com/feeds/rss/world.xml'
    web_page=urlopen(world)
    html_code=web_page.read()
    web_page.close()
    world_title = findall('<title.*>(.+)</title>', html_code) [2]
    world_link = findall ('<link.*>(.+)</link>',html_code) [2]
    world_description = findall('<description.*>(.+)</description>', html_code) [1]
    world_publish = findall ('<pubDate.*>(.+)</pubDate>',html_code) [0]
    world_media = findall ('<media:content type="image/jpeg" url="(.+)"/>',html_code)[0]

def uknews():
    uk = 'http://feeds.skynews.com/feeds/rss/uk.xml'
    web_page=urlopen(uk)
    html_code=web_page.read()
    web_page.close()
    uk_title = findall('<title.*>(.+)</title>', html_code) [2]
    uk_link = findall ('<link.*>(.+)</link>',html_code) [2]
    uk_description = findall('<description.*>(.+)</description>', html_code) [1]
    uk_publish = findall ('<pubDate.*>(.+)</pubDate>',html_code) [0]
    uk_media = findall ('<media:content type="image/jpeg" url="(.+)"/>',html_code)[0]

def politics():
    politics = 'http://feeds.skynews.com/feeds/rss/politics.xml'
    web_page=urlopen(politics)
    html_code=web_page.read()
    web_page.close()
    politics_title = findall('<title.*>(.+)</title>', html_code) [2]
    politics_link = findall ('<link.*>(.+)</link>',html_code) [2]
    politics_description = findall('<description.*>(.+)</description>', html_code) [1]
    politics_publish = findall ('<pubDate.*>(.+)</pubDate>',html_code) [0]
    politics_media = findall ('<media:content type="image/jpeg" url="(.+)"/>',html_code)[0]

def strange():
    strange = 'http://feeds.skynews.com/feeds/rss/strange.xml'
    web_page=urlopen(strange)
    html_code=web_page.read()
    web_page.close()
    strange_title = findall('<title.*>(.+)</title>', html_code) [2]
    strange_link = findall ('<link.*>(.+)</link>',html_code) [2]
    strange_description = findall('<description.*>(.+)</description>', html_code) [1]
    strange_publish = findall ('<pubDate.*>(.+)</pubDate>',html_code) [0]
    strange_media = findall ('<media:content type="image/jpeg" url="(.+)"/>',html_code)[0]

def tech():
    tech = 'http://feeds.skynews.com/feeds/rss/technology.xml'
    web_page=urlopen(tech)
    html_code=web_page.read()
    web_page.close()
    tech_title = findall('<title.*>(.+)</title>', html_code) [2]
    tech_link = findall ('<link.*>(.+)</link>',html_code) [2]
    tech_description = findall('<description.*>(.+)</description>', html_code) [1]
    tech_publish = findall ('<pubDate.*>(.+)</pubDate>',html_code) [0]
    tech_media = findall ('<media:content type="image/jpeg" url="(.+)"/>',html_code)[0]

def entertainment():
    entertainment = 'http://feeds.skynews.com/feeds/rss/entertainment.xml'
    web_page=urlopen(entertainment)
    html_code=web_page.read()
    web_page.close()
    entertainment_title = findall('<title.*>(.+)</title>', html_code) [2]
    entertainment_link = findall ('<link.*>(.+)</link>',html_code) [2]
    entertainment_description = findall('<description.*>(.+)</description>', html_code) [1]
    entertainment_publish = findall ('<pubDate.*>(.+)</pubDate>',html_code) [0]
    entertainment_media = findall ('<media:content type="image/jpeg" url="(.+)"/>',html_code)[0]
