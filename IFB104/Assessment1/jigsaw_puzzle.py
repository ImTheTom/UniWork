
#-----Statement of Authorship----------------------------------------#
#
#  This is an individual assessment item.  By submitting this
#  code I agree that it represents my own work.  I am aware of
#  the University rule that a student must not act in a manner
#  which constitutes academic dishonesty as stated and explained
#  in QUT's Manual of Policies and Procedures, Section C/5.3
#  "Academic Integrity" and Section E/2.1 "Student Code of Conduct".
#
#    Student no: N9702351
#    Student name: Tom Bowyer
#
#  NB: Files submitted without a completed copy of this statement
#  will not be marked.  All files submitted will be subjected to
#  software plagiarism analysis using the MoSS system
#  (http://theory.stanford.edu/~aiken/moss/).
#
#--------------------------------------------------------------------#



#-----Assignment Description-----------------------------------------#
#
#  FOUR PIECE JIGSAW PUZZLE
#
#  This assignment tests your skills at defining functions, processing
#  data stored in lists and performing the arithmetic calculations
#  necessary to display a complex visual image.  The incomplete
#  Python script below is missing a crucial function, "draw_attempt".
#  You are required to complete this function so that when the
#  program is run it produces a picture of a jigsaw puzzle whose
#  state of completion is determined by data stored in a list which
#  specifies the locations of the pieces.  You are also required to
#  provide a solution to your particular puzzle.  See the instruction
#  sheet accompanying this file for full details.
#
#  Note that this assignment is in two parts, the second of which
#  will be released only just before the final deadline.  This
#  template file will be used for both parts and you will submit
#  your final solution as a single file, whether or not you
#  complete both parts of the assignment.
#
#--------------------------------------------------------------------#  



#-----Preamble-------------------------------------------------------#
#
# This section imports necessary functions and defines constant
# values used for creating the drawing canvas.  You should not change
# any of the code in this section.
#

# Import the functions needed to complete this assignment.  You
# should not need to use any other modules for your solution.

from turtle import *
from math import *

# Define constant values used in the main program that sets up
# the drawing canvas.  Do not change any of these values.

size_of_pieces = 300 # pixels (excluding any protruding "tabs")
half_piece_size = size_of_pieces / 2
max_tab_size = 100 # pixels
box_size = size_of_pieces + (max_tab_size * 2)
half_box_size = box_size / 2
left_border = max_tab_size
gap = max_tab_size
top_bottom_border = max_tab_size
canvas_height = (top_bottom_border + size_of_pieces) * 2
canvas_width = (size_of_pieces * 2 + left_border) * 2
template_centres = [[-(size_of_pieces + half_piece_size), -half_piece_size], # bottom left
                    [-half_piece_size, -half_piece_size], # bottom right
                    [-(size_of_pieces + half_piece_size), half_piece_size], # top left
                    [-half_piece_size, half_piece_size]] # top right
box_centre = [gap + (box_size / 2), 0]

#
#--------------------------------------------------------------------#



#-----Functions for Drawing the Background---------------------------#
#
# The functions in this section are called by the main program to
# draw the background for the puzzle, i.e., the template for the
# pieces and the box they're kept in.  You should not change any of
# the code in this section.  Note that each of these functions
# leaves the turtle's pen up and at its standard width and colour.
#


# Draw the box that contains unused puzzle pieces.  (The box is
# larger than the puzzle pieces to allow for tabs sticking out on
# any of their four sides.)
def draw_box():

    # Determine the position of the box's bottom-left corner
    bottom_left = [box_centre[0] - half_box_size,
                   box_centre[1] - half_box_size]

    # Go to the bottom-left corner and get ready to draw
    penup()
    goto(bottom_left)
    width(5)
    color('black')
    pendown()
    
    # Walk around the box's perimeter
    setheading(0) # point east
    for side in [1, 2, 3, 4]:
        forward(box_size)
        left(90)

    # Reset the pen
    width(1)
    penup()
 

