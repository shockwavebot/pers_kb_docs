# python -m http.server 8000
# python -m http.server 8000 --bind 127.0.0.1 --directory /tmp/

import http.server
import socketserver

PORT = 8000

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("serving at port", PORT)
    httpd.serve_forever()
    
    
