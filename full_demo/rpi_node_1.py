import paho.mqtt.client as mqtt
import time

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

broker_address = "139.162.123.182" # broker IP address
client = mqtt.Client("rpi_node_1") # client's name

# binding callback function
client.on_connect     = on_connect_func
client.on_disconnect  = on_disconnect_func
client.on_subscribe   = on_subscribe_func
client.on_unsubscribe = on_unsubscribe_func
client.on_publish     = on_publish_func
client.on_message     = on_message_func
client.on_log         = on_log_func

client.connect(broker_address) # connect to a broker

client.subscribe(topic = "reconfig", qos = 0) # subscribe to all nodes

while True:
	client.publish(topic = "rpi/1", payload = "rpi_1", qos = 0, retain = False)
		
	client.loop_start() # loop to enable callback functions	
	client.loop_stop()