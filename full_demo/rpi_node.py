import RPi.GPIO as GPIO
import numpy as np
import paho.mqtt.client as mqtt
import subprocess
import threading
import time
import sys

RPI_ID = -1
app = np.array(['GHOST_LED.py', 'BLUE_LED.py', 'GREEN_LED.py', 'YELLOW_LED.py', 'RED_LED', 'CYAN_LED', 'MAGENTA_LED', 'RGB_GPIO.py', 'OFF_LED.py'])
p_app_open = -1
app_open = -1

switch_button_1 = 40
GPIO.setmode(GPIO.BOARD)
GPIO.setup(switch_button_1, GPIO.IN, pull_up_down = GPIO.PUD_UP)
input_state_1 = GPIO.input(switch_button_1)

switch_button_2 = 37
#GPIO.setmode(GPIO.BOARD)
GPIO.setup(switch_button_2, GPIO.IN, pull_up_down = GPIO.PUD_UP)
input_state_2 = GPIO.input(switch_button_2)

is_alive = '2'
is_killed = False
is_exit = 0
proc = subprocess.Popen(['python', "empty.py"])

def get_ID():
    global RPI_ID
    ips = subprocess.check_output(['hostname', '--all-ip-addresses'])
    ind = ips.index(" ")
    if(ips[ind-2] != "."):
       RPI_ID = int(ips[ind-2:ind-1]) - 2
    else:
       RPI_ID = int(ips[ind-1]) - 2

# Define callback function
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
    global app
    global app_open
    global RPI_ID
    #print("message topic: ", message.topic)
    print("message received: ", message.payload)
    # print("message qos: ", message.qos)
    # print("message retain flag: ", message.retain)
    msg = int(message.payload[RPI_ID - 1])
    if(msg >= 0 and msg < len(app)):
        app_open = msg
    else:
        print("Invalid app open")

def on_log_func(client, userdata, level, string):
    pass
# End defining callback function

# Define a function for the thread
def read_switch():
    global input_state_1
    global input_state_2
    global is_alive

    input_state_1 = GPIO.input(switch_button_1)
    input_state_2 = GPIO.input(switch_button_2)
    if input_state_1 == True and input_state_2 == True:
        is_alive = '2' # everything is fine
    elif input_state_1 == True and input_state_2 == False:
        is_alive = '1' # compute ressource faliure
    elif input_state_1 == False:
        is_alive = '0' # router failure
        
    print(is_alive) #output to the resource manager

def call_func():
    global app
    global app_open #input from the resource manager
    global proc
    global is_alive
    global is_killed
    global p_app_open
    #print(is_alive, is_killed)

    if(is_alive == '0' or is_alive == '1'):
        if(is_killed == False):
            is_killed = True
            print("OFF")
            p_app_open = -1
            proc.kill()
            proc.wait()
            proc = subprocess.Popen(['python', app[-1]]) #app to clean up the running app
    elif(is_alive == '2'):
        #print("alive")
        is_killed = False
        if(p_app_open != app_open):
            print(p_app_open, app_open)
            p_app_open = app_open
            print(p_app_open, app_open)
            proc.kill()
            proc.wait()
            proc = subprocess.Popen(['python', app[app_open]]) #app to be run

# main loop
def main():
    global proc
    global is_exit
    try:
        global is_alive
        global RPI_ID
        global input_state
        get_ID()

        # Communication Setup
        broker_address = "192.168.0.2" # broker IP address
        client_name = "rpi_node_" + str(RPI_ID)
        client_topic = "rpi/" + str(RPI_ID)
        client = mqtt.Client(client_name) # client's name

        # binding callback function
        # client.on_connect     = on_connect_func
        # client.on_disconnect  = on_disconnect_func
        # client.on_subscribe   = on_subscribe_func
        # client.on_unsubscribe = on_unsubscribe_func
        # client.on_publish     = on_publish_func
        client.on_message     = on_message_func
        # client.on_log         = on_log_func

        client.connect(broker_address) # connect to a broker        

        # Get the initial app
        client.subscribe(topic = "resource_manager", qos = 0) # subscribe to all nodes
        client.publish(topic = client_topic, payload = is_alive, qos = 0, retain = False)
        #client.loop_start() # loop to enable callback functions 
        #client.loop_stop()

        t1 = time.time()
        t2 = time.time()

        while True:
            # print(is_alive)
            read_switch()
            call_func()

            t0 = time.time()
            if (t0 - t1 > 0.05):
                client.publish(topic = client_topic, payload = is_alive, qos = 0, retain = False)
                t1 = time.time()

	    if (t0 - t2 > 1):
                client.loop_start() # loop to enable callback functions	
                client.loop_stop()
                t2 = time.time()

            is_exit = 0
            pass
    except KeyboardInterrupt:
        is_exit = 1
        print "Exit"
        proc.kill()
        proc.wait()
        sys.exit(1)
main()
