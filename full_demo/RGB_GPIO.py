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

while True:
	# RED node
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
	time.sleep(1)

	# BLUE node
	GPIO.output(RED_LED,   GPIO.LOW)
	GPIO.output(GREEN_LED, GPIO.LOW)
	GPIO.output(BLUE_LED,  GPIO.HIGH)

	# Wait 1 seconds
	time.sleep(1)

	# YELLOW node
	GPIO.output(RED_LED,   GPIO.HIGH)
	GPIO.output(GREEN_LED, GPIO.HIGH)
	GPIO.output(BLUE_LED,  GPIO.LOW)

	# Wait 1 seconds
	time.sleep(1)

	# CYAN node
	GPIO.output(RED_LED,   GPIO.LOW)
	GPIO.output(GREEN_LED, GPIO.HIGH)
	GPIO.output(BLUE_LED,  GPIO.HIGH)

	# Wait 1 seconds
	time.sleep(1)

	# MAGENTA node
	GPIO.output(RED_LED,   GPIO.HIGH)
	GPIO.output(GREEN_LED, GPIO.LOW)
	GPIO.output(BLUE_LED,  GPIO.HIGH)

	# Wait 1 seconds
	time.sleep(1)

	# GHOST node (White)
	GPIO.output(RED_LED,   GPIO.HIGH)
	GPIO.output(GREEN_LED, GPIO.HIGH)
	GPIO.output(BLUE_LED,  GPIO.HIGH)

	# Wait 1 seconds
	time.sleep(1)

	"""# OFF node
	GPIO.output(RED_LED,   GPIO.LOW)
	GPIO.output(GREEN_LED, GPIO.LOW)
	GPIO.output(BLUE_LED,  GPIO.LOW)

	# Wait 1 seconds
	time.sleep(1)"""
