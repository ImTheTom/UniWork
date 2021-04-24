
#-----Statement of Authorship----------------------------------------#
#
#  This is an individual assessment item.  By submitting this
#  code I agree that it represents my own work.  I am aware of
#  the University rule that a student must not act in a manner
#  which constitutes academic dishonesty as stated and explained
#  in QUT's Manual of Policies and Procedures, Section C/5.3
#  "Academic Integrity" and Section E/2.1 "Student Code of Conduct".
#
#    Student no: *****PUT YOUR STUDENT NUMBER HERE*****
#    Student name: *****PUT YOUR NAME HERE*****
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
file_name = 'publication.html'

