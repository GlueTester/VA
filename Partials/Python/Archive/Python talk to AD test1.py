from ldap3 import Server, Connection, SUBTREE
total_entries = 0
#server = Server('test-server')
c = Connection('v09.med.va.gov', auto_bind=True)
#c = Connection(server, user='username', password='password')
c.search(search_base = 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov',
         search_filter = '(objectClass=inetOrgPerson)',
         search_scope = SUBTREE,
         attributes = ['cn', 'givenName'],
         paged_size = 5)
total_entries += len(c.response)
for entry in c.response:
    print(entry['dn'], entry['attributes'])
#cookie = c.result['controls']['1.2.840.113556.1.4.319']['value']['cookie']
#while cookie:
#    c.search(search_base = 'o=test',
#             search_filter = '(objectClass=inetOrgPerson)',
#             search_scope = SUBTREE,
#             attributes = ['cn', 'givenName'],
#             paged_size = 5,
#             paged_cookie = cookie)
#    total_entries += len(c.response)
#    cookie = c.result['controls']['1.2.840.113556.1.4.319']['value']['cookie']
    for entry in c.response:
        print(entry['dn'], entry['attributes'])
print('Total entries retrieved:', total_entries)