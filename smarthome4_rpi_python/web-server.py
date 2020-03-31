from http.server import BaseHTTPRequestHandler, HTTPServer
import os
import wiringpi
from datetime import datetime

try:
    import RPi.GPIO as GPIO
except ModuleNotFoundError:
    pass

led_1_red_pin = 13
led_1_green_pin = 12
led_1_blue_pin = 6
led_3_blue_pin = 11

def raspberrypi_init():
    try:
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(led_1_red_pin, GPIO.OUT)
        GPIO.setup(led_1_green_pin, GPIO.OUT)
        GPIO.setup(led_1_blue_pin, GPIO.OUT)
        GPIO.setup(led_3_blue_pin, GPIO.OUT)
    except:
        pass

def rasperrypi_pinout(pin: int, value: bool):
    print("LED ON" if value else "LED OFF")
    try:
        GPIO.output(pin, value)
    except:
        pass

def rasperrypi_cleanup():
    try:
        GPIO.cleanup()
    except:
        pass

class ServerHandler(BaseHTTPRequestHandler):
    
    def do_GET(self):
        current_data_and_time = datetime.now()
        str_data_and_time = str( current_data_and_time.day ) + '-'+str( current_data_and_time.month ) + '-'+str( current_data_and_time.year )
        
        log_file = open('log/log_' + str_data_and_time + '.txt', 'a+')
        log_file.write( self.client_address[0] + ' at ' + str( current_data_and_time ) + ' :GET request:' + self.path + '\n' )
        log_file.close()
        
        if self.path == "/":
            self.path = "/main.html"
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            with open(os.curdir + os.sep + self.path, 'rb') as file:
                self.wfile.write(file.read())
                
        elif self.path.endswith(".jpg"):
            self.send_response(200)
            self.send_header('Content-type', 'image/jpg')
            self.end_headers()
            with open(os.curdir + os.sep + self.path, 'rb') as file:
                self.wfile.write(file.read())

        elif self.path.endswith(".png"):
            self.send_response(200)
            self.send_header('Content-type', 'image/png')
            self.end_headers()
            with open(os.curdir + os.sep + self.path, 'rb') as file:
                self.wfile.write(file.read())

        elif self.path == "/led_1_off":
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            rasperrypi_pinout(led_1_red_pin, False)
            self.wfile.write(b"OK")

        elif self.path == "/led_1_100":
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            rasperrypi_pinout(led_1_red_pin, True)
            self.wfile.write(b"OK")

        elif self.path == "/led_2_off":
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            rasperrypi_pinout(led_1_green_pin, False)
            self.wfile.write(b"OK")

        elif self.path == "/led_2_100":
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            rasperrypi_pinout(led_1_green_pin, True)
            self.wfile.write(b"OK")

        elif self.path == "/led_3_off":
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            rasperrypi_pinout(led_1_blue_pin, False)
            self.wfile.write(b"OK")

        elif self.path == "/led_3_100":
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            rasperrypi_pinout(led_1_blue_pin, True)
            self.wfile.write(b"OK")

        elif self.path == "/led_5_off":
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            rasperrypi_pinout(led_3_blue_pin, False)
            self.wfile.write(b"OK")

        elif self.path == "/led_5_100":
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            rasperrypi_pinout(led_3_blue_pin, True)
            self.wfile.write(b"OK")

        else:
            self.send_error(404, "Page Not Found {}".format(self.path))

def server_thread(port):
    server_address = ('', port)
    httpd = HTTPServer(server_address, ServerHandler)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()

if __name__ == '__main__':
    port = 8000
    print("Starting server at port %d" % port)

    current_data_and_time = datetime.now()
    str_data_and_time = str( current_data_and_time.day ) + '-'+str( current_data_and_time.month ) + '-'+str( current_data_and_time.year )
    
    log_file = open('log/log_' + str_data_and_time + '.txt', 'a+')
    log_file.write( '! server is running at ' + str( current_data_and_time ) + '\n' )
    log_file.close()

    raspberrypi_init()
    
    server_thread(port)

    rasperrypi_cleanup()
