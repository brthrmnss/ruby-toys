 #!/usr/bin/env ruby
 require 'drb'
 
 class Counter
   attr_reader :value
 
   def initialize
     @value = 0
   end
 
   def increment
     @value += 1
   end
 end
 
 DRb.start_service 'druby://localhost:9000', Counter.new
  DRb.start_service nil, Counter.new
 puts "Server running at #{DRb.uri}"
 
 trap("INT") { DRb.stop_service; puts "goodbye" }
 DRb.thread.join