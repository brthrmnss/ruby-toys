 require 'pry'
 
 class FlexUtils
		
	require_relative "../exec_helpers.rb"
	require 'time'
	
	include ExecHelpers
	def initialize(dir=nil) 
		
	end
	
end


a = FlexUtils.new(); 

binding.pry