#~ require 'rubygems'
#~ require 'rack'
#~ require 'sinatra'
#~ require "sinatra/reloader"



#~ STDOUT.sync = true

#~ get '/' do
	#~ 'Hello world!'
	#~ puts 'hello?'
#~ end
 

#~ get '/crossdomain.xml' do
#~ file = "<?xml version=\"1.0\"?> 
    #~ <!DOCTYPE cross-domain-policy SYSTEM \"http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd\">
    #~ <cross-domain-policy>
    #~ <allow-access-from domain=\"*\" />
    #~ </cross-domain-policy> "
#~ end
puts 'what'
#require 'haml'

#asdf.g.d.
require 'rubygems'
#~ require 'sinatra'
#require 'rest_client'
require 'sinatra/async'
 require "sinatra/reloader"
 STDOUT.sync = true

#~ set :run, false
#~ disable :reload
 #~ set :bind, 'localhost'
 #~ set :port, 8889

require 'rubygems'      # <-- Added this require
require 'em-websocket'
require 'sinatra/base'
require 'thin'

EventMachine.run do     # <-- Changed EM to EventMachine
	STDOUT.sync = true
  class App < Sinatra::Base
      get '/' do
          return "foo"
  end
  get '/crossdomain.xml' do
file = "<?xml version=\"1.0\"?>
    <!DOCTYPE cross-domain-policy SYSTEM \"http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd\">
    <cross-domain-policy>
    <allow-access-from domain=\"*\" />
    </cross-domain-policy> "
end
  end

  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8889) do |ws| # <-- Added |ws|
      # Websocket code here
      ws.onopen {
          ws.send "connected!!!!"
      }

      ws.onmessage { |msg|
          puts "got message #{msg}"
      }

      ws.onclose   {
          ws.send "WebSocket closed"
      }

  end

  # You could also use Rainbows! instead of Thin.
  # Any EM based Rack handler should do.
  App.run!({:port => 8433})    # <-- Changed this line from Thin.start to App.run!
end
