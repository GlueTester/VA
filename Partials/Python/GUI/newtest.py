software = {
"ParEx": 
    {
       "state": "enabled",

       "Version": "1.0",

       "path": "vhalex.med.gov-somedir-parexc1.ps1"

    },
"ClintaComp":
    { 
        "state": "enabled",
 
        "Version": "1.3",
 
        "path": "vhalex.med.gov-somedir-parexc1.ps1"
 
     }
},

drivers = {
"Smart Card":
    {

       "state": "enabled",

       "Version": "2.0",

       "path": "vhalex.med.gov-somedir-smartcard2.ps1"

    }
}
#json.dumps(software)
#print(json.dumps(software, sort_keys=True))

json.load(file object)
print(json.dumps(drivers, sort_keys = True))