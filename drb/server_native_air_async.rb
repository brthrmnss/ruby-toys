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

class AsyncTest < Sinatra::Base
  register Sinatra::Async
  STDOUT.sync = true

  enable :show_exceptions
 set :bind, 'localhost'
 set :port, 10081

#require 'sinatra/async'
get '/crossdomain.xml' do
file = "<?xml version=\"1.0\"?>
    <!DOCTYPE cross-domain-policy SYSTEM \"http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd\">
    <cross-domain-policy>
    <allow-access-from domain=\"*\" />
    </cross-domain-policy> "
end
  aget '/' do
	  puts "no"
    body "hello async"
  end
  aget '/g' do
    body "hello async"
  end
  aget '/delay/:n' do |n|
    EM.add_timer(n.to_i) { body { "delayed for #{n} seconds" } }
  end

end
#sdf.g
#run  AsyncTest.new
AsyncTest.run!
  #~ set :bind, 'localhost'
  #~ set :port, 8889
