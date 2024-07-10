#FIRST, Determin OS
import os
if os.name == 'nt':
    system_os = "Windows"
elif os.name == 'posix':
    system_os = "MacOS"

print (system_os)