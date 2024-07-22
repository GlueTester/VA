import tkinter
import tkinter.messagebox
import customtkinter  #if not found - type  "pip3 install customtkinter"
import GUI_functions
import time
import subprocess, sys
import os
from datetime import datetime
import socket #to get Hostname of machine running program

#from dotenv import load_dotenv, set_key, get_key#pip3 install python-dotenv

program_name = "EZAdmin (Working title)"
version="0.2"
edition="Cherry Pie"
last_update= "19 JULY 2024"
#psfunctions = 'C:\\Users\\VHALEXKingR1\\GIT\\VA\\Partials\\Python\\GUI\\psfunctions.ps1'
psfunctions = '//v09.med.va.gov/LEX/Service/IMS/Software/Snakeking/psfunctions.ps1'  #Source: https://stackoverflow.com/questions/7169845/using-python-how-can-i-access-a-shared-folder-on-windows-network
now = datetime.now()
timestamp = now.strftime('%H:%M:%S')
jumpserver = "VHALEXMUL01A"

customtkinter.set_appearance_mode("System")  # Modes: "System" (standard), "Dark", "Light"
customtkinter.set_default_color_theme("blue")  # Themes: "blue" (standard), "green", "dark-blue"

class App(customtkinter.CTk):
    admincheck = GUI_functions.has_admin()
    #print(f"{admincheck[1]}")
    def __init__(self):
        super().__init__()

        # configure window
        self.title(f"{program_name} - {version}")
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
        self.entry = customtkinter.CTkEntry(self, placeholder_text="Enter EE",validate='all', validatecommand=(GUI_functions.callback, '%P'))
        self.entry.grid(row=4, column=1 , padx=(20, 0), pady=(20, 10), sticky="sew")
        self.entry.bind("<Return>", self.return_pressed)
        self.main_button_1 = customtkinter.CTkButton(master=self, text="Search", fg_color="transparent", border_width=2,text_color=("gray10", "#DCE4EE"),command=self.searchclick)
        self.main_button_1.grid(row=4, column=2, padx=(20, 20), pady=(20, 10), sticky="sew")

        # create Logbox
        self.logbox = customtkinter.CTkTextbox(self, width=250, height=150)
        self.logbox.grid(row=3, column=1,columnspan=2, padx=(10, 10), pady=(20, 0), sticky="sew")

        # create tabview
        self.tabview = customtkinter.CTkTabview(self, width=250,height=470,corner_radius=25)
        self.tabview.grid(row=0,rowspan=3, column=1,columnspan=2, padx=(0, 0), pady=(10, 0), sticky="nsew")
        self.tabview.add("Computer")
        self.tabview.add("User")
        self.tabview.add("Printer")
        self.tabview.add("Vista")
        self.tabview.add("Network Hunt")
        self.tabview.tab("Computer").grid_columnconfigure(1, weight=1)  # configure grid of individual tabs
        self.tabview.tab("User").grid_columnconfigure(1, weight=1)
        self.tabview.tab("Printer").grid_columnconfigure(1, weight=1)
        self.tabview.tab("Vista").grid_columnconfigure(1, weight=1)
        self.tabview.tab("Network Hunt").grid_columnconfigure(1, weight=1)



        # create tabview2
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
       
       
        ####+++++++++++++++++++++++++++++++++++++++
        #Info Tab
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
       
        self.OULabel = customtkinter.CTkLabel(self.tabview2.tab("Info"), text="OU: ", font=customtkinter.CTkFont(size=15))
        self.OULabel.grid(row=0, column=0, padx=(45,0), pady=(150,0))
        
        #Create scrollabel frame fro OUT lenght      #Source: https://github.com/TomSchimansky/CustomTkinter/wiki/CTkScrollableFrame
        self.ou_scrollframe = customtkinter.CTkScrollableFrame(self.tabview2.tab("Info"), width=5, height=20,orientation="horizontal")
        self.ou_scrollframe.grid(row=0, column=1, padx=(0,0), pady=(150,0),sticky="nw")
        self.OUtext = customtkinter.CTkLabel(self.ou_scrollframe, text="", justify="left")
        self.OUtext.grid(row=0, column=0, columnspan=3, padx=(0,0), pady=(0,0), sticky="nw")

        self.extendedsearch_button = customtkinter.CTkButton(self.tabview2.tab("Info"), command=self.extendedsearch_button_event,fg_color="transparent")
        self.extendedsearch_button.grid(row=3, column=3, padx=(0,0), pady=(0,0))


        #+++++++++++++++++++++++++++++++++++++++++++++++++
        #Software Insatll Tab    
        self.Software_Combo1Label = customtkinter.CTkLabel(self.tabview2.tab("Software Install"), text="Software: ", font=customtkinter.CTkFont(size=15))
        self.Software_Combo1Label.grid(row=0, column=0, padx=(0,0), pady=(0,0),sticky="E")
        self.Software_Combo1menu_1 = customtkinter.CTkComboBox(self.tabview2.tab("Software Install"), values=["","Priv Plus","Vista Imaging"])
        self.Software_Combo1menu_1.grid(row=0, column=1, padx=0, pady=(0, 0),sticky="w")

        self.Software_Combo2Label = customtkinter.CTkLabel(self.tabview2.tab("Software Install"), text="Drivers: ", font=customtkinter.CTkFont(size=15))
        self.Software_Combo2Label.grid(row=0, column=0, padx=(0,0), pady=(60,0), sticky="E")
        self.Software_Combo1menu_2 = customtkinter.CTkComboBox(self.tabview2.tab("Software Install"), values=["", "Fujitsu Scanner", "Display Link"])
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



        # set default values
        self.sidebar_button_1.configure(state="enabled", text="Button 1")
        self.sidebar_button_2.configure(state="enabled", text="Button 2")
        self.sidebar_button_3.configure(state="disabled", text="Disabled Button")
        self.extendedsearch_button.configure(state="disabled", text="")
        self.appearance_mode_optionemenu.set("Dark")
        self.scaling_optionemenu.set("100%")
        
        if self.admincheck[1] == False: 
            self.SpecailtySearch.configure(state="disabled", text="Run as admin to enable")
            self.Software_Search.configure(state="disabled", text="Run as admin to enable")
        self.tabview2._segmented_button._buttons_dict["Magic Fix"].configure(state="disabled")     
        self.logbox.insert("0.0", "Log Box\n\n" )#+ "This is an output.\n\n")

        

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

    def extendedsearch_button_event(self):
        
        self.logbox.insert('end', f"{timestamp}    {program_name} - Extended search started on {Hostname} \n")
        self.extendedsearch_button.configure(state="disabled", fg_color="transparent",text="")
        self.logbox.see("end")

        def ADsearch(Stat):
            proc = subprocess.Popen(["powershell.exe", f"Import-Module {psfunctions}; Get_PCInfo {Hostname} {Stat}"], stdout=subprocess.PIPE)
            try:
                outs, errs = proc.communicate(timeout=15)
                global out
                out = outs.decode("utf-8").strip("b'.\r\n'") # convert outs from "bytes" to a "string" , then strips the trash from begin and end of output    
                #EditLabel
            except subprocess.TimeoutExpired:
                proc.kill()
                outs, errs = proc.communicate()   
            #self.logbox.insert('end', f"{Hostname} location: {out}  \n") #place info in Log box
        
        ADsearch("DistinguishedName | Select-Object -ExpandProperty DistinguishedName")
        self.OUtext.configure(text=out)
        self.logbox.insert('end', f"{timestamp}    {Hostname} - AD Location: {out}  \n") #place info in Log box
        self.logbox.see("end")

        ADsearch("Enabled | Select-Object -ExpandProperty Enabled")
        if out == "True": #if the out variabel has a value then is true
            self.EnabledText.configure(text=out,text_color="green")
        elif out == "False":
            self.EnabledText.configure(text=out,text_color="red")
        else:
            self.EnabledText.configure(text="Not in AD",text_color="red")
        self.logbox.insert('end', f"{timestamp}    {Hostname}  - Enabled: {out}  \n") #place info in Log box
        self.logbox.see("end")
        
    def return_pressed(self, event):
        self.searchclick()
        self.logbox.see("end")

    def clearthefield(self):
        self.StatusText.configure(text="")
        self.HostnameText.configure(text="")
        self.OUtext.configure(text="")
        self.StatusText.configure(text="")
        self.EnabledText.configure(text="")
        self.logbox.see("end")

    def searchclick(self):
        self.clearthefield()
        global Hostname
        searchfieldinput = self.entry.get()
        if not searchfieldinput :  #Source: https://stackoverflow.com/questions/10545385/how-to-check-if-a-variable-is-empty-in-python
            self.logbox.insert('end', f"{timestamp}    {program_name} - Please input an EE to start \n")
        else:
            Hostname = GUI_functions.EEtoHostname(searchfieldinput)
            self.logbox.insert('end', f"{timestamp}    {program_name} - Searched for EE {searchfieldinput} \n")
            if Hostname or Hostname == 0:
                self.logbox.insert('end', f"{timestamp}    {program_name} - Found {Hostname} \n")
                self.HostnameText.configure(text=Hostname)   

                self.logbox.insert('end', f"{timestamp}    {program_name} - Checking if {Hostname} is Online \n")
                pingreply = GUI_functions.ping(Hostname)
                #self.logbox.insert('end', f"{timestamp}|"Got - {pingreply} \n")
                
                if pingreply == "Offline":
                    self.StatusText.configure(text="Offline", text_color="red")  
                    self.logbox.insert('end', f"{timestamp}    {program_name} - {Hostname} is Offline \n")

                else:
                    self.StatusText.configure(text="Online", text_color="green")
                    self.logbox.insert('end', f"{timestamp}    {program_name} - {Hostname} is Online \n") 
                    self.extendedsearch_button.configure(state="enabled", text="Extended Search",fg_color=self.sidebar_button_1._fg_color, text_color="white" )
                    self.IPText.configure(text=pingreply)
                    
                    
                #self.logbox.insert('end', f"{Hostname} location: {out}  \n") #place info in Log box
                if self.admincheck: #ensure admincheck has a value
                    if self.admincheck == True: #ensure vaule is True aka admin
                        pcrunningscript = socket.gethostname()
                        if  pcrunningscript == jumpserver:
                            vlanname = GUI_functions.VlanLookup(pingreply)
                            self.logbox.insert('end', f"{timestamp}    {program_name} - vlan name:{vlanname} \n")
                            self.LocationText.configure(text={vlanname})
                        else:
                            self.logbox.insert('end', f"{timestamp}    {program_name} - You will need to be on {jumpserver} to know locations. You are on {pcrunningscript} \n")
                    elif self.admincheck[1] == False:
                        self.logbox.insert('end', f"{timestamp}    {program_name} - Not running as admin. Running {program_name} as:{self.admincheck[0]} \n")
                        self.LocationText.configure(text="Run as admin to enable")
                #self.LocationText.configure(text=vlanname)
            else :
                self.logbox.insert('end', f"{timestamp}    {program_name} - No Machine Found matching {searchfieldinput} \n")
        
            self.logbox.see("end")
            #self.sidebar_info.delete("0.0", "end")  # delete all text

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

#if '_PYIBoot_SPLASH' in os.environ and importlib.util.find_spec("pyi_splash"):  #Source https://stackoverflow.com/questions/48315785/pyinstaller-adding-splash-screen-or-visual-feedback-during-file-extraction
#    import pyi_splash
#    pyi_splash.update_text('UI Loaded ...')
#    pyi_splash.close()
#    print.info('Splash screen closed.')

if __name__ == "__main__":
    app = App()
    app.mainloop()