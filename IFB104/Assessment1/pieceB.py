from turtle import *
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

