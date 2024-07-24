for key in GUIvars[0]:
    GUIKey.append(key)

for value in GUIvars[0]:
    GUIValue.append(value)

for i in GUIKey:
    print (i)

for parms in data['GUIParms']:
    parms = (parms["program_name"])
    print(f"from parms: {parms}")
