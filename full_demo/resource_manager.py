import paho.mqtt.client as mqtt
import time
import subprocess
import sys

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
	print("message topic: ", message.topic)
	print("message received: ", message.payload)
	print("message qos: ", message.qos)
	print("message retain flag: ", message.retain)

def on_log_func(client, userdata, level, string):
	pass
# end callback function

# main loop
def main():
    try:
        global RPI_ID
        get_ID()

	# Communication Setup
	broker_address = "192.168.0.2" # broker IP address
	client = mqtt.Client("resource_manager") # client's name

	# binding callback function
	client.on_connect     = on_connect_func
	client.on_disconnect  = on_disconnect_func
	client.on_subscribe   = on_subscribe_func
	client.on_unsubscribe = on_unsubscribe_func
	client.on_publish     = on_publish_func
	client.on_message     = on_message_func
	client.on_log         = on_log_func

	client.connect(broker_address) # connect to a broker

	client.subscribe([("rpi/#", 0)]) # subscribe to all nodes

	while True:
		client.publish(topic = "resource_manager", payload = "reconfig_output", qos = 0, retain = False)
		
		client.loop_start() # loop to enable callback functions	
		client.loop_stop()
		pass
    except KeyboardInterrupt:
        print "Exit"
        sys.exit(1)
main()
