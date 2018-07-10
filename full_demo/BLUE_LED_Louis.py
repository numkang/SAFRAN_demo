#! /usr/bin/python
# Import the libraries we need
import RPi.GPIO as GPIO
import time
import paho.mqtt.client as mqtt
import subprocess


# Set the GPIO mode
GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)

# Set switch button
switch_button_1 = 40
GPIO.setup(switch_button_1, GPIO.IN, pull_up_down = GPIO.PUD_UP)
input_state_1 = GPIO.input(switch_button_1)

switch_button_2 = 37
GPIO.setup(switch_button_2, GPIO.IN, pull_up_down = GPIO.PUD_UP)
input_state_2 = GPIO.input(switch_button_2)


# Set the LED GPIO number
RED_LED   = 32
GREEN_LED = 36
BLUE_LED  = 38

# Set the LED GPIO pin as an output
GPIO.setup(RED_LED,   GPIO.OUT)
GPIO.setup(GREEN_LED, GPIO.OUT)
GPIO.setup(BLUE_LED,  GPIO.OUT)


def get_ID():
    global RPI_ID
    ips = subprocess.check_output(['hostname', '--all-ip-addresses'])
    ind = ips.index(" ")
    if(ips[ind-2] != "."):
       RPI_ID = int(ips[ind-2:ind-1]) - 2
    else:
       RPI_ID = int(ips[ind-1]) - 2

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

def dummy_func():
        if is_alive == '2': #expected result
            print(50)
            return 50
        if is_alive == '1': #CR fault
            print(0)
            return 0
        else: #Router fault
            print('X')
            return 0

while True:
    """# RED node
    GPIO.output(RED_LED,   GPIO.HIGH)
    GPIO.output(GREEN_LED, GPIO.LOW)
    GPIO.output(BLUE_LED,  GPIO.LOW)
    
    # Wait 1 seconds
    time.sleep(1)
    
    # GREEN node
    GPIO.output(RED_LED,   GPIO.LOW)
    GPIO.output(GREEN_LED, GPIO.HIGH)
    GPIO.output(BLUE_LED,  GPIO.LOW)
    
    # Wait 1 seconds
    time.sleep(1)"""
                
    # BLUE node
    GPIO.output(RED_LED,   GPIO.LOW)
    GPIO.output(GREEN_LED, GPIO.LOW)
    GPIO.output(BLUE_LED,  GPIO.HIGH)
    
    # Wait 1 seconds
    #time.sleep(1)
    
     
    #global is_alive
    global RPI_ID
    #global input_state
    get_ID()
    
    # Communication Setup
    broker_address = "192.168.0.2" # broker IP address
    client_name = "appli_on_node_" + str(RPI_ID)
    client_topic = "res_BLUE"
    client = mqtt.Client(client_name) # client's name
    # "object" already exists in upper loop. Issue?
    
    client.connect(broker_address)
    
    
    read_switch()
    result = dummy_func() # to convert into a character?
    
    client.publish(topic = client_topic, payload = result, qos = 0, retain = False)
        
    """# GHOST node
    GPIO.output(RED_LED,   GPIO.HIGH)
    GPIO.output(GREEN_LED, GPIO.HIGH)
    GPIO.output(BLUE_LED,  GPIO.HIGH)
    
    # Wait 1 seconds
    time.sleep(1)
    
    # OFF node
    GPIO.output(RED_LED,   GPIO.LOW)
    GPIO.output(GREEN_LED, GPIO.LOW)
    GPIO.output(BLUE_LED,  GPIO.LOW)
    
    # Wait 1 seconds
    time.sleep(1)"""
