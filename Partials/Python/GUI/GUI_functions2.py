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
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement
import pyad.adquery # pip3 install pyad

#Declare location of JSON file
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

def EEtoHostname (EE):
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

def SAMtoUserinfo (self, SAM):
    t = pyad.adquery.ADQuery()
    user = SAM
    t.execute_query(
        attributes = ["Department","title","DisplayName","mail","Enabled","info","Manager"],#"lastlogondate"],#,"LockedOut","Manager","Name","PasswordNotRequired"],#"SamAccountName","SID","StreetAddress","telephoneNumber","Title","whenCreated"],
        #attributes = ["Department","Description","DisplayName","mail","Enabled","info","LastLogonDate","LockedOut","Manager","Name","PasswordNotRequired","SamAccountName","SID","StreetAddress","telephoneNumber","Title","whenCreated"],
        where_clause = f"SamAccountName = '{user}'",
        base_dn = "DC=v09,DC=med,DC=va,DC=gov"
    )
    for row in t.get_results():
            print (row)
            department = row["Department"]
            title = row["title"]
            displayname = row["DisplayName"]
            emailaddress = row["mail"]
            enabled = row["Enabled"]
            info = row["info"]
            #lastlogondate = row["lastlogondate"]
            #lockedout = row["LockedOut"]
            #
            manager = row["Manager"]
            #name = row["Name"]
            #enabled = row["Enabled"]
            #passwordnotrequired = row["PasswordNotRequired"]
    try:
        return department,title,displayname,emailaddress,enabled,info,manager#,lastlogondate#,lockedout#,manager#,name,passwordnotrequired
    except:
        pass
        #print()
        #self.logbox.insert('end', f"{timestamp}    {self.program_name} - Could not find a user like {self.searchfieldinput} \n")

     
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
            vlanname = VlanLookup(self.IPText.cget("text"))
            self.logbox.insert('end', f"{timestamp}    {program_name} - vlan name:{vlanname} \n")
            self.LocationText.configure(text=vlanname)
            self.MBSerialText.configure(text=MotherBoardSerial(Hostname))
        else:
            self.logbox.insert('end', f"{timestamp}    {program_name} - You will need to be on {jumpserver} to know locations. You are on {pcrunningscript} \n")
    elif self.admincheck[1] == False:
        self.logbox.insert('end', f"{timestamp}    {program_name} - Not running as admin. Running {program_name} as:{self.admincheck[0]} \n")
        self.LocationText.configure(text="Run as admin to enable")
    else:
        self.logbox.insert('end', f"{timestamp}    {program_name} - Not running as admin. Running {program_name} as:{self.admincheck[0]}, weird \n")
    
    #reenable search button
    
    self.main_button_1.configure(state="enabled",  text="Search", fg_color="transparent", border_width=2,text_color=("gray10", "#DCE4EE"))

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
        self.LastRegistered_Text.configure(text="")
        self.PhoneStatus_Text.configure(text="")
        self.DeviceName_Text.configure(text="")
        self.Description_Text.configure(text="")
        self.Phone_IPV4_Text.configure(text="")
        self.SAM_Text.configure(text="")
        self.User_Department_Text.configure(text="")
        self.User_FirstName_Text.configure(text="")
        self.User_Email_Text.configure(text="")
        self.User_Enabled_Text.configure(text="")
        self.User_TourOfDuty_Text.configure(text="")
        self.User_Title_Text.configure(text="")
        self.User_Manager_Text.configure(text="")

# Fileds the the Main search can identify and preform action
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
       
def Search_is_SAM(self,searchfieldinput):
    #self.logbox.insert('end', f"{timestamp}    {program_name} - Searching for a User - {searchfieldinput.upper()}  \n")
    #self.tabview.set("User")#change active tab to the "user tab"
    whatigot = SAMtoUserinfo(self, searchfieldinput)

    return whatigot

