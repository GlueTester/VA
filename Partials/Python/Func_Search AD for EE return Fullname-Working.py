import pyad.adquery
q = pyad.adquery.ADQuery()
EE= '97987'
#Source https://pypi.org/project/pyad/
q.execute_query(
attributes = ["SamAccountName", "distinguishedName", "Name" ,"description"],
where_clause = "objectClass = 'Computer'",
base_dn = "OU=Windows 10,OU=Laptops, OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
)

for row in q.get_results():
    if EE in (row["Name"] ):
        print (row["Name"])
