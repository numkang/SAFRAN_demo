#! /usr/bin/python
# Import the libraries we need
import RPi.GPIO as GPIO
import time

# Set the GPIO mode
GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)

# Set the LED GPIO number
RED_LED   = 32
GREEN_LED = 36
BLUE_LED  = 38

# Set the LED GPIO pin as an output
GPIO.setup(RED_LED,   GPIO.OUT)
GPIO.setup(GREEN_LED, GPIO.OUT)
GPIO.setup(BLUE_LED,  GPIO.OUT)

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

        read_switch()
        dummy_func()
        
	# Wait 1 seconds
	#time.sleep(1)

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
