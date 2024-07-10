from ldap3 import Server, Connection, ALL
conn = Connection('v09.med.va.gov', auto_bind=True)

# Powershell variabnle for computers
# $NewComputerDomainName = Get-ADComputer -Filter "Name -like '*$NewEE'" -SearchBase 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'


#uses ldap3
# pip3 insatll ldap3



server = Server('v09.med.va.gov',  get_info=ALL)
conn = Connection(server, auto_bind=True)
server.info

'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov',

entry_generator = c.extend.standard.paged_search(search_base = 'o=Lexington (LEX)' 'o=VISN09',
                                                 search_filter = '(objectClass=inetOrgPerson)',
                                                 search_scope = SUBTREE,
                                                 attributes = ['cn', 'givenName'],
                                                 paged_size = 5,
                                                 generator=True)
for entry in entry_generator:
    total_entries += 1
    print(entry['dn'], entry['attributes'])
print('Total entries retrieved:', total_entries)