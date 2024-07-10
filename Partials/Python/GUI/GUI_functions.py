#from PyQt5 import QtCore, QtGui, QtWidgets
import time
#from dotenv import load_dotenv, set_key
import subprocess, sys
import os
#from Partials.Python.GUI.GUI_TechKing import *


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

def  EEtoHostname (EE):
    import pyad.adquery # pip3 install pyad
    q = pyad.adquery.ADQuery()  #pip3 install pypiwin32
    #Source https://pypi.org/project/pyad/
    q.execute_query(
    attributes = ["SamAccountName", "distinguishedName", "Name" ,"description"],
    where_clause = f"objectClass = 'Computer' and Name = 'LEX*{EE}'",
    base_dn = "OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
    )
    for row in q.get_results():
        if EE in (row["Name"] ):
            return (row["Name"])
        
def ping(Hostname):
    return not os.system('ping %s -n 1 > NUL' % (Hostname,) )