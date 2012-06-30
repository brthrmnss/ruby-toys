  require 'web_socket'
  STDOUT.sync = true
  # Runs the server at port 10081. It allows connections whose origin is example.com.
  puts 'starting'
  server = WebSocketServer.new(:port => 8889, 
 # :accepted_domains => ["127.0.0.1", "example.com", "localhost"])
 :accepted_domains => ["*"])
  server.run() do |ws|
    # The block is called for each connection.
    # Checks requested path.
    if ws.path == "/"
      # Call ws.handshake() without argument first.
      ws.handshake()
      puts 'what'
      # Receives one message from the client as String.
      while data = ws.receive()
        puts(data)
        # Sends the message to the client.
        ws.send(data)
      end
    else
      # You can call ws.handshake() with argument to return error status.
      ws.handshake("404 Not Found")
    end
  end