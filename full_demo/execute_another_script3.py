import RPi.GPIO as GPIO
import subprocess
from multiprocessing import Process
import time

GPIO.setmode(GPIO.BOARD)
switch_button = 40
GPIO.setup(switch_button, GPIO.IN, pull_up_down = GPIO.PUD_UP)
input_state = GPIO.input(switch_button)

# Define a function for the thread
def call_func(func_name):
    while True:
        print("aaa")
        time.sleep(1)
    subprocess.call(['python', func_name])

def read_switch():
    while True:
        print("bbb")
        time.sleep(1)
        global input_state
        input_state = GPIO.input(switch_button)

# Create two threads as follows
#try:

thread_led = Process(target = call_func, args = ('RGB_GPIO.py',))
thread_led.start()

thread_switch = Process(target = read_switch, args = ())
thread_switch.start()
#except:
#    print ("Error: unable to start thread")

while True:
    if input_state == False:
        print('Button not Pressed')
        time.sleep(0.2)
    elif input_state == True:
        print('Button Pressed')
        time.sleep(0.2)
