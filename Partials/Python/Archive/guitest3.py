from tkinter import *
import tkinter as tk
from tkinter import ttk
import pyad.adquery #requiers pyad , pywin32
#rom pypsrp.powershell import PowerShell, RunspacePool  #pip3 install pysrp
#from pypsrp.wsman import WSMan  #pip3 install wsman

def callback(input):
    if input.isdigit():
        print(input)
        return True
                        
    elif input == "":
        print(input)
        return True

    else:
        print(input)
        return False
    

#Determin OS
def OS_Type():
    import sys
    if sys.platform == 'linux':
        os_type = 'Linux'
    elif sys.platform == 'win32':
        os_type = 'Windows'
    elif sys.platform == 'cygwin':
        os_type = 'Windows/Cygwin'
    elif sys.platform == 'darwin':
        os_type = 'Mac OS X'
    else:
        os_type = "Unknown"

#Not sure why thsi is here
def donothing():
   x = 0

#Enter PS-Session to PC and find info
def PCInfo():
    #print("made it to PCINFO")
    PingStatus = "This is where Ping status shows ONLINE/Offline"
    print (PingStatus)
    b.set(PingStatus)
    return PingStatus
    #b.set(FullSystemName)

#Resolve the EE to computer name using AD query
def ResolveEE():
    v.set("Could not find Computer in AD")
    b.set("")
    c.set("")
    q = pyad.adquery.ADQuery()
    EE= str(userinput_EE.get())
    #Source https://pypi.org/project/pyad/
    q.execute_query(
    attributes = ["SamAccountName", "distinguishedName", "Name" ,"description"],
    where_clause = "objectClass = 'Computer'",
    base_dn = "OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
    #base_dn = "OU=Windows 10,OU=Laptops, OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
    )

    for row in q.get_results():
        if EE in (row["Name"] ):
            FullSystemName = (row["Name"])
            print ("found system " + FullSystemName)
            v.set(FullSystemName)
            PCInfo()
            Location()
            return FullSystemName

def Location():
    location = "Function in development" 
    print(location)
    c.set(location)
#def about():

version = "0.01"

# Section: (Root Window aka GUI)
# Description: The parameters of the size  title ico etc of the GUIs root window
# Source: 
# Note: I broke the width and height into separate variables to be able to reference them individually in the notebook sizing

#GUI Creation

root = tk.Tk() # parent window 
width,height=800,600
v_dim=str(width)+'x'+str(height)

#Center Root window in center of screen

# get the screen dimension
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()
# find the center point
center_x = int(screen_width/2 - width / 2)
center_y = int(screen_height/2 - height / 2)
root.geometry(v_dim)  # Size of the window 
root.geometry(f'{width}x{height}+{center_x}+{center_y}')
root.minsize(280, 180) # (minimum ) Width  , ( minimum ) height
root.maxsize(1200,1200)  # (maximum ) width , ( maximum) height
root.title('Reactor')
root.iconphoto(False, PhotoImage(file = 'R.png'))

#Bind enter to start resolve PC name
def func(event):
    ResolveEE()
    #Source https://stackoverflow.com/questions/16996432/how-do-i-bind-the-enter-key-to-a-function-in-tkinter
root.bind('<Return>', func)

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



quickaccess_frame = Frame(root, bg='purple', width=width, height=10, pady=3)
SystemSearch_frame = Frame(root, bg='cyan', width=width, height=10, pady=3)
center_frame = Frame(root, bg='pink', width=width, height=40, padx=3, pady=3)
info_frame = Frame(root, bg='white', width=width, height=55, pady=3)
btm_frame = Frame(root, bg='lavender', width=width, height=20, pady=3)

# layout all of the main containers
#root.grid_rowconfigure(5, weight=1)
root.grid_columnconfigure(0, weight=1)



quickaccess_frame.grid(column= 0, row=0, sticky ="ew")
SystemSearch_frame.grid(row=1, sticky ="ew")
center_frame.grid(row=2, sticky ="nsew") #nsew will center text in all directions
info_frame.grid(row=3, sticky ="ew")
btm_frame.grid(row=4, sticky ="ew")

#SystemSearchToolbar = Menu(SystemSearch_frame)
validation = root.register(callback) #recives pass from EE entry and send to callback for veification
userinput_EE = IntVar()
EE_label = Label(SystemSearch_frame, text='System EE:')   
EE_entry = Entry(SystemSearch_frame, background="white" , width = 12, validate='key',  validatecommand=(validation, '%S'), textvariable=userinput_EE)
Search_button = Button(SystemSearch_frame, width = 10,text="Search", command= ResolveEE) #Label(top_frame, text='Length:')
#root.config(toolbar=SystemSearchToolbar)


#QuickAccessMenubar = Menu(quickaccess_frame)
Quickactions_label = Label(quickaccess_frame, text='Quick Acions Bar holder')

#validation = root.register(callback) #recives pass from EE entry and send to callback for veification
    # create the widgets for the top frame
#userinput_EE = IntVar()
#Quickactions_label = Label(top_frame, text='Quick Acions Bar holder')
#EE_label = Label(top_frame, text='System EE:')   
#EE_entry = Entry(top_frame, background="white" , width = 12, validate='key',  validatecommand=(validation, '%S'), textvariable=userinput_EE)
#Search_button = Button(top_frame, width = 10,text="Search", command= ResolveEE) #Label(top_frame, text='Length:')


#,validate='key',  validatecommand=(validation, '%S')

# create the widgets for the Bottom fram
Version_label = Label(btm_frame, text='Version: ' + version)

# layout the widgets in the top frame
Quickactions_label.grid(row=0, columnspan=3)
EE_label.grid(row=0, column=0)
Search_button.grid(row=0, column=3)
EE_entry.grid(row=0, column=1, padx=5)

# layout the widgets in the Bottom frame
Version_label.grid(row=0, sticky="e")



#frame1 = ttk.LabelFrame(root, text='Alignment')
#frame1.grid(column=0, row=0, padx=20, pady=20)

#alignment_var = tk.StringVar()
#alignments = ('Left', 'Center', 'Right')

#frame1 = ttk.Frame(root, width=200, height=150)
#frame1.pack(fill='both', expand=True)

#Label(frame1, text="Enter Name").pack()
    #EE_entry = Entry(top_frame , width = 12, validate='key',  validatecommand=(validation, '%S'))
#EE_entry.place(x = 5 , y = 5 , height = 20)
#EE_entry.pack()





# Section (Noteboook)
# Description: The Tabs under the menubar: Main Detective ...ect  
# SOURCE:https://www.pythontutorial.net/tkinter/tkinter-notebook/

notebook = ttk.Notebook(center_frame, padding=3)#width=root_width , height=root_height)
notebook.pack(pady=0, expand=True)


Frame_MainTab = ttk.Frame(notebook, width=width, height=height)
Frame_DetectiveTab = ttk.Frame(notebook, width=width, height=height)


Frame_MainTab.pack(fill='both', expand=True)
Frame_DetectiveTab.pack(fill='both', expand=True)


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
Location_label = Label(Frame_DetectiveTab, text='Test to detectiv tab: ',font=("Times New Roman", 10))   
Location_label.grid(row=5, column=0, sticky="w")
Location_text = Label(Frame_DetectiveTab, textvariable = d , bg="cornflowerblue", fg="white" , font=("Times New Roman", 10))
Location_text.grid(row=5, column=1, sticky="w")




#####################################################END###############################

root.mainloop()