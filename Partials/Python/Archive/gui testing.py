from tkinter import *
import tkinter as tk
from tkinter import ttk

def donothing():
   x = 0

version = "  (version:"+"0.01)"

# Section: (Root Window aka GUI)
# Description: The parameters of the size  title ico etc of the GUIs root window
# Source: 
# Note: I broke the width and height into separate variables to be able to reference them individually in the notebook sizing

root = tk.Tk()

#Size
root_width = 800
root_height = 500
root_size = str(root_width) + "x" + str(root_height) 

#Center Root window in center of screen
# get the screen dimension
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()
# find the center point
center_x = int(screen_width/2 - root_width / 2)
center_y = int(screen_height/2 - root_height / 2)
root.geometry(f'{root_width}x{root_height}+{center_x}+{center_y}')
#root.resizable(False, False)

# Title text
title_text = 'Reactor'
#Tried to get the version on right (not working)
    #dead_space = int(root_width) - len(version) - len(title_text) #take length of version text and subtract it from overall length of window. This is to gte it all the way to the right
    #test = ' ' * dead_space #https://stackoverflow.com/questions/12450704/how-to-print-spaces-in-python  
root.title('Reactor' + version)
root.iconphoto(False, PhotoImage(file = 'R.png'))

# Section: (Menubar)
# Description: Menubar for File, help etc at top of GUI
# Source: https://pythonspot.com/tk-menubar/

menubar = Menu(root)
filemenu = Menu(menubar, tearoff=0)
filemenu.add_command(label="New", command=donothing)
filemenu.add_command(label="Open", command=donothing)
filemenu.add_command(label="Save", command=donothing)
filemenu.add_separator()
filemenu.add_command(label="Exit", command=root.quit)
menubar.add_cascade(label="File", menu=filemenu)

helpmenu = Menu(menubar, tearoff=0)
helpmenu.add_command(label="Help Index", command=donothing)
helpmenu.add_command(label="About...", command=donothing)
menubar.add_cascade(label="Help", menu=helpmenu)

root.config(menu=menubar)


# Section (Computer Bar)
# Description: 
# SOURCE:

def only_numbers(char):
    return char.isdigit()
validation = root.register(only_numbers)

#frame1 = ttk.LabelFrame(root, text='Alignment')
#frame1.grid(column=0, row=0, padx=20, pady=20)

#alignment_var = tk.StringVar()
#alignments = ('Left', 'Center', 'Right')

frame1 = ttk.Frame(root, width=200, height=150)
frame1.pack(fill='both', expand=True)

Label(frame1, text="Enter Name").pack()
EE_entry = Entry(frame1 , width = 12, validate='key',  validatecommand=(validation, '%S'))
#EE_entry.place(x = 5 , y = 5 , height = 20)
#EE_entry.pack()





# Section (Noteboook)
# Description: The Tabs under the menubar: Main Detective ...ect  
# SOURCE:https://www.pythontutorial.net/tkinter/tkinter-notebook/

notebook = ttk.Notebook(root)
notebook.pack(pady=30, expand=True)


frame2 = ttk.Frame(notebook, width=root_width, height=root_height)
frame3 = ttk.Frame(notebook, width=root_width, height=root_height)


frame2.pack(fill='both', expand=True)
frame3.pack(fill='both', expand=True)


# add frames to notebook

notebook.add(frame2, text='Main')
notebook.add(frame3, text='Detective')





#####################################################END###############################

root.mainloop()