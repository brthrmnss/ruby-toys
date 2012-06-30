require 'pry-remote-em/server'

class Foo
  def initialize(x, y)
    puts "line 1"
    binding.remote_pry_em
    puts "line 2"
  end
  
  def put str
  	puts str
  end
end

EM.run { Foo.new 10, 20 } 