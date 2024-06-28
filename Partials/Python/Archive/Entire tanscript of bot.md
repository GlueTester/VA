write a python script
that establishes an SSH
connection based on the
credentials input by the
user. upon connection wait
for a specific prompt then
issue a command
to get the hostname of the remote
server and print it to the console.
import paramiko
#Get user input for SSH
credentials
hostname = input("Enter the
hostname or IP address: ")
username = input("Enter the
username: ")
password = input("Enter the
password: ")
#Establish the SSH connection
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(
paramiko.AutoAddPolicy())
ssh.connect(hostname=hostname,
username=username,
password=password)
#Wait for specific prompt
stdin, stdout, stderr =
ssh.exec_command("ls")
print(stdout.readlines())
#Issue command to get hostname
and print it to console
stdin, stdout, stderr =
ssh.exec_command("hostname")
print(stdout.readlines())
#Close the SSH connection
ssh.close()
make a python script that
creates a graphical user
interface to prompt user for
username and password
then select an action from a
drop-down menu and save
these as variables
Here's an example of how to
create a simple GUI using the
tkinter library in Python, which
prompts the user for a username,
password, and action selection:
```
python
import tkinter as tk
from tkinter import ttk
# Create the main window
root = tk.Tk()
root.title("My App")
# Create variables to store
username, password, and action
selection
username = tk.StringVar()
password = tk.StringVar()
action = tk.StringVar()
# Create a function to retrieve the
input values and save them as
variables
def login():
user = username.get()
pw = password.get()
act = action.get()
print("Username:"
, user)
print("Password:"
, pw)
print("Action:"
, act)
# Create the input fields and labels
user_label = tk.Label(root,
text=
"Username:")
user_entry = tk.Entry(root,
textvariable=username)
pw_label = tk.Label(root,
text=
"Password:")
pw_entry = tk.Entry(root,
textvariable=password, show=
"*")
# Create the dropdown menu for
action selection
action_label = tk.Label(root,
text=
"Select Action:")
action_dropdown =
ttk.Combobox(root,
textvariable=action,
values=["Option 1"
,
"Option 2"
,
"Option 3"])
# Create the login button
login_button = tk.Button(root,
text=
"Login"
, command=login)
# Add the components to the
window
user_label.pack()
user_entry.pack()
pw_label.pack()
pw_entry.pack()
action_label.pack()
action_dropdown.pack()
login_button.pack()
# Start the main loop
root.mainloop()
```
This example creates a window
with three input fields (for
username, password, and action
selection), a dropdown menu,
and a login button. When the
user clicks on the login button, a
function is called that retrieves the
values from the input fields and
the dropdown menu, and saves
them as variables. You can then
use these variables in your Python
script as needed.


powershell script to
uncheck "Stop devices
when my screen is off to
help save battery" under
USB
Here's a PowerShell script that
unchecks the "Stop devices when
my screen is off to help save
battery" option under USB power
settings:
```
# Define the USB power settings
GUID
$USB_GUID =
"{a5dcbf10-6530-11
d2-901f-00c04fb951ed}"
# Disable the "Stop devices when
my screen is off to help save
battery" option
Set-CimInstance -Namespace
root\cimv2\power -ClassName
Win32_PowerSettingDataIndex
-Arguments @{Index=0;InstanceID
=
"$USB_GUID"} -PropertyValues
@{SettingIndexValue=0}
```
This script uses the
`Set-CimInstance
`
cmdlet to
disable the "Stop devices when
my screen is off to help save
battery" option under the USB
power settings. The USB power
settings have a GUID of `{a5dcbf1
0-6530-11d2-901f-00c04fb951ed}
`
.
The
`Set-CimInstance
`
cmdlet is
used to modify an instance of the
`Win32_PowerSettingDataIndex
`
class in the
`
root\cimv2\power
`
namespace. The
`Index
`
parameter is set to 0 to modify
the first instance of the class,
which corresponds to the USB
power settings. The
`InstanceID`
parameter is set to the USB GUID
to identify the specific power
setting to modify. Finally, the
`SettingIndexValue
`
property is set
to 0 to disable the "Stop devices
when my screen is off to help save
battery" option.
