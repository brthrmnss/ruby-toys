puts "8. Shell"
require 'shell'

Shell.def_system_command :ruby, 'C:/Ruby192/bin/ruby -v' #;Dir.pwd
Shell.def_system_command :ruby2, 'asdfsdfsdfsd' #;Dir.pwd
shell = Shell.new
input  = 'Hello from parent'
#THIS_FILE = 'boo.rb'
THIS_FILE = '"G:/My Documents/work/scripts/drb/boo.rb"'
process = shell.transact do
  #echo(input) | ruby('-r', THIS_FILE, '-e', 'hello("shell.rb", true)')
 # echo(input)  | ruby('-r', THIS_FILE, '-e', '\'hello("shell.rb", true)\'')
 #echo(input)  | ruby('-r', THIS_FILE, '-e', '\'hello("shell.rb")\'')
 #echo(input) #| ruby()
 #puts input
 ruby2()
  echo('df') #| ruby("-v") 
  echo(input)
  echo(input+'6')
end
output = process.to_s
output.split("\n").each do |line|
  puts "[parent] output: #{line}"
end
puts "---"

#"G:\My Documents\work\scripts\drb\boo.rb"