# Draw the individual squares of the jigsaw's template
def draw_template(show_template = False):

    # Only draw if the argument is True
    if show_template:

        # Set up the pen
        width(3)
        color('grey')

        # Draw a box for each centre coordinate
        for centre_x, centre_y in template_centres:
            
            # Determine the position of this square's bottom-left corner
            bottom_left = [centre_x - half_piece_size,
                           centre_y - half_piece_size]

            # Go to the bottom-left corner and get ready to draw
            penup()
            goto(bottom_left)
            pendown()
        
            # Walk around the square's perimeter
            setheading(0) # point east
            for side in [1, 2, 3, 4]:
                forward(size_of_pieces)
                left(90)

        # Reset the pen
        width(1)
        color('black')
        penup()


# As a debugging aid, mark the coordinates of the centres of
# the template squares and the box
def mark_coords(show_coords = False):

    # Only mark the coordinates if the argument is True
    if show_coords:

        # Don't draw lines between the coordinates
        penup()

        # Go to each coordinate, draw a dot and print the coordinate
        color('black')
        for x_coord, y_coord in template_centres + [box_centre]:
            goto(x_coord, y_coord)
            dot(4)
            write(str(x_coord) + ', ' + str(y_coord),
                  font = ('Arial', 12, 'normal'))

    # Reset the pen
    width(1)
    penup()
               
#
#--------------------------------------------------------------------#



#-----Test data------------------------------------------------------#
#
# These are the data sets you will use to test your code.
# Each of the data sets is a list specifying the locations of
# jigsaw puzzle pieces:
#
# 1. The name of the piece, from 'Piece A' to 'Piece D'
# 2. The place to put the piece, either in the template, denoted
#    'Top left', 'Top right', 'Bottom left' or 'Bottom right', or
#    in the unused pieces box, denoted 'In box'
# 3. An optional mystery value, 'X', whose purpose will be
#    revealed only in the second part of the assignment
#
# Each data set does not necessarily mention all pieces.  Also notice
# that several pieces may be in the box at the same time, in which
# case they should just be drawn on top of each other.
#
# You can create further data sets, but do not change any of the
# given ones below because they will be used to test your submission.
#
# Most importantly, you must write your own data set at the end
# to provide the correct solution to your puzzle.
#

# The following data set doesn't require drawing any jigsaw pieces
# at all.  You may find it useful as a dummy argument when you
# first start developing your "draw_attempt" function.

attempt_00 = []

# Each of the following data sets put just one piece in the box.
# You may find them useful when creating your individual pieces.

attempt_01 = [['Piece A', 'In box']]
attempt_02 = [['Piece B', 'In box']]
attempt_03 = [['Piece C', 'In box']]
attempt_04 = [['Piece D', 'In box']]

# Each of the following data sets put just one piece in a
# location in the template.

attempt_05 = [['Piece A', 'Top left']]
attempt_06 = [['Piece B', 'Bottom right']]
attempt_07 = [['Piece C', 'Top right']]
attempt_08 = [['Piece D', 'Bottom left']]
attempt_09 = [['Piece A', 'Bottom left']]
attempt_10 = [['Piece B', 'Top left']]
attempt_11 = [['Piece C', 'Bottom right']]
attempt_12 = [['Piece D', 'Top right']]

# Each of the following data sets put all four pieces in the
# box, but in different orders.

attempt_13 = [['Piece A', 'In box'], ['Piece B', 'In box'],
              ['Piece C', 'In box'], ['Piece D', 'In box']]
attempt_14 = [['Piece D', 'In box'], ['Piece C', 'In box'],
              ['Piece B', 'In box'], ['Piece A', 'In box']]
attempt_15 = [['Piece C', 'In box'], ['Piece D', 'In box'],
              ['Piece A', 'In box'], ['Piece B', 'In box']]

# Each of the following data sets uses between two and four pieces,
# either in the template or in the box

attempt_16 = [['Piece A', 'Top right'], ['Piece B', 'Bottom left']]
attempt_17 = [['Piece D', 'Bottom right'], ['Piece C', 'In box']]
attempt_18 = [['Piece C', 'Bottom right'], ['Piece A', 'Bottom right']]
attempt_19 = [['Piece B', 'In box'], ['Piece D', 'Top left'],
              ['Piece C', 'In box']]
attempt_20 = [['Piece C', 'Top left'], ['Piece D', 'Top right'],
              ['Piece A', 'Bottom left']]
