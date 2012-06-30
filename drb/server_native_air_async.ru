 require 'rubygems'
require 'rack'
 require 'sinatra'
 require "sinatra/reloader"
require 'sinatra/async'
 enable :logging
 set :environment, :development
 STDOUT.sync = true

 set :bind, 'localhost'
 set :port, 8889
 
 require 'sinatra/async'
 class AsyncTest < Sinatra::Base
   register Sinatra::Async
   
   enable :show_exceptions
 
 
 #require 'sinatra/async'
 
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
# sdf.g
run  AsyncTest.new