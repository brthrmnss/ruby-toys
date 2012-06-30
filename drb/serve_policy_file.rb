require 'rubygems'
require 'rack'
require 'sinatra'
require "sinatra/reloader"

set :bind, 'localhost'
set :port, 843
STDOUT.sync = true

get '/' do
	'Hello world!'
end
 

get '/crossdomain.xml' do
file = "<?xml version=\"1.0\"?>
    <!DOCTYPE cross-domain-policy SYSTEM \"http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd\">
    <cross-domain-policy>
    <allow-access-from domain=\"*\" />
    </cross-domain-policy> "
end
 