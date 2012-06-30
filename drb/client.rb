 #!/usr/bin/env ruby
 require 'drb'
 
 #counter = DRbObject.new nil, 'druby://localhost:9000'
 counter = DRbObject.new nil, 'druby://p55-pc:53655'

 counter.increment
 puts "The counter value is #{counter.value}"