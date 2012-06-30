#puts RUBY_PLATFORM
require 'rubygems'
if RUBY_PLATFORM =~ /win32/ || RUBY_PLATFORM =~ /w32/ 
printf('r')
  require "win32/process"
  
  # GenerateConsoleCtrlEvent, dwProcessGroupId = 0L < NULL < nil
  def sysint_gpid; nil; end
else
  def sysint_gpid; -Process.getpgrp; end
end

IO.popen("ruby sub.rb 2>&1", "r+") do |pipe|
  trap("INT") do
    puts "parent pid: #{$$} Control-C"
  end

  puts "parent pid: #{$$}, popen return (child) pid: #{pipe.pid}"
  line = pipe.gets      # pid from child
  pipe.puts "test"
  puts "child says it's pid is: "+line
  Process.kill 'INT', sysint_gpid
  childs_last_word = pipe.gets
    childs_last_word = pipe.gets
    puts pipe.inspect
  if childs_last_word
    puts "child's last word: " + childs_last_word
  end
end
puts "child's exit code: #{$?.exitstatus}"