attempt_21 = [['Piece A', 'In box'], ['Piece D', 'Bottom left'],
              ['Piece C', 'Top right']]
attempt_22 = [['Piece A', 'Bottom left'], ['Piece B', 'Top right'],
              ['Piece C', 'Bottom right'], ['Piece D', 'In box']]
attempt_23 = [['Piece D', 'Bottom right'], ['Piece C', 'In box'],
              ['Piece B', 'Top right'], ['Piece A', 'Top left']]
attempt_24 = [['Piece C', 'Bottom right'], ['Piece D', 'Top left'],
              ['Piece A', 'In box'], ['Piece B', 'In box']]
attempt_25 = [['Piece D', 'Bottom left'], ['Piece B', 'In box'],
              ['Piece C', 'Bottom right'], ['Piece A', 'Top right']]
attempt_26 = [['Piece C', 'Bottom left'], ['Piece B', 'In box'],
              ['Piece A', 'Bottom right'], ['Piece D', 'Top right']]
attempt_27 = [['Piece C', 'Bottom left'], ['Piece D', 'In box'],
              ['Piece A', 'Top left'], ['Piece B', 'Top right']]

# Each of the following data sets is a complete attempt at solving
# the puzzle using all four pieces (so there are no pieces left in the box)

attempt_28 = [['Piece A', 'Bottom left'], ['Piece B', 'Bottom right'],
              ['Piece C', 'Top left'], ['Piece D', 'Top right']]
attempt_29 = [['Piece A', 'Top right'], ['Piece B', 'Bottom right'],
              ['Piece C', 'Top left'], ['Piece D', 'Bottom left']]
attempt_30 = [['Piece A', 'Bottom left'], ['Piece B', 'Top left', 'X'],
              ['Piece C', 'Bottom right'], ['Piece D', 'Top right']]
attempt_31 = [['Piece A', 'Bottom right'], ['Piece B', 'Top right'],
              ['Piece C', 'Bottom left', 'X'], ['Piece D', 'Top left']]
attempt_32 = [['Piece D', 'Top right', 'X'], ['Piece A', 'Bottom left', 'X'],
              ['Piece B', 'Top left'], ['Piece C', 'Bottom right']]
attempt_33 = [['Piece A', 'Top right', 'X'], ['Piece B', 'Bottom right'],
              ['Piece C', 'Top left'], ['Piece D', 'Bottom left', 'X']]

# Here you must provide a list which is the correct solution to
# your puzzle.

# ***** Put the solution to your puzzle in this list
solution = [] 

#
#--------------------------------------------------------------------#

#-------Function for pieces------------------------------------------#
#Piece A
from turtle import *
def pieceA(xcor,ycor):
    penup()
    goto(xcor,ycor)
    pendown()
    pensize(1)
    #drawing the outside puzzle and colouring it red
    begin_fill()
    fillcolor('red')
    setheading(0)
    forward(125)
    left(90)
    forward(20)
    right(90)
    forward(50)
    right(90)
    forward(20)
    left(90)
    forward(125)
    left(90)
    forward(125)
    right(90)
    forward(20)
    left(90)
    forward(50)
    left(90)
    forward(20)
    right(90)
    forward(125)
    left(90)
    forward(300)
    left(90)
    forward(300)
    left(90)
    end_fill()

    begin_fill
    fillcolor('red')
    forward(60)
    pensize(5)
    left(90)
    forward(60)
    setheading(330)
    forward(77)
    setheading(150)
    forward(77)
    setheading(100)
    forward(180)
    setheading(0)
    forward(80)
    setheading(15)
    forward(140)
    setheading(0)
    forward(55)
    end_fill()
    penup()
    setheading(270)
    forward(60)
    pendown()
    begin_fill()
    fillcolor('black')
    setheading(185)
    forward(80)
    setheading(330)
    forward(100)
    setheading(30)
    forward(18)
    setheading(90)
    forward(7)
    setheading(180)
    forward(21)
    setheading(90)
    forward(40)
    end_fill()
    penup()
    setheading(180)
    forward(23)
    setheading(270)
    forward(100)
    setheading(0)
    forward(20)
    pendown()
    setheading(155)
    forward(200)
    setheading(90)
    forward(40)
    penup()
    setheading(270)
    forward(80)
    setheading(180)
    forward(30)
    pendown()
    #added pensize
    pensize(20)
    setheading(340)
    forward(140)
    penup()
    setheading(270)
    forward(50)
    setheading(160)
    pendown()
    forward(145)
    setheading(340)
    penup()
    forward(150)
    setheading(270)
    forward(40)
    #added pensize
    pensize(5)
    pendown()
    begin_fill()
    setheading(180)
    forward(45)
    setheading(270)
    forward(15)
    setheading(0)
    forward(80)
    setheading(90)
    forward(15)
    setheading(180)
    forward(35)
    end_fill()
    setheading(0)
    forward(35)
    setheading(90)
    forward(115)
    penup()

