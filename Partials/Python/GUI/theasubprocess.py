
from dotenv import load_dotenv, set_key, get_key #pip3 install python-dotenv   and pip3 install pypiwin32
from datetime import datetime
import pyad.adquery # pip3 install pyad
from multiprocessing import Process, Queue

# must be a global function    
def my_function(q, x):
    q.put(x)



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

        

def Search_is_SAM(self,searchfieldinput):
    whatigot = SAMtoUserinfo(self, searchfieldinput)
    return whatigot



searchfieldinput = "VHALEXKINGR1"
self='test'

if "VHA" in searchfieldinput.upper(): #converted input ot uppercase 
    queue = Search_is_SAM(self, searchfieldinput)
    p = Process(target=my_function)
    p.start()
    p.join() # this blocks until the process terminates
    result = queue.get()
    print (result)
