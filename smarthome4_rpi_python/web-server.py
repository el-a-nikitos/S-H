from http.server import BaseHTTPRequestHandler, HTTPServer
import os

f = open('main.html')
html = f.read()
f.close()
"""
html = '''
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="description" lang="en" content="Development">
        <meta name="keywords" lang="en" content="El-Nikitos, PCB, microelectronics, 3D-modeling">

        <meta http-equiv="refresh" content="0; url=main_white.html">
        
        <title>
            El-Nikitos: microelectronic development
        </title>
    </head>

    <body>
        
    </body>
</html>
'''
"""
class ServerHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        print("GET request, Path:", self.path)
        if self.path == "/":
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write(html.encode('utf-8'))
            
        elif self.path == "/main_white.html":
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            print(os.curdir + os.sep + self.path)
            with open(os.curdir + os.sep + self.path, 'rb') as file:
                self.wfile.write(file.read())

        elif self.path == "/main_black.html":
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
    server_thread(port)
