import socket

def get_Host_name_IP():
	host_name = socket.gethostname()
	host_ip = socket.gethostbyname(host_name)

	if(host_ip[-2] != '.'):
		host_id = host_ip[-2:]
	else:
		host_id = host_ip[-1]

	print("Hostname : " + host_name)
	print("IP : " + host_ip)
	print(host_id)

	return int(host_id) - 2

RPI_ID = get_Host_name_IP()
print(RPI_ID)