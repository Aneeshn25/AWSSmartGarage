#!/usr/bin/python

from flask import request
from flask_api import FlaskAPI
import RPi.GPIO as GPIO
import time

LEDS = {"green": 7, "red": 5}
GPIO.setmode(GPIO.BOARD)
GPIO.setup(LEDS["green"], GPIO.OUT)
GPIO.setup(LEDS["red"], GPIO.OUT)

app = FlaskAPI(__name__)

@app.route('/', methods=["GET"])
def api_root():
    offcount = 0
    incount = 0
    get_color = []
    get_color_status = []
    for color in LEDS:
        status = GPIO.input(LEDS[color])
        if status == 1:
            get_color.append(color)
            get_color_status.append(status)
            incount = incount + 1
        elif status == 0:
            offcount = offcount + 1
    def loop_status(color):
        return{
            get_color[color]:get_color_status[color]
        }
    if incount >= 1:
        return {
            "status": [loop_status(color) for color in range(len(get_color))]
        }
    elif offcount == 2:
        return {
            "status":"All LEDs are turned off"
        }

@app.route('/led/<color>/', methods=["GET", "POST"])
def api_leds_control(color):
    if request.method == "POST":
        if color in LEDS:
            GPIO.output(LEDS[color], 1)
            time.sleep(1)
            GPIO.output(LEDS[color], 0)
    return {color: GPIO.input(LEDS[color])}

if __name__ == "__main__":
    app.run()