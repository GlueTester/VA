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