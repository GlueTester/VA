import tkinter
#import tkinter.messagebox
import customtkinter
import GUI_functions
import time
import subprocess, sys
import os
from datetime import datetime
import socket #to get Hostname of machine running program
import ctypes 
import glob #for file search
import numbers #to see if numbers
import json

#prereq installs
    #pip3 install python-dotenv
    #pip3 install customtkinter
    #pip3 install python-dotenv
    #pip3 install pypiwin32
    #pip3 install Selenium #https://trm.oit.va.gov/ToolPage.aspx?tid=6440#
    #pip3 install selenium webdriver-manager

var_json = "//v09.med.va.gov/LEX/Service/IMS/Software/AdminTool/var.json"


#Create empty arrays
software_variables, drivers_variables, software_names, driver_names = ([] for i in range(4))

with open(var_json) as jsonFile:
    data = json.load(jsonFile)
    for result in data['GUIParms']:
        a = json.dumps( result, indent=4)
        gui_variables = json.loads(a)
    for result in data['Software']:
        software_variables.append(result)
    for result in data['Drivers']:
        drivers_variables.append(result)

    #Extract all enabled software titles from json and place into new array for combobox
for i in range(len(software_variables)):
    if software_variables[i]["State"] == "enabled":
        software_names.append(software_variables[i]["Name"])

    #Extract all enabled driver titles from json and place into new array for combobox
for i in range(len(drivers_variables)):
    if drivers_variables[i]["State"] == "enabled":
        driver_names.append(drivers_variables[i]["Name"])



program_name = gui_variables["program_name"]
current_version = gui_variables["current_version"]
edition = gui_variables["edition"]
last_update = gui_variables["last_update"]
psfunctions = gui_variables["psfunctions"] #Source: https://stackoverflow.com/questions/7169845/using-python-how-can-i-access-a-shared-folder-on-windows-network
now = eval(gui_variables["now"])
timestamp = eval(gui_variables["timestamp"])
jumpserver = gui_variables["jumpserver"]
logoffdir = gui_variables["log_off_dir"]
deadday = gui_variables["dead_day"]
currentday = eval(gui_variables["currentday"])
program_version = 0.2
logbox_input_blank_error = gui_variables["logbox_input_blank_error"]
inputbox_click_blank = gui_variables["inputbox_click_blank"]
first_log_msg = gui_variables["first_log_msg"]




#Ensure the version being ran is the current one, currently only by date
if eval(gui_variables["date_compare"]):
    ctypes.windll.user32.MessageBoxW(0, gui_variables["old_date_title"], gui_variables["old_date_message"], 0) #Source: https://stackoverflow.com/questions/2963263/how-can-i-create-a-simple-message-box-in-python
    exit()

if eval(gui_variables["version_compare"]):
    ctypes.windll.user32.MessageBoxW(0, gui_variables["old_version_title"], gui_variables['old_version_message'], 0) #Source: https://stackoverflow.com/questions/2963263/how-can-i-create-a-simple-message-box-in-python
    exit()


customtkinter.set_appearance_mode("System")  # Modes: "System" (standard), "Dark", "Light"
customtkinter.set_default_color_theme("blue")  # Themes: "blue" (standard), "green", "dark-blue"

