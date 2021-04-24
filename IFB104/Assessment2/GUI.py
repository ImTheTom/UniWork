from Tkinter import *
from ttk import Progressbar
gui=Tk()
gui.title('Assesment two, n9702351')

worldvar=BooleanVar()
entertainmentvar=BooleanVar()
techvar=BooleanVar()
politicsvar=BooleanVar()
strangevar=BooleanVar()
ukvar=BooleanVar()

def get_variables():
    worldnews=worldvar.get()
    if worldnews==True:
        print 'yes'
    else:
        print 'no'
    entertainmentnews=entertainmentvar.get()
    if entertainmentnews==True:
        print 'yes'
    else:
        print 'no'
    technews=techvar.get()
    if technews==True:
        print 'yes'
    else:
        print 'no'
    politicsnews=politicsvar.get()
    if politicsnews==True:
        print 'yes'
    else:
        print 'no'
    strangenews=strangevar.get()
    if strangenews==True:
        print 'yes'
    else:
        print 'no'
    uknews=ukvar.get()
    if uknews==True:
        print 'yes'
    else:
        print 'no'


#part 1
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

# part 2
confirm=Label(gui, text = 'Confirm your selection',font = ('Arial', 15, 'bold'))
confirm.grid(row=5, column=1, columnspan = 2)
confirm=Button(gui, text = 'Confirm', font=('Arial', 12), bd=5, bg='blue', activebackground='blue', activeforeground='white', fg='white', command=get_variables)
confirm.grid(row=6, column=1, columnspan=2)

# Part 3
wait=Label(gui, text = 'Wait for the proram to load',font = ('Arial', 15, 'bold'))
wait.grid(row=7, column=1, columnspan = 2)
ready= Button(gui, text = 'NOT READY', font=('Arial', 12), bd=5, bg='red', activebackground='green', activeforeground='white', fg='white', state=DISABLED)
ready.grid(row=8, column=1, columnspan=2)

# Part 4
opens=Label(gui, text = 'When complete, press the button below to open', font = ('Arial', 15, 'bold'))
opens.grid(row=9, column=1, columnspan=2)
opend=Button(gui, text = 'Open', font=('Arial', 12), bd=5, bg='blue', activebackground='blue', activeforeground='white', fg='white')
opend.grid(row=10, column=1, columnspan=2)

gui.mainloop()
