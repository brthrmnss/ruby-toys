require 'eventmachine'
require 'em-websocket'
@touch = 'boo' 
$touch = 'hoo'
$count = 0
EventMachine.run {

    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8843) do |ws|
        ws.onopen {
          puts "WebSocket connection open"

          # publish message to the client
          ws.send "Hello Client"
        }

        ws.onclose { puts "Connection closed" }
        ws.onmessage { |msg|
          puts "Recieved message: #{msg}"
	  $count += 1
	  $touch += ' ' + $count.to_s
          ws.send "Pong: #{msg} #{$touch}"
        }
    end
}