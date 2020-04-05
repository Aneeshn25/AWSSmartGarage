from gpiozero import LED
import time
green = LED(4)
red = LED(3)
yellow = LED(2)
for i in range(10):
  print(i)
  green.on()
  time.sleep(0.3)
  green.off()
  red.on()
  time.sleep(0.3)
  red.off()
  yellow.on()
  time.sleep(0.3)
  yellow.off()
  green.on()
  time.sleep(0.3)