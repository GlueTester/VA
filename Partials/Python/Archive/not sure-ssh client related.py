from paramiko import SSHClient, AutoAddPolicy
import time
#hostname = "lexvista@vista.lexington.med.va.gov"
hostname = "vista.lexington.med.va.gov"
username2 = "RK376205"
username = "lexvista"
password = ""
password2 = "VA_567085"
port = "22"

stdouts = []
clients = []

ssh = SSHClient()
ssh.set_missing_host_key_policy(AutoAddPolicy())
ssh.connect(hostname, port, username, password)
sleeptime = 0.001
outdata, errdata = '', ''
ssh_transp = ssh.get_transport()
chan = ssh_transp.open_session()
# chan.settimeout(3 * 60 * 60)
chan.setblocking(0)
chan.exec_command(username2)
while any(x is not None for x in stdouts):
    for i in range(len(stdouts)):
        stdout = stdouts[i]
        if stdout is not None:
            channel = stdout.channel
            # To prevent losing output at the end, first test for exit,
            # then for output
            exited = channel.exit_status_ready()
            while channel.recv_ready():
                s = channel.recv(1024).decode('utf8')
                print(f"#{i} stdout: {s}")
            while channel.recv_stderr_ready():
                s = channel.recv_stderr(1024).decode('utf8')
                print(f"#{i} stderr: {s}")
            if exited:
                print(f"#{i} done")
                ssh[i].close()
                stdouts[i] = None
    time.sleep(0.1)

ssh_transp.close()

print(outdata)
print(errdata)