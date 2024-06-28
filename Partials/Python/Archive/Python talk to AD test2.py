import pyad.adquery
q = pyad.adquery.ADQuery()

#Source https://pypi.org/project/pyad/
q.execute_query(
attributes = ["distinguishedName", "description"],
where_clause = "objectClass = '*'",
base_dn = "OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
)

for row in q.get_results():
    print (row["distinguishedName"])