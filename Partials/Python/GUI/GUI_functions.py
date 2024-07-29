import datetime
import subprocess, sys
import os
from dotenv import load_dotenv, set_key, get_key #pip3 install python-dotenv   and pip3 install pypiwin32
import socket
import time
import subprocess, sys
import os
from datetime import datetime
import socket #to get Hostname of machine running program
import json

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
envfile = "C:\\temp\\.env"

#if not os.path.exists(envfile):   #create if not exist https://stackoverflow.com/questions/35807605/create-a-file-if-it-doesnt-exist
#    open(".env", "x") close() # creates the file
if not os.path.exists(envfile):
    open(envfile, 'w')

def has_admin():
    #import os
    if os.name == 'nt':
        try:
            #Source: https://stackoverflow.com/questions/2946746/python-checking-if-a-user-has-administrator-privileges
            # only windows users with admin privileges can read the C:\windows\temp
            temp = os.listdir(os.sep.join([os.environ.get('SystemRoot','C:\\windows'),'temp']))
        except:
            return (os.environ['USERNAME'],False)
        else:
            return (os.environ['USERNAME'],True)
    else:
        if 'SUDO_USER' in os.environ and os.geteuid() == 0:
            return (os.environ['SUDO_USER'],True)
        else:
            return (os.environ['USERNAME'],False)

def  EEtoHostname (EE):
    import pyad.adquery # pip3 install pyad
    q = pyad.adquery.ADQuery()  #pip3 install pypiwin32
    #Source https://pypi.org/project/pyad/
    q.execute_query(
    attributes = ["SamAccountName", "distinguishedName", "Name" ,"description"],
    where_clause = f"objectClass = 'Computer' and Name = 'LEX*{EE}'",
    base_dn = "DC=v09,DC=med,DC=va,DC=gov"
    )
    for row in q.get_results():
        if EE in (row["Name"] ):
            return (row["Name"])
        
def pingback(Hostname):
    ping = subprocess.Popen(
        ["ping", "-n", "1", "-4", Hostname],
        #["ping", "-n", "1", Hostname],
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE
    )
    out, error = ping.communicate()

    packsrecieved = str(out).find("Received = 1")
    ip = (socket.gethostbyname(Hostname))
    return (packsrecieved ,ip)
     
def ping(Hostname):
    try: 
        ip = (socket.gethostbyname(Hostname))
        if ip.startswith ("10.74"):
            return (ip)
        elif ip == "Offline":
            return "Offline"
    except:
        return "Cant get IP of machine"
    else:
        return ("Offline")

def powershellcmd(command):
    now = datetime.datetime.now()
    nowshort = now.strftime('%H%M%S')
    envfile = f"C:\\temp\\.{nowshort}.env"

    if not os.path.exists(envfile):   #create if not exist https://stackoverflow.com/questions/35807605/create-a-file-if-it-doesnt-exist
        open(envfile, "x") # creates the file
    load_dotenv(envfile)

    set_key(dotenv_path=envfile, key_to_set="unique_run", value_to_set=nowshort)

    ps_script = f"""
    $InputVar = ConvertTo-Json $env:unique_run
    $powershell_var = {command}
    echo "OutputVar=`'$powershell_var`' " | out-file -filepath {envfile} -append -Encoding ASCII
    """

    # Run the PowerShell script with the input variable as an environment variable
    #Sources - (https://stackoverflow.com/questions/5971312/how-to-set-environment-variables-in-python) , (https://stackoverflow.com/questions/21944895/running-powershell-script-within-python-script-how-to-make-python-print-the-pow) , (https://www.tutorialspoint.com/how-to-set-environment-variables-using-powershell) , (https://petri.com/powershell-set-environment-variable/#:~:text=To%20add%20an%20environment%20variable,the%20(%2B%3D)%20operator) , (https://stackoverflow.com/questions/30006722/os-environ-not-setting-environment-variables) , (https://stackoverflow.com/questions/5327495/list-all-environment-variables-from-the-command-line)
    result = subprocess.run(["powershell.exe", "-Command", ps_script])#, capture_output=True, text = True)
    
    #Search envfile for new out and make a local variable
    pscmdoutput = get_key(dotenv_path=envfile, key_to_get="OutputVar")
    
    #Clean up
    os.remove(envfile)
    return pscmdoutput

    #USAGE 
    # VARBILBE =  powershellcmd(POWERSHELL COMMAND)
    # Examples
    # pingout = powershellcmd("ping LEX-LT110184")
    # print (f"{pingout}")

def VlanLookup(pingreply):
    #print(F"Ping reply: {pingreply}")
    proc = subprocess.Popen(["powershell.exe", f"Import-Module {psfunctions}; vlanname {str(pingreply)}"], stdout=subprocess.PIPE)
    #print (["powershell.exe", f"Import-Module {psfunctions}; vlanname {str(pingreply)} "])
    try:
        outs, errs = proc.communicate(timeout=15)
        #print(F"Befor decode: {outs}")
        #print(F"pre decode still {str(pingreply)}")
        out = outs.decode("utf-8").strip("b'.\r\n'") # covnert outs from "bytes" to a "string" , then strips the trash from begin and end of output    
       # print(F"After decode: {out}")
        vlanresult = out
        #print(F"results: {vlanresult}")
        return vlanresult
    except subprocess.TimeoutExpired:
        proc.kill()
        outs, errs = proc.communicate()  
    #print(F"Outside try: {outs}")

