import paho.mqtt.client as mqtt
import numpy as np
import time
import subprocess
import sys

is_exit = 0
node_number = 4*4
node_status = np.empty(node_number, dtype = "S1")
node_status[:] = '0'

RPI_ID = -1

def get_ID():
    global RPI_ID
    ips = subprocess.check_output(['hostname', '--all-ip-addresses'])
    ind = ips.index(" ")
    if(ips[ind-2] != "."):
       RPI_ID = int(ips[ind-2:ind-1]) - 2
    else:
       RPI_ID = int(ips[ind-1]) - 2

# callback function
def on_connect_func(client, userdata, flags, rc):
    pass

def on_disconnect_func(client, userdata, rc):
    pass

def on_subscribe_func(client, userdata, message_id, granted_qos):
    pass

def on_unsubscribe_func(client, userdata, message_id):
    pass

def on_publish_func(client, userdata, message_id):
    pass

def on_message_func(client, userdata, message):
	global node_status
	global node_number
    # print("message topic: ", message.topic)
    # print("message received: ", message.payload)
    # print("message qos: ", message.qos)
    # print("message retain flag: ", message.retain)
    node_id = int(message.topic[4:])
    if(node_id >= 1 and node_id <= node_number):
    	node_status[node_id - 1] = int(message.payload)
    else
    	print("Invalid node id")

def on_log_func(client, userdata, level, string):
    pass
# end callback function

# Reconfiguration function
def reconfiguration_func()
	global RPI_ID
	global node_status

	output = "0000000000000000"

	if(node_status[0] == b'1'):
		output[0] = '1'
	elif(node_status[0] == b'0' and node_status[1] == b'1')
		output[1] = '1'

	return output

# main loop
def main():
    global is_exit
    try:
        global RPI_ID
        get_ID()

		# Communication Setup
		broker_address = "192.168.0.2" # broker IP address
		client = mqtt.Client("resource_manager") # client's name

		# binding callback function
		# client.on_connect     = on_connect_func
		# client.on_disconnect  = on_disconnect_func
		# client.on_subscribe   = on_subscribe_func
		# client.on_unsubscribe = on_unsubscribe_func
		# client.on_publish     = on_publish_func
		client.on_message     = on_message_func
		# client.on_log         = on_log_func

		client.connect(broker_address) # connect to a broker
		client.subscribe([("rpi/#", 0)]) # subscribe to all nodes

		while True:
			reconfiguration_output = reconfiguration_func()
	    	client.publish(topic = "resource_manager", payload = reconfiguration_output, qos = 0, retain = False)
		
	    	client.loop_start() # loop to enable callback functions	
	    	client.loop_stop()

	    	is_exit = 0
	    	pass
    except KeyboardInterrupt:
        is_exit = 1
        print "Exit"
        sys.exit(1)
main()
