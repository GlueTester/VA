import tkinter
import tkinter.messagebox
import customtkinter  #if not found - type  "pip3 install customtkinter"
import GUI_functions
#import "GUI_psfunctions.ps1"
import time
import subprocess, sys
import os

#import datetime
#from dotenv import load_dotenv, set_key, get_key#pip3 install python-dotenv

program_name = "EZAdmin (Working title)"
version="0.2"
edition="Cherry Pie"
last_update= "17 JULY 2024"
psfunctions = "S:\IMS\Software\Snakeking\psfunctions.ps1"

global tab1, tab2, tab3, tab4, tab5
#tab1_name="Computer"
#tab2_name="User"
#button3_name="Printer"
#tab4_name="Vista"
#tab5_name="Network Hunt"

customtkinter.set_appearance_mode("System")  # Modes: "System" (standard), "Dark", "Light"
customtkinter.set_default_color_theme("blue")  # Themes: "blue" (standard), "green", "dark-blue"


class App(customtkinter.CTk):
    class button1_tab_names:
        tab1_name="Info"
        tab2_name="Software Install"
        tab3_name="Driver Install"
        tab4_name="Control"
        tab5_name="tab5"

    class button2_tab_names:
        tab1_name="Computer2"
        tab2_name="User2"
        tab3_name="Printer2"
        tab4_name="Vista2"
        tab5_name="Network Hunt2"

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
        self.logo_label = customtkinter.CTkLabel(self.sidebar_frame, text="Sections", font=customtkinter.CTkFont(size=20, weight="bold"))
        self.logo_label.grid(row=0, column=0, padx=20, pady=(20, 10))
        self.sidebar_button_1 = customtkinter.CTkButton(self.sidebar_frame, command=self.sidebar_button1_event)
        self.sidebar_button_1.grid(row=1, column=0, padx=20, pady=10)
        self.sidebar_button_2 = customtkinter.CTkButton(self.sidebar_frame, command=self.sidebar_button2_event)
        self.sidebar_button_2.grid(row=2, column=0, padx=20, pady=10)
        self.sidebar_button_3 = customtkinter.CTkButton(self.sidebar_frame, command=self.sidebar_button3_event)
        self.sidebar_button_3.grid(row=3, column=0, padx=20, pady=10)
        self.sidebar_button_4 = customtkinter.CTkButton(self.sidebar_frame, command=self.sidebar_button4_event)
        self.sidebar_button_4.grid(row=4, column=0, padx=20, pady=10)
        #create info box in sidebar
        #self.sidebar_info = customtkinter.CTkTextbox(self.sidebar_frame)
        #self.sidebar_info.grid(row=4, column=0, padx=20, pady=10)
        #self.sidebar_info.configure(state="disabled", fg_color="transparent") 
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
        self.entry = customtkinter.CTkEntry(self, placeholder_text="Enter EE")
        self.entry.grid(row=4, column=1 , padx=(20, 0), pady=(20, 10), sticky="sew")
        self.entry.bind("<Return>", self.return_pressed)
        self.main_button_1 = customtkinter.CTkButton(master=self, text="Search", fg_color="transparent", border_width=2,text_color=("gray10", "#DCE4EE"),command=self.searchclick)
        self.main_button_1.grid(row=4, column=2, padx=(20, 20), pady=(20, 10), sticky="sew")

        # create Logbox
        self.logbox = customtkinter.CTkTextbox(self, width=250, height=150)
        self.logbox.grid(row=3, column=1,columnspan=2, padx=(10, 10), pady=(20, 0), sticky="nsew")

        #master tab view
        self.main_tabmenu = customtkinter.CTkTabview(self, width=250)#,corner_radius=25)
        self.main_tabmenu.grid(row=0,rowspan=2, column=1,columnspan=2, padx=(10, 10), pady=(10, 0), sticky="nswe")
        self.main_tabmenu.add("test1")
        self.main_tabmenu.add("test2")
        self.main_tabmenu.add("test3")
        self.main_tabmenu.add("test4")
        self.main_tabmenu.add("test5")
        self.main_tabmenu.tab("test1").grid_columnconfigure(1, weight=1)  # configure grid of individual tabs
        self.main_tabmenu.tab("test2").grid_columnconfigure(1, weight=1)
        self.main_tabmenu.tab("test3").grid_columnconfigure(1, weight=1)
        self.main_tabmenu.tab("test4").grid_columnconfigure(1, weight=1)
        self.main_tabmenu.tab("test5").grid_columnconfigure(1, weight=1)

        # create tabview
        self.sub_tabmenu = customtkinter.CTkTabview(self.main_tabmenu, width=150)#,corner_radius=25)
        self.sub_tabmenu.grid(row=0, column=0, padx=(10, 10), pady=(10, 0), sticky="nsew")
        self.sub_tabmenu.add(self.button1_tab_names.tab1_name)
        self.sub_tabmenu.add(self.button1_tab_names.tab2_name)
        self.sub_tabmenu.add(self.button1_tab_names.tab3_name)
        self.sub_tabmenu.add(self.button1_tab_names.tab4_name)
        self.sub_tabmenu.add(self.button1_tab_names.tab5_name)
        self.sub_tabmenu.tab(self.button1_tab_names.tab1_name).grid_columnconfigure(1, weight=2)  # configure grid of individual tabs
        self.sub_tabmenu.tab(self.button1_tab_names.tab2_name).grid_columnconfigure(1, weight=2)
        self.sub_tabmenu.tab(self.button1_tab_names.tab3_name).grid_columnconfigure(1, weight=2)
        self.sub_tabmenu.tab(self.button1_tab_names.tab4_name).grid_columnconfigure(1, weight=2)
        self.sub_tabmenu.tab(self.button1_tab_names.tab5_name).grid_columnconfigure(1, weight=2)



        # create tabview2
        #self.tabview2 = customtkinter.CTkTabview(self.tabview.tab(self.tab_name.tab1_name), width=350,height=470,corner_radius=25)
        #self.tabview2.grid(row=0,rowspan=3, column=0,columnspan=3, padx=(10, 10), pady=(10, 0), sticky="nswe")
        #self.tabview2.add("Info")
        #self.tabview2.add("Software Install")
        #self.tabview2.add("Drivers Install")
        #self.tabview2.add("Control")
        #self.tabview2.tab("Info").grid_columnconfigure(1, weight=1)  # configure grid of individual tabs
        #self.tabview2.tab("Software Install").grid_columnconfigure(1, weight=1)
        #self.tabview2.tab("Drivers Install").grid_columnconfigure(2, weight=1)
        #self.tabview2.tab("Control").grid_columnconfigure(1, weight=1)
       
        self.HostnameLabel = customtkinter.CTkLabel(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), text="Hostname: ", font=customtkinter.CTkFont(size=15))
        self.HostnameLabel.grid(row=0, column=0, padx=(0,0), pady=(0,0))
        self.HostnameText = customtkinter.CTkLabel(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), text="" , justify="left")
        self.HostnameText.grid(row=0, column=1, padx=(0,0), pady=(0,0), sticky="w")

        self.OnlineLabel = customtkinter.CTkLabel(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), text="Status: ", font=customtkinter.CTkFont(size=15))
        self.OnlineLabel.grid(row=0, column=0, padx=(25,0), pady=(45,0))
        self.StatusText = customtkinter.CTkLabel(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), text="" , justify="left")
        self.StatusText.grid(row=0, column=1, padx=(0,0), pady=(45,0), sticky="w")

       

        self.OULabel = customtkinter.CTkLabel(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), text="OU: ", font=customtkinter.CTkFont(size=15))
        self.OULabel.grid(row=0, column=0, padx=(45,0), pady=(100,0))
         #Create scrollabel frame fro OUT lenght
            #Source: https://github.com/TomSchimansky/CustomTkinter/wiki/CTkScrollableFrame
        self.ou_scrollframe = customtkinter.CTkScrollableFrame(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), width=5, height=20,orientation="horizontal")
        self.ou_scrollframe.grid(row=0, column=1, padx=(0,0), pady=(100,0),sticky="w")
        self.OUtext = customtkinter.CTkLabel(self.ou_scrollframe, text="", justify="left")
        self.OUtext.grid(row=0, column=0, columnspan=3, padx=(0,0), pady=(0,0), sticky="w")

        self.EnabledLabel = customtkinter.CTkLabel(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), text="Enabled: ", font=customtkinter.CTkFont(size=15))
        self.EnabledLabel.grid(row=0, column=0, padx=(10,0), pady=(175,0))
        self.EnabledText = customtkinter.CTkLabel(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), text="", justify="left")
        self.EnabledText.grid(row=0, column=1, columnspan=3, padx=(0,0), pady=(175,0), sticky="w")

        self.UserLabel = customtkinter.CTkLabel(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), text="Logged On: ", font=customtkinter.CTkFont(size=15))
        self.UserLabel.grid(row=0, column=0, padx=(0,0), pady=(220,0))
        self.UserText = customtkinter.CTkLabel(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), text="", justify="left")
        self.UserText.grid(row=0, column=1, columnspan=3, padx=(0,0), pady=(220,0), sticky="w")

       
        self.extendedsearch_button = customtkinter.CTkButton(self.sub_tabmenu.tab(self.button1_tab_names.tab1_name), command=self.extendedsearch_button_event,fg_color="transparent")
        self.extendedsearch_button.grid(row=3, column=3, padx=(0,0), pady=(0,0))

        #self.optionmenu_1 = customtkinter.CTkOptionMenu(self.tabview.tab("Computer"), dynamic_resizing=False,
        #                                                values=["Value 1", "Value 2", "Value Long Long Long"])
        #self.optionmenu_1.grid(row=0, column=3, padx=20, pady=(20, 10))
        #self.combobox_1 = customtkinter.CTkComboBox(self.tabview.tab("Computer"),
        #                                            values=["Value 1", "Value 2", "Value Long....."])
        #self.combobox_1.grid(row=1, column=2, padx=20, pady=(10, 10))
        #self.string_input_button = customtkinter.CTkButton(self.tabview.tab("Computer"), text="Start Here",
        #                                                   command=self.open_input_dialog_event)
        #self.string_input_button.grid(row=2, column=1, padx=20, pady=(10, 10))
        #self.label_tab_2 = customtkinter.CTkLabel(self.tabview.tab("User"), text="Computer on Tab 2")
        #self.label_tab_2.grid(row=0, column=0, padx=20, pady=20)

        # create slider and progressbar frame
        #self.slider_progressbar_frame = customtkinter.CTkFrame(self, fg_color="transparent")
        #self.slider_progressbar_frame.grid(row=1, column=1, padx=(20, 0), pady=(20, 0), sticky="nsew")
        #self.slider_progressbar_frame.grid_columnconfigure(0, weight=1)
        #self.slider_progressbar_frame.grid_rowconfigure(4, weight=1)
        #self.seg_button_1 = customtkinter.CTkSegmentedButton(self.slider_progressbar_frame)
        #self.seg_button_1.grid(row=0, column=0, padx=(20, 10), pady=(10, 10), sticky="ew")
        #self.progressbar_2 = customtkinter.CTkProgressBar(self.slider_progressbar_frame)
        #self.progressbar_2.grid(row=2, column=0, padx=(20, 10), pady=(10, 10), sticky="ew")
        #self.slider_1 = customtkinter.CTkSlider(self.slider_progressbar_frame, from_=0, to=1, number_of_steps=4)
        #self.slider_1.grid(row=3, column=0, padx=(20, 10), pady=(10, 10), sticky="ew")
        #self.slider_2 = customtkinter.CTkSlider(self.slider_progressbar_frame, orientation="vertical")
        #self.slider_2.grid(row=0, column=1, rowspan=5, padx=(10, 10), pady=(10, 10), sticky="ns")
        #self.progressbar_3 = customtkinter.CTkProgressBar(self.slider_progressbar_frame, orientation="vertical")
        #self.progressbar_3.grid(row=0, column=2, rowspan=5, padx=(10, 20), pady=(10, 10), sticky="ns")

        # create scrollable frame
        #self.scrollable_frame = customtkinter.CTkScrollableFrame(self, label_text="Custom Search Options")
        #self.scrollable_frame.grid(row=1, column=3, padx=(0, 20), pady=(20, 0), sticky="nsew")
        #self.scrollable_frame.grid_columnconfigure(0, weight=1)
        #self.scrollable_frame_switches = []
        
        
        
        #new below
    
        # create textbox
        #self.PCtextbox = customtkinter.CTkTextbox(self, width=250)
        #self.PCtextbox.grid(row=0, column=1, padx=(20, 0), pady=(20, 0), sticky="nsew")
        
        #switch = customtkinter.CTkSwitch(master=self.scrollable_frame, text=f"Extended Search")
        #switch.grid(row=1, column=0, padx=10, pady=(0, 20))
        #self.scrollable_frame_switches.append(switch)
        #for i in range(100):
        #    switch = customtkinter.CTkSwitch(master=self.scrollable_frame, text=f"CTkSwitch {i}")
        #    switch.grid(row=i, column=0, padx=10, pady=(0, 20))
        #    self.scrollable_frame_switches.append(switch)

        # create checkbox and switch frame
        #self.checkbox_slider_frame = customtkinter.CTkFrame(self)
        #self.checkbox_slider_frame.grid(row=1, column=2, padx=(20, 20), pady=(20, 0), sticky="nsew")
        #self.checkbox_1 = customtkinter.CTkCheckBox(master=self.checkbox_slider_frame)
        #self.checkbox_1.grid(row=1, column=0, pady=(20, 0), padx=20, sticky="n")
        #self.checkbox_2 = customtkinter.CTkCheckBox(master=self.checkbox_slider_frame)
        #self.checkbox_2.grid(row=2, column=0, pady=(20, 0), padx=20, sticky="n")
        #self.checkbox_3 = customtkinter.CTkCheckBox(master=self.checkbox_slider_frame)
        #self.checkbox_3.grid(row=3, column=0, pady=20, padx=20, sticky="n")

        # set default values
        self.sidebar_button_1.configure(state="enabled", text="Computers")
        self.sidebar_button_2.configure(state="enabled", text="User")
        self.sidebar_button_3.configure(state="enabled", text="Printer")
        self.sidebar_button_4.configure(state="enabled", text="Vista")
        self.extendedsearch_button.configure(state="disabled", text="")
        #self.checkbox_3.configure(state="disabled")
        #self.checkbox_1.select()
        #self.scrollable_frame_switches[0].select()
        #self.scrollable_frame_switches[4].select()
        self.appearance_mode_optionemenu.set("Dark")
        self.scaling_optionemenu.set("100%")
        #self.optionmenu_1.set("CTkOptionmenu")
        #self.combobox_1.set("CTkComboBox")
        #self.slider_1.configure(command=self.progressbar_2.set)
        #self.slider_2.configure(command=self.progressbar_3.set)
 
        
        
        self.logbox.insert("0.0", "Log Box\n\n" )#+ "This is an output.\n\n")
        #self.seg_button_1.configure(values=["CTkSegmentedButton", "Value 2", "Value 3"])
        #self.seg_button_1.set("Value 2")

    def open_input_dialog_event(self):
        dialog = customtkinter.CTkInputDialog(text="Type in an EE number:", title="EE number to search for")
        print("InputDialog:", dialog.get_input())

    def change_appearance_mode_event(self, new_appearance_mode: str):
        customtkinter.set_appearance_mode(new_appearance_mode)

    def change_scaling_event(self, new_scaling: str):
        new_scaling_float = int(new_scaling.replace("%", "")) / 100
        customtkinter.set_widget_scaling(new_scaling_float)


    def rename_tab(self, old_tabname, new_tabname):
        #dialog = customtkinter.CTkInputDialog(text="What is the tab name?", title="Rename tab")
        self.sub_tabmenu._segmented_button._buttons_dict[old_tabname].configure(text=new_tabname)


    def sidebar_button1_event(self):

        self.sub_tabmenu.cget(self.sub_tabmenu)
        self.rename_tab(self.button1_tab_names.tab1_name, self.button1_tab_names.tab1_name)
        self.rename_tab(self.button1_tab_names.tab2_name, self.button1_tab_names.tab2_name)
        self.rename_tab(self.button1_tab_names.tab3_name, self.button1_tab_names.tab3_name)
        self.rename_tab(self.button1_tab_names.tab4_name, self.button1_tab_names.tab4_name)
        self.rename_tab(self.button1_tab_names.tab5_name, self.button1_tab_names.tab5_name)
            
    def sidebar_button2_event(self):

        self.rename_tab(self.sub_tabmenu.tab1, self.button2_tab_names.tab1_name)
        self.rename_tab(self.button2_tab_names.tab2_name, self.button2_tab_names.tab2_name)
        self.rename_tab(self.button2_tab_names.tab3_name, self.button2_tab_names.tab3_name)
        self.rename_tab(self.button2_tab_names.tab4_name, self.button2_tab_names.tab4_name)
        self.rename_tab(self.button2_tab_names.tab5_name, self.button2_tab_names.tab5_name)

    def sidebar_button3_event(self):
        self.rename_tab(self.button3_tab_names.tab1_name, self.button3_tab_names.tab1_name)
        self.rename_tab(self.button3_tab_names.tab2_name, self.button3_tab_names.tab2_name)
        self.rename_tab(self.button3_tab_names.tab3_name, self.button3_tab_names.tab3_name)
        self.rename_tab(self.button3_tab_names.tab4_name, self.button3_tab_names.tab4_name)
        self.rename_tab(self.button3_tab_names.tab5_name, self.button3_tab_names.tab5_name)

    def sidebar_button4_event(self):
        self.rename_tab(self.button4_tab_names.tab1_name, self.button4_tab_names.tab1_name)
        self.rename_tab(self.button4_tab_names.tab2_name, self.button4_tab_names.tab2_name)
        self.rename_tab(self.button4_tab_names.tab3_name, self.button4_tab_names.tab3_name)
        self.rename_tab(self.button4_tab_names.tab4_name, self.button4_tab_names.tab4_name)
        self.rename_tab(self.button4_tab_names.tab5_name, self.button4_tab_names.tab5_name)   

        #self.tabview.index(self.tabview.select())
        #self.tabview.tab(self.tabview.select(), "text")

    def sidebar_Computerbutton_event(self):
        self.rename_tab("Computer", "New Computer")
        print("sidebar_button click")
        #self.tabview.tab(self.tabview.select(), "text")

    def extendedsearch_button_event(self):
        
        self.logbox.insert('end', f"{program_name} - Extended search started on {Hostname} \n")
        self.extendedsearch_button.configure(state="disabled", fg_color="transparent",text="")
        self.logbox.see("end")

        def ADsearch(Stat):
            proc = subprocess.Popen(["powershell.exe", f"Import-Module {psfunctions}; Get_PCInfo {Hostname} {Stat}"], stdout=subprocess.PIPE)
            try:
                outs, errs = proc.communicate(timeout=15)
                global out
                out = outs.decode("utf-8").strip("b'.\r\n'") # covnert outs from "bytes" to a "string" , then strips the trash from begin and end of output    
                #EditLabel
            except subprocess.TimeoutExpired:
                proc.kill()
                outs, errs = proc.communicate()   
            #self.logbox.insert('end', f"{Hostname} location: {out}  \n") #place info in Log box
        
        ADsearch("DistinguishedName | Select-Object -ExpandProperty DistinguishedName")
        self.OUtext.configure(text=out)
        self.logbox.insert('end', f"{Hostname} - AD Location: {out}  \n") #place info in Log box
        self.logbox.see("end")

        ADsearch("Enabled | Select-Object -ExpandProperty Enabled")
        if out == "True": #if the out variabel has a value then is true
            self.EnabledText.configure(text=out,text_color="green")
        elif out == "False":
            self.EnabledText.configure(text=out,text_color="red")
        else:
            self.EnabledText.configure(text="Not in AD",text_color="red")
        self.logbox.insert('end', f"{Hostname}  - Enabled: {out}  \n") #place info in Log box
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
        searchfieldinput = self.entry.get()
        global Hostname
        Hostname = GUI_functions.EEtoHostname(searchfieldinput)
        self.logbox.insert('end', f"{program_name} - Searched for EE {searchfieldinput} \n")
        if Hostname != "None":
            self.logbox.insert('end', f"{program_name} - Found {Hostname} \n")
            self.HostnameText.configure(text=Hostname)   

            self.logbox.insert('end', f"{program_name} - Checking if {Hostname} is Online \n")
            pingreply = GUI_functions.ping(Hostname)
            if pingreply > 0:
                self.StatusText.configure(text="Online", text_color="green")
                self.logbox.insert('end', f"{program_name} - {Hostname} is Online \n") 
                self.extendedsearch_button.configure(state="enabled", text="Extended Search",fg_color=self.sidebar_button_1._fg_color, text_color="white" )
            else:
                self.StatusText.configure(text="Offline", text_color="red")  
                self.logbox.insert('end', f"{program_name} - {Hostname} is Offline \n") 
        else :
            self.logbox.insert('end', f"{program_name} - No Machine Found matching {searchfieldinput} \n")
        self.logbox.see("end")
        #self.sidebar_info.delete("0.0", "end")  # delete all text

if __name__ == "__main__":
    app = App()
    app.mainloop()