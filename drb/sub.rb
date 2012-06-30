trap("INT") do 
    STDERR.puts "sub pid #{$$} Control-C"
    exit 2
end
puts "test child"
puts "what did you say?"

sleep 5
puts "#{$$}"
STDOUT.flush
