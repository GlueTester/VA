import paramiko
import tkinter as tk
from tkinter import ttk
import time

# Create the main window
root = tk.Tk()
root.title("ExtraEasy")

# Create variables to store username, password, and actionselection
#username = tk.StringVar()
#password = tk.StringVar()
action = tk.StringVar()
hostname = "lexvista@vista.lexington.med.va.gov"
#hostname = "vista.lexington.med.va.gov"
username = "RK376205"
#username = "lexvista"
password = "VA_567085"
#password = ""
#port = "22""
#options

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
port = "22"
ssh.connect(hostname, port, username, password)
commands = ["RK376205", "VA_567085"]
#, stdout, stderr = channel()
channel = ssh.invoke_shell()
#time.sleep(1) 
#channel.recv(9999)
#channel.send("\n")
time.sleep(1)
channel.send("RK376205" + "\n")
time.sleep(1)
channel.send("VA_567085" + "\n")
output = channel.recv(9999) 
print(output.decode('utf-8'))
result = print(output.decode('utf-8'))

for command in commands:
    channel.send(command + "\n")
    while not channel.recv_ready(): 
        time.sleep(0.1)
    time.sleep(0.1) 
    output = channel.recv(9999) 
    print(output.decode('utf-8'))
    time.sleep(0.1)
channel.close()


def login():
    user = username.get()
    pw = password.get()
    act = action.get()
    if act == "Option 1":
        print("Username:option1")
    elif act == "Option 2":
        print("Username:option2")
    elif act == "Option 3":
        #Establish the SSH connection
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(hostname, port, username, password)
        #Wait for specific prompt
        stdin, stdout, stderr = ssh.exec_command("ACCESS:")
        print(stdout.readlines())
        #Issue command to get hostname and print it to console
        stdin, stdout, stderr = ssh.exec_command("^ass")
        print(stdout.readlines())
        #Close the SSH connection
        ssh.close()
        
    else:
        print("I dont see what you selected")
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




