import paramiko, os

HOSTNAME = 'myhost.com'
SSH_PRIV_KEY_PATH = os.path.expanduser('~/.ssh/id_rsa')

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
k = paramiko.RSAKey.from_private_key_file(SSH_PRIV_KEY_PATH)
ssh.connect(HOSTNAME, username='root', pkey = k)
stdin , stdout, stderr = ssh.exec_command('shell_command')
stdout.read()
ssh.close()
