import paramiko
#Get user input for SSH credentials
hostname = "lexvista@vista.lexington.med.va.gov"
username = "RK376205"
password = "VA_567085"

#Establish the SSH connection
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname=hostname,username=username,password=password)

#Wait for specific prompt
stdin, stdout, stderr = ssh.exec_command("^ass")
print(stdout.readlines())

#Issue command to get hostname and print it to console
stdin, stdout, stderr = ssh.exec_command("hostname")
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
root.title("ExtraEasy")

# Create variables to store
username, password, and actionselection
username = tk.StringVar()
password = tk.StringVar()
action = tk.StringVar()

# Create a function to retrieve the input values and save them as variables
def login():
user = username.get()
pw = password.get()
act = action.get()
print("Username:", user)
print("Password:", pw)
print("Action:", act)

# Create the input fields and labels
user_label = tk.Label(root,
text="Username:")
user_entry = tk.Entry(root,textvariable=username)
pw_label = tk.Label(root,text="Password:")
pw_entry = tk.Entry(root,textvariable=password, show="*")

# Create the dropdown menu for action selection
action_label = tk.Label(root,text="Select Action:")
action_dropdown =ttk.Combobox(root,textvariable=action,values=["Option 1","Option 2","Option 3"])

# Create the login button
login_button = tk.Button(root,text="Login", command=login)

# Add the components to the window
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
