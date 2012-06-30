$:.unshift "lib"
require "childprocess"
require "tempfile"

out = Tempfile.new("irb-test")
#puts $stdout
out = $stdout
irb = "irb"
irb << ".bat" if RUBY_PLATFORM.include? "mingw"

process = ChildProcess.build(irb, "-f")
process.io.stdout = out
process.io.stderr = out
process.duplex = true

process.start
process.io.stdin.puts "1 + 1"
process.io.stdin.puts "'foo'.reverse"
process.io.stdin.puts "exit"
#process.io.stdin.close

sleep 3


out.rewind
#puts out.read
#out.close!
puts 'done setp 2'

sleep 30

process.start
process.io.stdin.puts "1 + 1"
process.io.stdin.puts "'foo'.reverse"
process.io.stdin.puts "exit"
#process.io.stdin.close

sleep 3


out.rewind
puts out.read
out.close!
puts 'done'

unless process.exited?
	puts "force exit"
  process.stop
end
