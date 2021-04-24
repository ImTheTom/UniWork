import webbrowser
from urllib import urlopen
from re import findall, match, search

page=open('test.htm', 'w')
first_page="""<html>
<head>
<title>UK News to you</title>
<style> body {background-color: teal;}
hr { border-style:solid; margin-top:3em; margin-bottom;3em;}
</style>
</head>
<body>
<p align = 'center'>
<span style = 'font-size:75px; font-family:Arial'>
UK News To You
</span>
</p>
<p align = 'center'>
<img src = "http://orig09.deviantart.net/d31e/f/2008/215/4/c/dad__s_army_flag_by_st_jim.png" alt='image not found at this time'/>
</p>
<p align = 'center'>
<span style ='font-size:30px; font-family:Arial'>
News U Kan rely on everyday
</span>
</p>
<p>
 
</p>
<p align = 'center'>
<span style = 'font-size:22; font-family:Arial'>
Journalist for today is Tom Bowyer
</span>
</p>"""
page.write(first_page)

def world():
    world = 'http://feeds.skynews.com/feeds/rss/world.xml'
    web_page=urlopen(world)
    html_code_world=web_page.read()
    web_page.close()
    world_title = findall('<title.*>(.+)</title>', html_code_world) [2]
    world_link = findall ('<link.*>(.+)</link>',html_code_world) [2]
    world_description = findall('<description.*>(.+)</description>', html_code_world) [1]
    world_publish = findall ('<pubDate.*>(.+)</pubDate>',html_code_world) [0]
    world_media = findall ('<media:content type="image/jpeg" url="(.+)"/>',html_code_world)[0]


    page.write("""<p align = 'center'>
    <span style = 'font-size:25px; font-family:Arial'>""")
    page.write(world_title)
    page.write("""</span>
    </p>
    <p align = 'center'>
    <img src = " """)
    page.write(world_media)
    page.write(""" "style="width: 300px; height: 200px;"/>
    </p>
    <p align = 'center'>
    <span style = 'font-size:12px; font-family:Arial'>""")
    page.write(world_description)
    page.write(world_publish)
    page.write('<br />')
    page.write(world_link)
    page.write("""</span>
    </p>""")
    
def uk():
    uk = 'http://feeds.skynews.com/feeds/rss/uk.xml'
    web_page=urlopen(uk)
    html_code=web_page.read()
    web_page.close()
    uk_title = findall('<title.*>(.+)</title>', html_code) [2]
    uk_link = findall ('<link.*>(.+)</link>',html_code) [2]
    uk_description = findall('<description.*>(.+)</description>', html_code) [1]
    uk_publish = findall ('<pubDate.*>(.+)</pubDate>',html_code) [0]
    uk_media = findall ('<media:content type="image/jpeg" url="(.+)"/>',html_code)[0]

    page.write("""<p align = 'center'>
    <span style = 'font-size:25px; font-family:Arial'>""")
    page.write(uk_title)
    page.write("""</span>
    </p>
    <p align = 'center'>
    <img src = " """)
    page.write(uk_media)
    page.write(""" "style="width: 300px; height: 200px;"/>
    </p>
    <p align = 'center'>
    <span style = 'font-size:12px; font-family:Arial'>""")
    page.write(uk_description)
    page.write(uk_publish)
    page.write('<br />')
    page.write(uk_link)
    page.write("""</span>
    </p>""")
    
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

    page.write("""<p align = 'center'>
    <span style = 'font-size:25px; font-family:Arial'>""")
    page.write(politics_title)
    page.write("""</span>
    </p>
    <p align = 'center'>
    <img src = " """)
    page.write(politics_media)
    page.write(""" "style="width: 300px; height: 200px;"/>
    </p>
    <p align = 'center'>
    <span style = 'font-size:12px; font-family:Arial'>""")
    page.write(politics_description)
    page.write(politics_publish)
    page.write('<br />')
    page.write(politics_link)
    page.write("""</span>
    </p>""")

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

    page.write("""<p align = 'center'>
    <span style = 'font-size:25px; font-family:Arial'>""")
    page.write(strange_title)
    page.write("""</span>
    </p>
    <p align = 'center'>
    <img src = " """)
    page.write(strange_media)
    page.write(""" "style="width: 300px; height: 200px;"/>
    </p>
    <p align = 'center'>
    <span style = 'font-size:12px; font-family:Arial'>""")
    page.write(strange_description)
    page.write(strange_publish)
    page.write('<br />')
    page.write(strange_link)
    page.write("""</span>
    </p>""")

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

    page.write("""<p align = 'center'>
    <span style = 'font-size:25px; font-family:Arial'>""")
    page.write(tech_title)
    page.write("""</span>
    </p>
    <p align = 'center'>
    <img src = " """)
    page.write(tech_media)
    page.write(""" "style="width: 300px; height: 200px;"/>
    </p>
    <p align = 'center'>
    <span style = 'font-size:12px; font-family:Arial'>""")
    page.write(tech_description)
    page.write(tech_publish)
    page.write('<br />')
    page.write(tech_link)
    page.write("""</span>
    </p>""")

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

    page.write("""<p align = 'center'>
    <span style = 'font-size:25px; font-family:Arial'>""")
    page.write(entertainment_title)
    page.write("""</span>
    </p>
    <p align = 'center'>
    <img src = " """)
    page.write(entertainment_media)
    page.write(""" "style="width: 300px; height: 200px;"/>
    </p>
    <p align = 'center'>
    <span style = 'font-size:12px; font-family:Arial'>""")
    page.write(entertainment_description)
    page.write(entertainment_publish)
    page.write('<br />')
    page.write(entertainment_link)
    page.write("""</span>
    </p>""")
    
end="""
</html>"""
page.write(end)
page.close()
webbrowser.open_new_tab('test.htm')
