import RPi.GPIO as GPIO
import paho.mqtt.client as mqtt
import subprocess
import threading
import time

GPIO.setmode(GPIO.BOARD)
switch_button = 40
GPIO.setup(switch_button, GPIO.IN, pull_up_down = GPIO.PUD_UP)
input_state = GPIO.input(switch_button)

kill_flag = False
is_killed = True
proc = subprocess.Popen(['python', "empty.py"])

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
    print("message topic: ", message.topic)
    print("message received: ", message.payload)
    print("message qos: ", message.qos)
    print("message retain flag: ", message.retain)

def on_log_func(client, userdata, level, string):
    pass
# End defining callback function

# Define a class for the thread
class myThread (threading.Thread):
    def __init__(self, threadID, name1, name2):
        threading.Thread.__init__(self)
        self._stop_event = threading.Event()
        self.threadID = threadID
        self.name1 = name1
        self.name2 = name2

    def stop(self):
        self._stop_event.set()
        
    def run(self):
        print ("Starting " + self.name1)
        if(self.threadID == 1):
            read_switch(self.name1)
        elif(self.threadID == 2):
            call_func(self.name1, self.name2)
        print ("Exiting " + self.name1)
# End defining a class for the thread

# Define a function for the thread
def read_switch(threadName):
    global input_state
    global kill_flag
    
    while True:        
        input_state = GPIO.input(switch_button)
        if input_state == False:
            if kill_flag == True:
                kill_flag = False
            # print('Button not Pressed')
            time.sleep(0.2)
        elif input_state == True:
            if kill_flag == False:
                kill_flag = True
            # print('Button Pressed')
            time.sleep(0.2)

def call_func(func_name_call, func_name_kill):
    global proc
    global kill_flag
    global is_killed
    
    while True:
        if(kill_flag == False and is_killed == True):
            proc.kill()
            proc.wait()
            proc = subprocess.Popen(['python', func_name_call]) #app to be run
            time.sleep(0.2)
            is_killed = False
        elif(kill_flag == True and is_killed == False):
            proc.kill()
            proc.wait()
            proc = subprocess.Popen(['python', func_name_kill]) #app to clean up the running app
            time.sleep(0.2)
            proc.kill()
            proc.wait()
            is_killed = True
# End define a function for the thread

# main loop
def main():

    # Communication Setup
    broker_address = "128.61.62.222" # broker IP address 139.162.123.182 (someone's else)
    client = mqtt.Client("rpi_node_0") # client's name

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

    # Threading Setup
    thread_switch = myThread(1, "switch_button", "switch_button")
    thread_switch.start()

    thread_led = myThread(2, "RGB_GPIO.py", "OFF_LED.py")
    thread_led.start()

    while True:
        client.publish(topic = "rpi/0", payload = "rpi_0", qos = 0, retain = False)
		
        client.loop_start() # loop to enable callback functions	
        client.loop_stop()
        pass
main()