def powercmd(psdef):
    #print(F"Ping reply: {psdef}")
    proc = subprocess.Popen(["powershell.exe", f"Import-Module {psfunctions}; {psdef}"], stdout=subprocess.PIPE)
    #print (["powershell.exe", f"Import-Module {psfunctions}; vlanname {str(pingreply)} "])
    try:
        outs, errs = proc.communicate(timeout=15)
        #print(F"Befor decode: {outs}")
        #print(F"pre decode still {str(pingreply)}")
        out = outs.decode("utf-8").strip("b'.\r\n'") # covnert outs from "bytes" to a "string" , then strips the trash from begin and end of output    
       # print(F"After decode: {out}")
        vlanresult = out
        #print(F"results: {vlanresult}")
        return vlanresult
    except subprocess.TimeoutExpired:
        proc.kill()
        outs, errs = proc.communicate()  
    #print(F"Outside try: {outs}")

def callback(self, P):
    if str.isdigit(P) or str(P) == "":
        return True
    else:
        return False
    
def MotherBoardSerial(Hostname):
    serial = powercmd(f"MBserial('{Hostname}')")
    #self.logbox.insert('end', f"{timestamp}    {program_name} - Mahcien Motherboard serial: {serial} \n")
    return serial

def Search_is_Computer(self, searchfieldinput):
    self.tabview.set("Computer")#change active tab to the "user tab"
    self.update()
    Hostname = EEtoHostname(searchfieldinput)
    self.logbox.insert('end', f"{timestamp}    {program_name} - Searched for {searchfieldinput} \n")
    if Hostname or Hostname == 0:
        self.logbox.insert('end', f"{timestamp}    {program_name} - Found {Hostname} \n")
        self.HostnameText.configure(text=Hostname)   


        self.logbox.insert('end', f"{timestamp}    {program_name} - Checking if {Hostname} is Online \n")
        pingreply = ping(Hostname)
        
        if pingreply == "Offline":
            self.StatusText.configure(text="Offline", text_color="red")  
            self.logbox.insert('end', f"{timestamp}    {program_name} - {Hostname} is Offline \n")

        elif (pingreply == "Cant get IP of machine"):
            self.StatusText.configure(text="Offline", text_color="red")  
            self.logbox.insert('end', f"{timestamp}    {program_name} - {Hostname} is Offline \n")

        else:
            self.StatusText.configure(text="Online", text_color="green")
            self.logbox.insert('end', f"{timestamp}    {program_name} - {Hostname} is Online \n") 
            self.IPText.configure(text=pingreply)
            if self.admincheck[1] == True: #ensure vaule is True aka admin
                pcrunningscript = socket.gethostname()
                if  pcrunningscript == jumpserver:
                    self.MBSerialText.configure(text=MotherBoardSerial(Hostname))
            elif self.admincheck[1] == False:
                self.MBSerialText.configure(text="Run as admin to enable")
            else:
                self.logbox.insert('end', f"{timestamp}    {program_name} - Not running as admin. Running {program_name} as:{self.admincheck[0]}, weird \n")
            self.OUtext.configure(text="Extended Option")
            self.EnabledText.configure(text="Extended Option", text_color="black")
            self.LocationText.configure(text="Extended Option")
            self.logstats_button.configure(state="enabled", text="Open Login stats", fg_color=self.sidebar_button_1._fg_color, text_color="white")
            self.extendedsearch_button.configure(state="enabled", text="Extended Search",fg_color=self.sidebar_button_1._fg_color, text_color="white" )
            return Hostname
    else :
        self.logbox.insert('end', f"{timestamp}    {program_name} - No Machine Found matching {searchfieldinput} \n")

def extendedsearch_button_event(self, Hostname):
    
    self.logbox.insert('end', f"{timestamp}    {program_name} - Extended search started on {Hostname} \n")
    self.extendedsearch_button.configure(state="disabled", fg_color="transparent",text="")
    self.main_button_1.configure(state="disabled",text="Please wait...")
    self.update() #force update of gui
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
    

    if self.admincheck[1] == True: #ensure vaule is True aka admin
        pcrunningscript = socket.gethostname()
        if  pcrunningscript == jumpserver:
            vlanname = GUI_functions.VlanLookup(self.IPText.cget("text"))
            self.logbox.insert('end', f"{timestamp}    {program_name} - vlan name:{vlanname} \n")
            self.LocationText.configure(text=vlanname)
            self.MBSerialText.configure(text=GUI_functions.MotherBoardSerial(Hostname))
        else:
            self.logbox.insert('end', f"{timestamp}    {program_name} - You will need to be on {jumpserver} to know locations. You are on {pcrunningscript} \n")
    elif self.admincheck[1] == False:
        self.logbox.insert('end', f"{timestamp}    {program_name} - Not running as admin. Running {program_name} as:{self.admincheck[0]} \n")
        self.LocationText.configure(text="Run as admin to enable")
    else:
        self.logbox.insert('end', f"{timestamp}    {program_name} - Not running as admin. Running {program_name} as:{self.admincheck[0]}, weird \n")
    
    #reenable search button
    
    self.main_button_1.configure(state="enabled",  text="Search", fg_color="transparent", border_width=2,text_color=("gray10", "#DCE4EE"))
    




#VlanLookup("10.74.116.243")
#print(ping("LEX-LT110184"))


#def ping(Hostname):
#    ip = (socket.gethostbyname(Hostname))
#    try: 
#        if ip.startswith ("10.74"):
##            return (ip)
 #       elif ip == "Offline":
#            return "Offline"
#    except:
#        return "Cant get IP of machine"
#    else:
#        return ("Offline")