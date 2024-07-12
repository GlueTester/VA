import subprocess, sys
import os
import time
from dotenv import load_dotenv, set_key #pip3 install python-dotenv

envfile = "C:\\temp\\2.env"

if not os.path.exists(envfile):   #create if not exist https://stackoverflow.com/questions/35807605/create-a-file-if-it-doesnt-exist
    open(envfile, "x") # creates the file
load_dotenv(envfile)

#Linux : env_file_path.touch(mode=0o600, exist_ok=False) ## Create the file if it does not exist.
#https://stackoverflow.com/questions/63484742/how-to-write-in-env-file-from-python-code


#print os.environ.get("SECRET_KEY")

#GCP_PROJECT_ID = os.getenv('GCP_PROJECT_ID')
#print (GCP_PROJECT_ID)

        #pip install python-decouple
##Start-Process 'C:\WINDOWS\system32\notepad.exe'

#ENVIROMENT
# Cause: python script destroy env varable after exicution
#Path:  C:\Users\VHALEXKingR1\AppData\Local\Programs\Python\Python311\
#Command
#   Check pwd : cwd = os.getcwd()
#   Use ENV file: pip3 install python-dotenv / Allows for env file / #Source: https://dev.to/jakewitcher/using-env-files-for-environment-variables-in-python-applications-55a1

#cwd = os.getcwd()
#f = open(".env", "x")
#print (cwd)
    # Set the input variable

PCName = "LEX-LT110184"
set_key(dotenv_path=envfile, key_to_set="python_var", value_to_set=PCName)

# Define the PowerShell script
#Source: (PowerShell escape characters) https://stackoverflow.com/questions/58845990/how-to-get-powershell-to-output-variable-with-quotes-around-it 
# / (OutFile) https://stackoverflow.com/questions/20858133/output-powershell-variables-to-a-text-file 
# /
ps_script2 = """
$InputVar = ConvertTo-Json $env:python_var
$powershell_var = ping LEX-LT110184 
echo "OutputVar =`'$powershell_var`' " | out-file -filepath "C:\\temp\\2.env" -append -Encoding ASCII
"""

ps_script = """
ping 
"""
#gci env:* | sort-object name
# Run the PowerShell script with the input variable as an environment variable
#Sources - (https://stackoverflow.com/questions/5971312/how-to-set-environment-variables-in-python) , (https://stackoverflow.com/questions/21944895/running-powershell-script-within-python-script-how-to-make-python-print-the-pow) , (https://www.tutorialspoint.com/how-to-set-environment-variables-using-powershell) , (https://petri.com/powershell-set-environment-variable/#:~:text=To%20add%20an%20environment%20variable,the%20(%2B%3D)%20operator) , (https://stackoverflow.com/questions/30006722/os-environ-not-setting-environment-variables) , (https://stackoverflow.com/questions/5327495/list-all-environment-variables-from-the-command-line)
result = subprocess.run(["powershell.exe", "-Command", ps_script2])#, capture_output=True)

#print ("Input env:" + os.getenv['input_var'] )
#print ("Output env:" + os.environ['PATH'] )
#print ("Output env:" + os.getenv['output_var'] )
#print ("Output env:" + os.environ['PATH'] )