class App(customtkinter.CTk):
    admincheck = GUI_functions.has_admin() #see if running as admin
    def __init__(self):
        super().__init__()

        # Title change based on version of program compared to current
        if float(current_version) == float(program_version): #if version is the same
            report_version = {gui_variables["current_version"]}
        elif float(current_version) > float(program_version): #if program is older than current
            report_version = (f"You are running version {program_version}, please upgrade to {gui_variables["current_version"]}")

        self.title(f"{program_name} - {report_version}")
        self.geometry(f"{1100}x{800}")

        # configure grid layout (4x4)
        self.grid_columnconfigure(1, weight=1)
        self.grid_columnconfigure((2, 3), weight=0)
        self.grid_rowconfigure((0, 1, 2), weight=1)
        #self.grid_rowconfigure(3, weight=1)

        # create sidebar frame with widgets
        self.sidebar_frame = customtkinter.CTkFrame(self, width=140, corner_radius=35)
        self.sidebar_frame.grid(row=0, column=0, rowspan=4, padx=5, pady=(25, 0), sticky="nsew")
        self.sidebar_frame.grid_rowconfigure(4, weight=1)
        self.logo_label = customtkinter.CTkLabel(self.sidebar_frame, text="Programs", font=customtkinter.CTkFont(size=20, weight="bold"))
        self.logo_label.grid(row=0, column=0, padx=20, pady=(20, 10))
        self.sidebar_button_1 = customtkinter.CTkButton(self.sidebar_frame, command=self.sidebar_button_event)
        self.sidebar_button_1.grid(row=1, column=0, padx=20, pady=10)
        self.sidebar_button_2 = customtkinter.CTkButton(self.sidebar_frame, command=self.sidebar_button_event)
        self.sidebar_button_2.grid(row=2, column=0, padx=20, pady=10)
        self.sidebar_button_3 = customtkinter.CTkButton(self.sidebar_frame, command=self.sidebar_button_event)
        self.sidebar_button_3.grid(row=3, column=0, padx=20, pady=10)

        #contue with witdges
        self.appearance_mode_label = customtkinter.CTkLabel(self.sidebar_frame, text="Appearance Mode:", anchor="w")
        self.appearance_mode_label.grid(row=5, column=0, padx=20, pady=(10, 0))
        self.appearance_mode_optionemenu = customtkinter.CTkOptionMenu(self.sidebar_frame, values=["Light", "Dark", "System"],
                                                                       command=self.change_appearance_mode_event)
        self.appearance_mode_optionemenu.grid(row=6, column=0, padx=20, pady=(10, 10))
        self.scaling_label = customtkinter.CTkLabel(self.sidebar_frame, text="UI Scaling:", anchor="w")
        self.scaling_label.grid(row=7, column=0, padx=20, pady=(10, 0))
        self.scaling_optionemenu = customtkinter.CTkOptionMenu(self.sidebar_frame, values=["80%", "90%", "100%", "110%", "120%"],
                                                               command=self.change_scaling_event)
        self.scaling_optionemenu.grid(row=8, column=0, padx=20, pady=(10, 20))

        # create main entry and button
        self.entry = customtkinter.CTkEntry(self, placeholder_text = inputbox_click_blank ,  validatecommand=(GUI_functions.callback, '%P'),width=250)
        self.entry.grid(row=4, column=1 , padx=(20, 0), pady=(20, 10), sticky="sw")
        self.entry.bind("<Return>", self.return_pressed) #Allows ENTER key to start search
        self.main_button_1 = customtkinter.CTkButton(master=self, text="Search", fg_color="transparent", border_width=2,text_color=("gray10", "#DCE4EE"),command=self.searchclick)
        self.main_button_1.grid(row=4, column=1, padx=(275, 20), pady=(20, 10), sticky="sw")
       

        #Create Extended Search Button
        Hostname="none"
        self.extendedsearch_button = customtkinter.CTkButton(master=self,state="disabled",text="", fg_color="transparent",command=self.extendedsearch_button_event)
        self.extendedsearch_button.grid(row=4, column=1, padx=(450,20), pady=(20,10), sticky="sw")

        # create Logbox
        self.logbox = customtkinter.CTkTextbox(self, width=250, height=150)
        self.logbox.grid(row=3, column=1,columnspan=2, padx=(10, 10), pady=(20, 0), sticky="sew")






        # create tabview for main
        self.tabview = customtkinter.CTkTabview(self, width=250,height=470,corner_radius=25)
        self.tabview.grid(row=0,rowspan=3, column=1,columnspan=2, padx=(0, 0), pady=(10, 0), sticky="nsew")
        self.tabview.add("Computer")
        self.tabview.add("User")
        self.tabview.add("Printer")
        self.tabview.add("Vista")
        self.tabview.add("Phones")
        self.tabview.add("Network Hunt")
        self.tabview.tab("Computer").grid_columnconfigure(1, weight=1)  # configure grid of individual tabs
        self.tabview.tab("User").grid_columnconfigure(1, weight=1)
        self.tabview.tab("Printer").grid_columnconfigure(1, weight=1)
        self.tabview.tab("Vista").grid_columnconfigure(1, weight=1)
        self.tabview.tab("Phones").grid_columnconfigure(1, weight=1)
        self.tabview.tab("Network Hunt").grid_columnconfigure(1, weight=1)


        # create tabview2 for Computers tab
        self.tabview2 = customtkinter.CTkTabview(self.tabview.tab("Computer"), width=350,height=470,corner_radius=25)
        self.tabview2.grid(row=0,rowspan=3, column=0,columnspan=3, padx=(0, 0), pady=(0, 0), sticky="nwse")
        self.tabview2.add("Info")
        self.tabview2.add("Software Install")
        self.tabview2.add("Specialty Tab")
        self.tabview2.add("Magic Fix")
        self.tabview2.tab("Info").grid_columnconfigure(1, weight=1)  # configure grid of individual tabs
        self.tabview2.tab("Software Install").grid_columnconfigure(1, weight=1)
        self.tabview2.tab("Specialty Tab").grid_columnconfigure(1, weight=1)
        self.tabview2.tab("Magic Fix").grid_columnconfigure(1, weight=1)
       
       
        #+++++++++++++++++++++++++++++++++++++++++++++++++
        #Computer - Info Tab
        self.HostnameLabel = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="Hostname: ", font=customtkinter.CTkFont(size=15))
        self.HostnameLabel.grid(row=0, column=0, padx=(0,0), pady=(0,0),sticky="ne")
        self.HostnameText = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="" , justify="left")
        self.HostnameText.grid(row=0, column=1, padx=(0,0), pady=(0,0), sticky="nw")

        self.OnlineLabel = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="Status: ", font=customtkinter.CTkFont(size=15))
        self.OnlineLabel.grid(row=0, column=0, padx=(0,0), pady=(25,0),sticky="ne")
        self.StatusText = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="" , justify="left")
        self.StatusText.grid(row=0, column=1, padx=(0,0), pady=(25,0), sticky="nw")
        
        self.IPLabel = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="IP: ", font=customtkinter.CTkFont(size=15))
        self.IPLabel.grid(row=0, column=0, padx=(0,0), pady=(50,0), sticky="ne")
        self.IPText = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="" , justify="left")
        self.IPText.grid(row=0, column=1, padx=(0,0), pady=(50,0), sticky="nw")
        
        self.LocationLabel = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="Location: ", font=customtkinter.CTkFont(size=15))
        self.LocationLabel.grid(row=0, column=0, padx=(0,0), pady=(75,0), sticky="ne")
        self.LocationText = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="" , justify="left")
        self.LocationText.grid(row=0, column=1, padx=(0,0), pady=(75,0), sticky="nw")

        self.EnabledLabel = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="Enabled: ", font=customtkinter.CTkFont(size=15))
        self.EnabledLabel.grid(row=0, column=0, padx=(0,0), pady=(100,0), sticky="ne")
        self.EnabledText = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="", justify="left")
        self.EnabledText.grid(row=0, column=1, columnspan=3, padx=(0,0), pady=(100,0), sticky="nw")

        self.UserLabel = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="Logged On: ", font=customtkinter.CTkFont(size=15))
        self.UserLabel.grid(row=0, column=0, padx=(0,0), pady=(125,0),sticky="ne")
        self.UserText = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="", justify="left")
        self.UserText.grid(row=0, column=1, columnspan=3, padx=(0,0), pady=(125,0), sticky="nw")
       
        
        
        #Create scrollabel frame fro OUT lenght      #Source: https://github.com/TomSchimansky/CustomTkinter/wiki/CTkScrollableFrame
        self.ou_scrollframe = customtkinter.CTkScrollableFrame(self.tabview2.tab("Info"), height=20,orientation="horizontal")
        self.ou_scrollframe.grid(row=0, column=1, padx=(0,0), pady=(144,0),sticky="nw")
        self.OULabel = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="OU: ")#, font=customtkinter.CTkFont(size=15))
        self.OULabel.grid(row=0, column=0, padx=(45,0), pady=(150,0),sticky="ne")
        self.OUtext = customtkinter.CTkLabel(self.ou_scrollframe, text="", justify="left")
        self.OUtext.grid(row=0, column=0, columnspan=3, padx=(0,0), pady=(0,0), sticky="nw")

        self.MBSerialLabel = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="System Serial: ", font=customtkinter.CTkFont(size=15))
        self.MBSerialLabel.grid(row=0, column=0, padx=(0,0), pady=(180,0), sticky="ne")
        self.MBSerialText = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="", justify="left")
        self.MBSerialText.grid(row=0, column=1, padx=(0,0), pady=(180,0), sticky="nw")

        self.logstats_button = customtkinter.CTkButton(self.tabview2.tab("Info"), command=self.logstats_button_event,fg_color="transparent")
        self.logstats_button.grid(row=0, column=3, padx=(0,0), pady=(45,0))

        #+++++++++++++++++++++++++++++++++++++++++++++++++
        #Software Insatll Tab    
        self.Software_Combo1Label = customtkinter.CTkLabel(self.tabview2.tab("Software Install"), text="Software: ", font=customtkinter.CTkFont(size=15))
        self.Software_Combo1Label.grid(row=0, column=0, padx=(0,0), pady=(0,0),sticky="E")
        self.Software_Combo1menu_1 = customtkinter.CTkComboBox(self.tabview2.tab("Software Install"), values = software_names)
        self.Software_Combo1menu_1.grid(row=0, column=1, padx=0, pady=(0, 0),sticky="w")


        self.Software_Combo2Label = customtkinter.CTkLabel(self.tabview2.tab("Software Install"), text="Drivers: ", font=customtkinter.CTkFont(size=15))
        self.Software_Combo2Label.grid(row=0, column=0, padx=(0,0), pady=(60,0), sticky="E")
        self.Software_Combo1menu_2 = customtkinter.CTkComboBox(self.tabview2.tab("Software Install"), values = driver_names)
        self.Software_Combo1menu_2.grid(row=0, column=1, padx=(0,0), pady=(60, 00), sticky="w")
        self.Software_Search = customtkinter.CTkButton(self.tabview2.tab("Software Install"), text="Deploy", fg_color="transparent", border_width=2,text_color=("gray10", "#DCE4EE"),command=self.Software_Deploy_Event)
        self.Software_Search.grid(row=2, column=2, padx=(20, 20), pady=(20, 10), sticky="se")
       
        #+++++++++++++++++++++++++++++++++++++++++++++++++
        #Specailty Tab        
        self.Specailty_Combo1Label = customtkinter.CTkLabel(self.tabview2.tab("Specialty Tab"), text="Specailty Images: ", font=customtkinter.CTkFont(size=15))
        self.Specailty_Combo1Label.grid(row=0, column=0, padx=(0,0), pady=(0,0),sticky="E")
        self.Specailty_Combo1menu_1 = customtkinter.CTkComboBox(self.tabview2.tab("Specialty Tab"), values=["","Audiology","BCMA Cart","EDIS Board","Lab","Manikin","PeriOp"])
        self.Specailty_Combo1menu_1.grid(row=0, column=1, padx=0, pady=(0, 0),sticky="w")

        self.Specailty_Combo2Label = customtkinter.CTkLabel(self.tabview2.tab("Specialty Tab"), text="Suboptions: ", font=customtkinter.CTkFont(size=15))
        self.Specailty_Combo2Label.grid(row=0, column=0, padx=(0,0), pady=(60,0), sticky="E")
        self.Specailty_Combo1menu_2 = customtkinter.CTkComboBox(self.tabview2.tab("Specialty Tab"), values=["", "Fujitsu Scanner", "Display Link"], state= "disabled")
        self.Specailty_Combo1menu_2.grid(row=0, column=1, padx=(0,0), pady=(60, 00), sticky="w")

        self.SpecailtySearch = customtkinter.CTkButton(self.tabview2.tab("Specialty Tab"), text="Deploy", fg_color="transparent", border_width=2,text_color=("gray10", "#DCE4EE"),command=self.Specailty_Deploy_Event)
        self.SpecailtySearch.grid(row=2, column=2, padx=(20, 20), pady=(20, 10), sticky="se")


                
        #Login statas button
        #self.logstats_button.configure(state="enabled", text="Open Login stats", fg_color=self.sidebar_button_1._fg_color, text_color="white")
        #self.extendedsearch_button.configure(state="enabled", command=(GUI_functions.extendedsearch_button_event(self, Hostname)))

        # set default values
        self.sidebar_button_1.configure(state="enabled", text="Button 1")
        self.sidebar_button_2.configure(state="enabled", text="Button 2")
        self.sidebar_button_3.configure(state="disabled", text="Disabled Button")
        self.logstats_button.configure(state="disabled", text="")
        self.appearance_mode_optionemenu.set("Dark")
        self.scaling_optionemenu.set("100%")
        
        if self.admincheck[1] == False: 
            self.SpecailtySearch.configure(state="disabled", text="Run as admin to enable")
            self.Software_Search.configure(state="disabled", text="Run as admin to enable")
        self.tabview2._segmented_button._buttons_dict["Magic Fix"].configure(state="disabled")     
        self.logbox.insert("0.0", "Log Box\n\n" )#+ "This is an output.\n\n")
        self.logbox.insert('end', f"{first_log_msg} \n")


        #Set as main focus
        #self.entry.focus_force() 
        self.update() 

    def open_input_dialog_event(self):
        dialog = customtkinter.CTkInputDialog(text="Type in an EE number:", title="EE number to search for")
        print("InputDialog:", dialog.get_input())

    def change_appearance_mode_event(self, new_appearance_mode: str):
        customtkinter.set_appearance_mode(new_appearance_mode)

    def change_scaling_event(self, new_scaling: str):
        new_scaling_float = int(new_scaling.replace("%", "")) / 100
        customtkinter.set_widget_scaling(new_scaling_float)

    def sidebar_button_event(self):
        self.tabview.tab("Computer")
        self.switcher = customtkinter.CTkLabel(self.tabview.tab("Computer"))
        print("sidebar_button click")


    def logstats_button_event(self):
        machinelogpath = (f"{logoffdir}/machinestats/{Hostname}.log")
        subprocess.Popen(["notepad", machinelogpath])   

    def return_pressed(self, event):
        self.searchclick()
        self.logbox.see("end")

    def clearthefield(self):
        self.StatusText.configure(text="", text_color="black")
        self.HostnameText.configure(text="")
        self.OUtext.configure(text="")
        self.StatusText.configure(text="")
        self.IPText.configure(text="")
        self.EnabledText.configure(text="", text_color="black")
        self.LocationText.configure(text="")
        self.MBSerialText.configure(text="")
        self.logbox.see("end")
       
        

    def searchclick(self):
        self.main_button_1.configure(state="disabled",text="Please wait...")
        self.clearthefield()
        self.update()
        global Hostname, searchfieldinput 
        searchfieldinput = self.entry.get()
        if not searchfieldinput :  #Source: https://stackoverflow.com/questions/10545385/how-to-check-if-a-variable-is-empty-in-python
            self.logbox.insert('end', f"{timestamp}    {program_name} - {logbox_input_blank_error} \n")
        else:
            if (searchfieldinput.isdigit()): #https://stackoverflow.com/questions/21388541/how-do-you-check-in-python-whether-a-string-contains-only-numbers
                Hostname = GUI_functions.Search_is_Computer(self, searchfieldinput)
                print (Hostname)
                        #Create Extended Search Button


                

            #Should the entered data NOT be a set of numbers and CONTAIN "VHA" it must be a user name
            elif "VHA" in searchfieldinput.upper(): #converted input ot uppercase 
                self.logbox.insert('end', f"{timestamp}    {program_name} - Searching for a User - {searchfieldinput.upper()}  \n")
                self.tabview.set("User")#change active tab to the "user tab"
            else:
                self.logbox.insert('end', f"{timestamp}    {program_name} - Im not familiar with what you have typed - {program_name} ----{searchfieldinput} \n")

        

        
        self.logbox.see("end")
        #reenable search button
        self.main_button_1.configure(state="enabled",  text="Search", fg_color="transparent", border_width=2,text_color=("gray10", "#DCE4EE"))

    def Specailty_Deploy_Event(self):
        spec_image_type = self.Specailty_Combo1menu_1.get()
        if spec_image_type or spec_image_type==0:
            self.logbox.insert('end', f"{timestamp}    Specailty search pressed, I see you selected:{spec_image_type} \n")
        else:
            self.logbox.insert('end', f"{timestamp}    Please select a image type to start: \n")
        self.logbox.see("end")
    
    def Software_Deploy_Event(self):
        softwarename = self.Software_Combo1menu_1.get()
        if softwarename or softwarename==0:  #Source: https://stackoverflow.com/questions/28210060/check-if-value-is-zero-or-not-null-in-python
            self.logbox.insert('end', f"{timestamp}    Specailty search pressed, I see you selected:{softwarename} \n")
        else:
            self.logbox.insert('end', f"{timestamp}    Please select a software to start: \n")
        self.logbox.see("end")

    def extendedsearch_button_event(self):
        #WE must run this a fundtion in the main, if the command on the button is directed to the GUI functions it exciture without click, always!
        GUI_functions.extendedsearch_button_event(self, Hostname)
   
   
   
   
    #def MotherBoardSerial():
    #    serial = GUI_functions.powercmd(f"MBserial('{Hostname}')")
    #    self.logbox.insert('end', f"{timestamp}    {program_name} - Mahcien Motherboard serial: {serial} \n")
    #    return serial

#if '_PYIBoot_SPLASH' in os.environ and importlib.util.find_spec("pyi_splash"):  #Source https://stackoverflow.com/questions/48315785/pyinstaller-adding-splash-screen-or-visual-feedback-during-file-extraction
#    import pyi_splash
#    pyi_splash.update_text('UI Loaded ...')
#    pyi_splash.close()
#    print.info('Splash screen closed.')

if __name__ == "__main__":
    app = App()
    app.mainloop()