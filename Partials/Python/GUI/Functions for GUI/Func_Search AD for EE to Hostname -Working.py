import pyad.adquery # pip3 install pyad
q = pyad.adquery.ADQuery()  #pip3 install pypiwin32
EE = '107203'
#Source https://pypi.org/project/pyad/
q.execute_query(
attributes = ["SamAccountName", "distinguishedName", "Name" ,"description"],
where_clause = f"objectClass = 'Computer' and Name = 'LEX*{EE}'",
base_dn = "OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
)
#print (f"{EE}")
for row in q.get_results():
    if EE in (row["Name"] ):
        print (row["Name"])