#Piece B
def pieceB(xcor,ycor):
    goto(xcor,ycor)
    pendown()
    pensize(1)
    begin_fill()
    fillcolor('red')
    #Making puzzle piece
    setheading(0)
    forward(125)
    left(90)
    forward(20)
    right(90)
    forward(50)
    right(90)
    forward(20)
    left(90)
    forward(125)
    left(90)
    forward(300)
    left(90)
    forward(300)
    setheading(270)
    forward(125)
    left(90)
    forward(20)
    right(90)
    forward(50)
    setheading(180)
    forward(20)
    setheading(270)
    forward(125)
    end_fill()

    #doing outside of logo
    penup()
    pensize(5)
    setheading(0)
    forward(240)
    pendown()
    setheading(90)
    forward(60)
    setheading(210)
    forward(77)
    setheading(30)
    forward(77)
    setheading(80)
    forward(180)
    setheading(180)
    forward(80)
    setheading(165)
    forward(140)
    setheading(180)
    forward(55)
    penup()
    setheading(270)
    forward(60)
    pendown()
    begin_fill()
    fillcolor('black')
    setheading(355)
    forward(80)
    setheading(210)
    forward(70)
    setheading(180)
    forward(20)
    setheading(90)
    forward(40)
    end_fill()
    penup()
    setheading(270)
    forward(100)
    pendown()
    setheading(25)
    forward(200)
    setheading(90)
    forward(40)
    penup()
    setheading(270)
    forward(80)
    setheading(0)
    forward(30)
    pendown()
    pensize(20)
    setheading(200)
    forward(140)
    penup()
    setheading(270)
    forward(50)
    pendown()
    setheading(20)
    forward(140)
    penup()
    setheading(200)
    forward(140)
    setheading(270)
    forward(40)
    pensize(5)
    pendown()
    begin_fill()
    setheading(0)
    forward(45)
    setheading(270)
    forward(15)
    setheading(180)
    forward(80)
    setheading(90)
    forward(15)
    end_fill()
    setheading(0)
    forward(35)
    setheading(180)
    forward(35)
    setheading(90)
    forward(115)
    penup()
    hideturtle()

#piece C
def pieceC(xcor,ycor):
    goto(xcor,ycor)
    setheading(0)
    pendown()
    pensize(1)
    fillcolor('red')
    begin_fill()
    forward(300)
    left(90)
    forward(125)
    right(90)
    forward(20)
    left(90)
    forward(50)
    left(90)
    forward(20)
    right(90)
    forward(125)
    left(90)
    forward(125)
    right(90)
    forward(20)
    left(90)
    forward(50)
    left(90)
    forward(20)
    right(90)
    forward(125)
    left(90)
    forward(300)
    end_fill()

    setheading(90)
    forward(300)
    right(90)
    forward(60)
    setheading(270)
    pensize(5)
    forward(200)
    setheading(340)
    forward(200)
    setheading(0)
    forward(50)
    setheading(180)
    forward(50)
    setheading(75)
    forward(80)
    setheading(0)
    forward(30)
    setheading(90)
    penup()
    forward(20)
    setheading(0)
    forward(20)
    setheading(180)
    pendown()
    forward(62)
    setheading(90)
    forward(170)
    setheading(270)
    forward(30)
    setheading(200)
    forward(80)
    setheading(270)
    forward(180)
    setheading(90)
    forward(180)
    setheading(150)
    fillcolor('black')
    begin_fill()
    forward(62)
    setheading(90)
    forward(45)
    setheading(0)
    forward(50)
    setheading(270)
    forward(20)
    setheading(0)
    forward(75)
    setheading(270)
    forward(33)
    end_fill()
    penup()

