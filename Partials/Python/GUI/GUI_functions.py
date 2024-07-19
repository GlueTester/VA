import time
import datetime
import subprocess, sys
import os
from dotenv import load_dotenv, set_key, get_key #pip3 install python-dotenv   and pip3 install pypiwin32
import socket
#import "C:\Users\VHALEXKingR1\GIT\VA\Partials\Python\GUI\GUI_psfunctions.ps1" as psfunctions


#psfunctions = 'C:\\Users\\VHALEXKingR1\\GIT\\VA\\Partials\\Python\\GUI\\psfunctions.ps1'
#psfunctions = "C:\\Users\OITLEXKINGR10\\Desktop\\GIT\\VA\\Partials\\Python\\GUI\psfunctions.ps1"
psfunctions = '//v09.med.va.gov/LEX/Service/IMS/Software/Snakeking/psfunctions.ps1'

envfile = "C:\\temp\\.env"

#if not os.path.exists(envfile):   #create if not exist https://stackoverflow.com/questions/35807605/create-a-file-if-it-doesnt-exist
#    open(".env", "x") close() # creates the file
if not os.path.exists(envfile):
    open(envfile, 'w')

'''
def Quick_Search_clicked(self):
    self.Button_QuickSearch.setText("Searching")
    EE =(input_EE.text())
    SearchType="Quick"
    set_key(dotenv_path="C:\\temp\\.env", key_to_set="EE", value_to_set=EE) 
    set_key(dotenv_path="C:\\temp\\.env", key_to_set="SearchType", value_to_set=SearchType)
    ResolveName(EE)

'''
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
    ip = (socket.gethostbyname(Hostname))
    if ip:
        return (ip)
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
    print(F"Ping reply: {pingreply}")
    proc = subprocess.Popen(["powershell.exe", f"Import-Module {psfunctions}; vlanname({pingreply})"], stdout=subprocess.PIPE)
    try:
        outs, errs = proc.communicate(timeout=15)
        print(F"Befor decode: {outs}")
        out = outs.decode("utf-8").strip("b'.\r\n'") # covnert outs from "bytes" to a "string" , then strips the trash from begin and end of output    
        print(F"After decode: {out}")
        vlanresult = out
        print(F"{vlanresult}")
        return vlanresult
    except subprocess.TimeoutExpired:
        proc.kill()
        outs, errs = proc.communicate()  
    print(F"Outside try: {outs}")

def callback(self, P):
    if str.isdigit(P) or str(P) == "":
        return True
    else:
        return False
    

VlanLookup("10.74.116.243")