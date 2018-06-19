import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)
Push_button = 40
GPIO.setup(Push_button, GPIO.IN, pull_up_down = GPIO.PUD_UP)

while True:
    input_state = GPIO.input(Push_button)
    if input_state == False:
        print('Button not Pressed')
        time.sleep(0.2)
    elif input_state == True:
        print('Button Pressed')
        time.sleep(0.2)
