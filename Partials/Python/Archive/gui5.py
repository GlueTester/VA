from tkinter import *
from tkinter import ttk

root = Tk()

content = ttk.Frame(root, padding=(3,3,12,12))
namelbl = ttk.Label(content, text="Name")
name = ttk.Entry(content)
root_width= 500
root_height= 500
notebook = ttk.Notebook(root, padding=3,width=root_width , height=root_height)
#notebook.pack(pady=0, expand=True)

Frame_MainTab = ttk.Frame(notebook)#, width=width, height=height)
Frame_DetectiveTab = ttk.Frame(notebook)#, width=width, height=height)

# add frames to notebook

notebook.add(Frame_MainTab, text='Main')
notebook.add(Frame_DetectiveTab, text='Detective')

#Main Frame
global v
v = StringVar()
FullSystemName_label = Label(Frame_MainTab, text='Full Name:',font=("Times New Roman", 10))   
FullSystemName_label.grid(row=2, column=0, sticky="w")
FullSystemName_text = Label(Frame_MainTab, textvariable = v,bg="cornflowerblue", fg="white" , font=("Times New Roman", 10))
FullSystemName_text.grid(row=2, column=1, sticky="w")

global b
b = StringVar()
Ping_label = Label(Frame_MainTab, text='System reply: ',font=("Times New Roman", 10))   
Ping_label.grid(row=3, column=0, sticky="w")
Ping_text = Label(Frame_MainTab, textvariable = b , bg="cornflowerblue", fg="white" , font=("Times New Roman", 10))
Ping_text.grid(row=3, column=1, sticky="w")

global c
c = StringVar()
Location_label = Label(Frame_MainTab, text='Location of system: ',font=("Times New Roman", 10))   
Location_label.grid(row=4, column=0, sticky="w")
Location_text = Label(Frame_MainTab, textvariable = c , bg="cornflowerblue", fg="white" , font=("Times New Roman", 10))
Location_text.grid(row=4, column=1, sticky="w")

global d
d = StringVar()
Location_label = Label(Frame_MainTab, text='Test to detectiv tab: ',font=("Times New Roman", 10))   
Location_label.grid(row=5, column=0, sticky="w")
Location_text = Label(Frame_MainTab, textvariable = d , bg="cornflowerblue", fg="white" , font=("Times New Roman", 10))
Location_text.grid(row=5, column=1, sticky="w")









onevar = BooleanVar()
twovar = BooleanVar()
threevar = BooleanVar()

onevar.set(True)
twovar.set(False)
threevar.set(True)

one = ttk.Checkbutton(content, text="One", variable=onevar, onvalue=True)
two = ttk.Checkbutton(content, text="Two", variable=twovar, onvalue=True)
three = ttk.Checkbutton(content, text="Three", variable=threevar, onvalue=True)
ok = ttk.Button(content, text="Okay")
cancel = ttk.Button(content, text="Cancel")

content.grid(column=0, row=0, sticky=(N, S, E, W))
notebook.grid(column=0, row=0, columnspan=3, rowspan=3, sticky=(N, S, E, W))
namelbl.grid(column=3, row=0, columnspan=2, sticky=(N, W), padx=5)
name.grid(column=3, row=1, columnspan=2, sticky=(N,E,W), pady=5, padx=5)
one.grid(column=0, row=3)
two.grid(column=1, row=3)
three.grid(column=2, row=3)
ok.grid(column=3, row=3)
cancel.grid(column=4, row=3)
#notebook.grid(column=0, row=5)

root.columnconfigure(0, weight=1)
root.rowconfigure(0, weight=1)
content.columnconfigure(0, weight=3)
content.columnconfigure(1, weight=3)
content.columnconfigure(2, weight=3)
content.columnconfigure(3, weight=1)
content.columnconfigure(4, weight=1)
content.rowconfigure(1, weight=1)

root.mainloop()