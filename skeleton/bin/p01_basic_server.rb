require 'webrick'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

@my_brick = WEBrick::HTTPServer.new(Port: 3000)

# my_brick.mount_proc('/')
# mount_proc

def serve_response(path = '/', request, &response)
  response.content_type = 'text/text'
  response.body = request.path
  @my_brick.mount_proc(path, request, &response)

  puts response.body
end

def start_server
  trap('INT') { @my_brick.shutdown }
  @my_brick.start()
end

start_server