def search_is_MAC(self , searchfieldinput , adminuser , adminpass): #workhorse for mac finding of phones
    self.tabview.set("Phones")#change active tab to the "user tab"
    self.update() 

    class Scraper:

        def __init__(self, headless: bool = True) -> None:

            self.headless = headless

            pass

        def setup_scraper(self) -> None:

            self.options = Options()

            self.options.add_argument("--headless=new",) #https://www.selenium.dev/blog/2023/headless-is-going-away/

            self.options.add_experimental_option('excludeSwitches', ['enable-logging']) #https://stackoverflow.com/questions/47392423/python-selenium-devtools-listening-on-ws-127-0-0-1
            
            self.options.add_argument('log-level=3') #https://github.com/SeleniumHQ/selenium/issues/13095

            #self.options.set_capability("browserVersion", "117") #https://github.com/SeleniumHQ/selenium/issues/13095
            self.options.add_argument("--remote-debugging-port=8080") #Corrected Mule 1 not opeing port for chrome
            self.driver = webdriver.Chrome(options=self.options)
            self.options.add_experimental_option("prefs", {"profile.managed_default_content_settings.images": 2}) 
            self.options.add_argument("--no-sandbox") 
            self.options.add_argument("--disable-setuid-sandbox") 
            self.options.add_argument("--disable-dev-shm-using") 
            self.options.add_argument("--disable-extensions") 
            self.options.add_argument("--disable-gpu") 
            self.options.add_argument("start-maximized") 
            self.options.add_argument("disable-infobars")
            self.options.add_argument(r"user-data-dir=.\cookies\\test")

        def navigate(self, target) -> None:

            self.driver.get(target) if target else print('[!] No target given. Please specify a URL.')

        def extract_raw_data(self) -> str:

            return self.driver.page_source

        def extract_single_element(self,  selector: str, selector_type: By = By.CSS_SELECTOR) -> WebElement:

            return self.driver.find_element(selector_type, selector)

        def extract_all_elements(self, selector: str, selector_type: By = By.CSS_SELECTOR) -> list[WebElement]:

            return self.driver.find_elements(selector_type, selector)
        
        def input(self, field, keystosend) -> None:
            
            return self.driver.find_element(By.NAME, field).send_keys(keystosend)
        
        def get_screenshot(self, filename)-> None:
            
            return self.driver.get_screenshot_as_file(filename)
        
        def click_single_element(self,  selector: str, selector_type: By = By.CSS_SELECTOR) -> WebElement:

            return self.driver.find_element(selector_type, selector).click()

    # Initialize a new Scraper and navigate to a target

    scraper = Scraper()

    scraper.setup_scraper()

    scraper.navigate('https://vhalexfonucm01.v09.med.va.gov/ccmadmin/showHome.do')


    searchitem  = searchfieldinput


    single_element = scraper.extract_single_element('cuesLoginProductName', By.CLASS_NAME) #grabs title in page

    self.logbox.insert('end', f"{timestamp}    {program_name} - Loggin into: {single_element.text} Please wait\n")
    self.update() 

    #Some vars
    username = adminuser
    password = adminpass
    sleeptime = 0

    #Go to webpage and ensure it scisco 
    call_manager_page_header = scraper.extract_single_element('cuesLoginProductName', By.CLASS_NAME) #grabs title in page

    #log into page
    scraper.input("j_username",username )
    scraper.input("j_password",password )
    scraper.driver.find_element(By.XPATH,"/html/body/form/div[2]/table[1]/tbody/tr[1]/td[2]/table/tbody/tr[5]/td/button[1]").click() #Login button, used Full XPATH becuase couldnt get other to work #Source 1.https://www.selenium.dev/documentation/webdriver/elements/locators/ | 2.https://stackoverflow.com/questions/65657539/how-to-located-selenium-element-by-css-selector
    time.sleep(sleeptime)
    #ensure we are logged in
    headertext_user = scraper.extract_single_element("cuesHeaderText", By.CLASS_NAME)
    
    if (headertext_user.text != username):  #.text has to be added becuase element was being retun not its content #Source:https://stackoverflow.com/questions/70203815/python-selenium-printing-results-as-selenium-webdriver-remote-webelement-webe
        print (f"Logged in user is:{headertext_user.text}  but the username provide is:{username}")
    else:
        scraper.navigate('https://vhalexfonucm01.v09.med.va.gov/ccmadmin/phoneFindList.do') #here we are only search by what the filter are by defualt (Device Name. starts with)
        time.sleep(sleeptime)
        scraper.driver.find_element(By.XPATH,'//*[@id="searchLimit0"]/option[2]').click() # select contains as filter    
        time.sleep(sleeptime) 
        scraper.input("searchString0",searchitem )
        time.sleep(sleeptime)
        scraper.driver.find_element(By.XPATH,"/html/body/table/tbody/tr/td/div/form[1]/div/table/tbody/tr[1]/td[7]/input").click()
        time.sleep(sleeptime)
        last_resistered = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(8)').text
        device_Name_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(3) > a').text
        device_description_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(4)').text
        device_status_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(7)').text
        device_IP_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(11)').text


        self.LastRegistered_Text.configure(text = last_resistered)
        self.PhoneStatus_Text.configure(text = device_status_line)
        self.DeviceName_Text.configure(text = device_Name_line)
        self.Description_Text.configure(text = device_description_line) 
        self.Phone_IPV4_Text.configure(text = device_IP_line)


def strike(text): #enables use to pass text to and have it rewritten as strike through
    #https://stackoverflow.com/questions/25244454/python-create-strikethrough-strikeout-overstrike-string-type
    result = ''
    for c in text:
        result = result + c + '\u0336'
    return result+" Under Maintenance"