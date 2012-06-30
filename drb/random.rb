# "win32/process"
#~ f = IO.popen("uname")
#~ p f.readlines
#~ f.close
#~ puts "Parent is #{Process.pid}"
#~ IO.popen("pwd") { |f| puts f.gets }
#~ IO.popen("-") {|f| $stderr.puts "#{Process.pid} is here, f is #{f.inspect}"}
#~ p $?
#~ IO.popen(%w"sed -e s|^|<foo>| -e s&$&;zot;&", "r+") {|f|
  #~ f.puts "bar"; f.close_write; puts f.gets
#~ }



#~ IO.popen("ruby", "r+") do |pipe|
  #~ pipe.puts "puts 10**6"
  #~ pipe.puts "__END__"
  #~ pipe.gets
#~ end
#~ puts 'g'




#~ require 'win32/process'
#~ #Process.create(:app_name => "perl C:/bin/filepp-1.8.0/filepp.pl -c")

#~ cmd = 'C:\Ruby192\bin\irb'
#~ cmd = 'ruby '
#~ d = Process.create(:app_name => cmd)
#~ puts d.inspect

#~ Process.wait()

require 'win32/process'

readme, writeme = IO.pipe
cmd = "cmd.exe /c echo hello"
pi = Process.create(
:app_name => cmd,
:inherit => true,
:creation_flags => Process::DETACHED_PROCESS,
:startup_info => {
:startf_flags => Process::STARTF_USESTDHANDLES,
:stdin => writeme,
:stdout => readme}
)
Process.waitpid(pi.process_id)
writeme.close
res = ''
while readme.gets do
res += $_
end
puts ">#{res}<"

return

require 'win32/process'
require 'rbconfig'
include Config
#asdf.g
# numbers.rb is one line of Ruby:
#5.times{ |i| puts "I: #{i}" }

# Here's the code that calls numbers.rb
app = File.join(CONFIG['bindir'], 'ruby') + ' "'
app += File.join(Dir.pwd, 'numbers.rb') + '"'
gg = 's'
fh = File.open('test.txt', 'w')

Process.create(
:app_name => app,
:inherit => true,
:creation_flags => Process::DETACHED_PROCESS,
:startup_info => {
:startf_flags => Process::STARTF_USESTDHANDLES,
:stdout => fh,
:stdin=> gg
}
)
puts gg.inspect
fh.close

