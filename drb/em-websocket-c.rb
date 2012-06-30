require 'rubygems'
require 'eventmachine'
require 'em-websocket-client'

EM.run do
  conn = EventMachine::WebSocketClient.connect("ws://127.0.0.1:8843") #("ws://echo.websocket.org/")

  conn.callback do
    conn.send_msg "Hello!"
    conn.send_msg "done"
  end

  conn.errback do |e|
    puts "Got error: #{e}"
  end

  conn.stream do |msg|
    puts "<#{msg}>"
    if msg == "done"
      conn.close_connection
    end
  end

  conn.disconnect do
    puts "gone"
    EM::stop_event_loop
  end
end