#piece D
def pieceD(xcor,ycor):
    goto(xcor,ycor)
    setheading(0)
    pendown()
    pensize(1)
    begin_fill()
    fillcolor('red')
    forward(300)
    left(90)
    forward(300)
    left(90)
    forward(125)
    setheading(90)
    forward(20)
    left(90)
    forward(50)
    left(90)
    forward(20)
    right(90)
    forward(125)
    setheading(270)
    forward(125)
    setheading(0)
    forward(20)
    setheading(270)
    forward(50)
    right(90)
    forward(20)
    left(90)
    forward(125)
    end_fill()

    penup()
    setheading(90)
    forward(300)
    right(90)
    forward(240)
    setheading(270)
    pendown()
    pensize(5)
    forward(200)
    setheading(200)
    forward(200)
    setheading(180)
    forward(50)
    setheading(0)
    forward(50)
    setheading(105)
    forward(80)
    setheading(180)
    forward(30)
    setheading(90)
    penup()
    forward(20)
    setheading(0)
    forward(20)
    pendown()
    forward(22)
    setheading(90)
    forward(170)
    setheading(270)
    forward(30)
    setheading(340)
    forward(80)
    setheading(270)
    forward(180)
    setheading(90)
    forward(180)
    setheading(30)
    fillcolor('black')
    begin_fill()
    forward(62)
    setheading(90)
    forward(45)
    setheading(180)
    forward(50)
    setheading(270)
    forward(20)
    setheading(180)
    forward(75)
    setheading(270)
    forward(33)
    end_fill()


#-----Student's Solution---------------------------------------------#
#
#  Complete the assignment by replacing the dummy function below with
#  your own "draw_attempt" function.
#

# Draw the jigsaw pieces as per the provided data set
def draw_attempt(attempt):
    if 'In box':
        xcor=250
        ycor=-100
    elif 'Top right':
        xcor=300
        ycor=0
    elif 'Top left':
        xcor=-600
        ycor=0
    elif 'Bot left':
        xcor=-600
        ycor=-300
    elif 'Bot right':
        xcor=-300
        ycor=-300
    if 'Piece A':
        pieceA(xcor, ycor)
    elif 'Piece B':
        pieceB(xcor, ycor)
    elif 'Piece C':
        pieceC(xcor, ycor)
    elif 'Piece D':
        pieceD(xcor, ycor)

#
#--------------------------------------------------------------------#



#-----Main Program---------------------------------------------------#
#
# This main program sets up the background, ready for you to start
# drawing your jigsaw pieces.  Do not change any of this code except
# where indicated by comments marked '*****'.
#
    
# Set up the drawing canvas
setup(canvas_width, canvas_height)

# Give the canvas a neutral background colour
# ***** You can change the background colour if necessary to ensure
# ***** good contrast with your puzzle pieces
bgcolor('light grey')

# Give the window a title
# ***** Replace this title with one that describes the picture
# ***** produced by solving your puzzle
title('Four Piece Jigsaw Puzzle - Describe your picture here')

# Control the drawing speed
# ***** Modify the following argument if you want to adjust
# ***** the drawing speed
speed('fastest')

# Decide whether or not to show the drawing being done step-by-step
# ***** Set the following argument to False if you don't want to wait
# ***** while the cursor moves around the screen
tracer(True)

# Draw the box that holds unused jigsaw puzzle pieces
draw_box()

# Draw the template that holds the jigsaw pieces
# ***** If you don't want to display the template change the
# ***** argument below to False
draw_template(True)

# Mark the centres of the places where jigsaw puzzle pieces must
# be drawn
# ***** If you don't want to display the coordinates change the
# ***** argument below to False
mark_coords(True)

# Call the student's function to display the attempted solution
# ***** Change the argument to this function to test your
# ***** code with different data sets
draw_attempt(attempt_00)

# Exit gracefully by hiding the cursor and releasing the window
tracer(True)
hideturtle()
done()

#
#--------------------------------------------------------------------#

