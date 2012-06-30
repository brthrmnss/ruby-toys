
class A 
	attr_accessor :v
	attr_reader :v;
	def tap
		puts 'tab'
	end
end

a = A.new()
a.v = 6
puts a.v
a.tap

class A 
	attr_accessor :v
	attr_reader :v;
	def initialize()
		@v = 7
	end
	def tap
		puts "what?"
	end
end
 
# A.class_eval {  undef :tap } 
puts a.v
a.tap
a.instance_eval { remove_instance_variable :@v} 
#puts.v
puts 'done'