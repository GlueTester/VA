import pyad.adquery

# Specify the LDAP path to the domain and the credentials to use
pyad.set_defaults(ldap_server="ldap://DC02.v09.med.va.gov", username="DOMAIN\\VHALEXKINGR1", password="")

# Construct an AD query to find computer objects with a specific name
query = pyad.adquery.ADQuery()
query.execute_query(
    attributes=["cn", "dNSHostName"],
    where_clause="objectClass='computer' and cn='COMPUTERNAME'",
    base_dn="DC=domain,DC=local"
)

# Print the results, if any
for row in query.get_results():
    print(row["dNSHostName"])
