#~ x = Thread.new do
	#~ #compute_ultimate_question
	#~ puts "x"
#~ end
#~ #return
#~ vogon = Thread.new do
   #~ Thread::kill(x)
  #~ end
#!/usr/bin/env ruby -w
# simple_service.rb
# A simple DRb service

# load DRb
require 'drb'

# start up the DRb service
DRb.start_service nil, []

# We need the uri of the service to connect a client
puts DRb.uri

# wait for the DRb service to finish before exiting
DRb.thread.join