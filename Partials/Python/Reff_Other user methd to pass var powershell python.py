#SOURCE: https://stackoverflow.com/questions/47094207/whats-the-best-way-to-execute-powershell-scripts-from-python#:~:text=Arguably%20the%20best%20approach%20is%20to%20use%20powershell.exe,%27%22%26%20%7B%27%20%2B%20pscommand%20%2B%20%27%7D%22%27%5D%2C%20stdout%3Dsubprocess.PIPE%2C%20stderr%3Dsubprocess.PIPE%29

import subprocess
from string import Template
import os
tempdir = "C:\\temp\\"

scriptblock = (f"Get-ChildItem {tempdir}") #or a PS scriptblock as elaborate as you need   
server = 'localhost'

psbufferfile = os.path.join(tempdir, 'pscmdbufferfile_{}.ps1'.format(server))
fullshellcmd = 'powershell.exe {}'.format(psbufferfile)

#raw_pscommad = 'Invoke-Command -ComputerName $server -ScriptBlock {$scriptblock}'
raw_pscommad = 'Invoke-Command -ScriptBlock {$scriptblock}'
pscmd_template = Template(raw_pscommad)
pscmd = pscmd_template.substitute(server=server, scriptblock=scriptblock)

try:
    with open(psbufferfile, 'w') as psbf:
        psbf.writelines(pscmd)
except:
    print("An exception occurred")

try:
    process = subprocess.Popen(fullshellcmd, shell=True , stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output, error = process.communicate()
except:
    print("An exception occurred2")

