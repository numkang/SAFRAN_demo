import RPi.GPIO as GPIO
import subprocess
import _thread
import time

GPIO.setmode(GPIO.BOARD)
switch_button = 40
GPIO.setup(switch_button, GPIO.IN, pull_up_down = GPIO.PUD_UP)
input_state = GPIO.input(switch_button)

# Define a function for the thread
def call_func(threadName, func_name):
    subprocess.call(['python', func_name])

def read_switch(threadName):
    while True:
        global input_state
        input_state = GPIO.input(switch_button)

# Create two threads as follows
try:
    _thread.start_new_thread( call_func, ("Thread-1", 'RGB_GPIO.py', ) )
    _thread.start_new_thread( read_switch, ("Thread-2", ) )
except:
    print ("Error: unable to start thread")

while True:
    if input_state == False:
        print('Button not Pressed')
        time.sleep(0.2)
    elif input_state == True:
        print('Button Pressed')
        time.sleep(0.2)
        
