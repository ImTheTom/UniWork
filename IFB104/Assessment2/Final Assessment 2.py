
#-----Statement of Authorship----------------------------------------#
#
#  This is an individual assessment item.  By submitting this
#  code I agree that it represents my own work.  I am aware of
#  the University rule that a student must not act in a manner
#  which constitutes academic dishonesty as stated and explained
#  in QUT's Manual of Policies and Procedures, Section C/5.3
#  "Academic Integrity" and Section E/2.1 "Student Code of Conduct".
#
#    Student no: n9702351
#    Student name: TOM Bowyer
#
#  NB: Files submitted without a completed copy of this statement
#  will not be marked.  Submitted files will be subjected to
#  software plagiarism analysis using the MoSS system
#  (http://theory.stanford.edu/~aiken/moss/).
#
#--------------------------------------------------------------------#



#-----Task Description-----------------------------------------------#
#
#  Publish Your Own Periodical
#
#  In this task you will combine your knowledge of HTMl/XML mark-up
#  languages with your skills in Python scripting, pattern matching
#  and Graphical User Interface design and development to produce a
#  useful application for publishing a customised newspaper or
#  magazine on a topic of your own choice.  See the instruction
#  sheet accompanying this file for full details.
#
#--------------------------------------------------------------------#



#-----Imported Functions---------------------------------------------#
#
# Below are various import statements that were used in our sample
# solution.  You should be able to complete this assignment using
# these functions only.

# Import the function for opening a web document given its URL.
from urllib import urlopen

# Import the function for finding all occurrences of a pattern
# defined via a regular expression.
from re import findall

# A function for opening an HTML document in your operating
# system's default web browser. We have called the function
# "webopen" so that it isn't confused with the "open" function
# for writing/reading local text files.
from webbrowser import open as webopen

# An operating system-specific function for getting the current
# working directory/folder.  Use this function to create the
# full path name to your publication file.
from os import getcwd

# An operating system-specific function for 'normalising' a
# path to a file to the path naming conventions used on this
# platform.  Apply this function to the full name of your
# publication file so that your program will work on any
# operating system.
from os.path import normpath
    
# Import the standard Tkinter functions.
from Tkinter import *

# Import the SQLite functions.
from sqlite3 import *

# Import the date/time function.
from datetime import datetime

#
#--------------------------------------------------------------------#



#-----Student's Solution---------------------------------------------#
#
# Put your solution at the end of this file.
#

# Name of the published newspaper or magazine. To simplify marking,
# your program should publish its results using this file name.


import webbrowser

from re import findall, match, search
gui=Tk()
gui.title('Assesment two, n9702351')

worldvar=BooleanVar()
entertainmentvar=BooleanVar()
techvar=BooleanVar()
politicsvar=BooleanVar()
strangevar=BooleanVar()
ukvar=BooleanVar()


worldvar=BooleanVar()
entertainmentvar=BooleanVar()
techvar=BooleanVar()
politicsvar=BooleanVar()
strangevar=BooleanVar()
ukvar=BooleanVar()

#big function to load everything
def button_clicked():
    page=open('publication.html', 'w')
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
    
    worldnews=worldvar.get()
    if worldnews==True:
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
    
    entertainmentnews=entertainmentvar.get()
    if entertainmentnews==True:
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
    
    technews=techvar.get()
    if technews==True:
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
        
    politicsnews=politicsvar.get()
    if politicsnews==True:
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

        
    strangenews=strangevar.get()
    if strangenews==True:
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
        
    uknews=ukvar.get()
    if uknews==True:
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
   
    end="""
    </html>"""
    page.write(end)
    page.close()
    ready['text']='READY'
    ready['state']=ACTIVE

# function to open the html
def read():
    webbrowser.open_new_tab('publication.html')


#Check buttons to decide what news you want to read
heading=Label(gui, text = 'Select which news you want to read today?',font = ('Arial', 15, 'bold'))
heading.grid(row=1, column=1, columnspan = 2)
world=Checkbutton(gui, text="World Events", justify=LEFT, variable=worldvar)
world.grid(row=2, column = 1, columnspan =1)
entertainment=Checkbutton(gui, text="Entertainment", justify=LEFT, variable=entertainmentvar)
entertainment.grid(row=2, column = 2, columnspan =1)
tech=Checkbutton(gui, text="Technology", justify=LEFT, variable=techvar)
tech.grid(row=3, column = 1, columnspan =1)
politics=Checkbutton(gui, text="UK Politics", justify=LEFT, variable=politicsvar)
politics.grid(row=3, column = 2, columnspan =1)
strange=Checkbutton(gui, text="Strange News", justify=LEFT, variable=strangevar)
strange.grid(row=4, column = 1, columnspan =1)
uk=Checkbutton(gui, text="UK News", justify=LEFT, variable=ukvar)
uk.grid(row=4, column = 2, columnspan =1)

# Basic confirmination buttons to download the news
confirm=Label(gui, text = 'Confirm your selection',font = ('Arial', 15, 'bold'))
confirm.grid(row=5, column=1, columnspan = 2)
confirm=Button(gui, text = 'Confirm', font=('Arial', 12), bd=5, bg='blue', activebackground='blue', activeforeground='white', fg='white', command=button_clicked)
confirm.grid(row=6, column=1, columnspan=2)

# Basic user interface to dispaly when the news is read
wait=Label(gui, text = 'Wait for the proram to load',font = ('Arial', 15, 'bold'))
wait.grid(row=7, column=1, columnspan = 2)
ready= Button(gui, text = 'NOT READY', font=('Arial', 12), bd=5, bg='red', activebackground='green', activeforeground='white', fg='white')
ready.grid(row=8, column=1, columnspan=2)

# Comand to open up the html document
opens=Label(gui, text = 'When complete, press the button below to open', font = ('Arial', 15, 'bold'))
opens.grid(row=9, column=1, columnspan=2)
opend=Button(gui, text = 'Open', font=('Arial', 12), bd=5, bg='blue', activebackground='blue', activeforeground='white', fg='white', command=read)
opend.grid(row=10, column=1, columnspan=2)

gui.mainloop()

