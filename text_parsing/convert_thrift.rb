
=begin
#open file 
#look for certain line
look for public function FXNAME
 "     oprot_.getTransport().flush(function(error:Error):void {"
go until see
      });
    }
    
#replace inside

copy first line with public function onFXName, capital first letter
    
#input 

#break on new line / <br />
#if line contains  ':' break 
#title, page
#add page to aarray 
#add content
#continue until see break sequence
#if line and no ':' add to unknown

#if in_mode, add to aa
=end



require 'rubygems'
 
class GoThroughFile
  attr_accessor :input_zip, :output_zip, :temp_folder, 
	:temp_folder2, 
	:delete_temp_folders

  def initialize( input_file  )
	input_file = input_file.gsub("\\", '/' )
	@input_file = input_file
	#puts input_file

  end

  def process  
	lines = open_file #@input_file
	line_count =0
	in_fx = false
	found_get_trans = false
	fx_name = nil
	transport_flush = []
	in_transport = false
	fx_new_name= ''
	lines.each do | line | 
		line_count += 1
		next if line == nil || line == true || line.strip.empty?
		#puts line
		if line_includes  line, 'public function'
			#next if line_includes line, 'on'
			fx_name = line 
			fx_name = content_between line, 'public function ', '('
			next if fx_name.include? 'get '
			next if fx_name.include? 'set '
			#puts fx_name
			in_fx = true
			found_get_trans = false
		end
		
		if line.include? 'oprot_.getTransport().flush(function(error:Error):void {'
			in_transport = true
			puts fx_name
			#puts 'here'
			fx_new_name = "on"+fx_name.capitalize
			renamed = "oprot_.getTransport().flush(#{fx_new_name})"
			puts renamed
			transport_flush = []
			next
		end
		
		#end of transport reached
		if line.include? '});'
			in_transport = false
			puts transport_flush.join "\n"
			 puts 'here end'
		end
		
		if in_transport
			transport_flush << line
		end
		
		lines2 << line
		
	end	
  end
   def open_file  
	 lines = File.open(@input_file)
	 lines 
 end
 
   def line_includes line, include
	line.include? include
end 
   def content_between line, start, ending
	line = line.split(start)[1]
	#puts line.inspect
	line = line.split(ending)[0]
	line
  end 
end



 
 
if __FILE__ == $0 then
	build_zip = GoThroughFile.new('G:\My Documents\work\mobile3\EvernoteTestElips\src\com\evernote\edam\userstore\UserStoreImpl.as')
	build_zip.process() 
end

return

@greedy = true; #flag indicates that you are in_mode until a new mode is set
 
@in_mode = false
@aa = {};
@current_name = ''
@content = ''

 

def add_to_aa name, content
    arr = @aa[name] 
    arr = [] if arr == nil 
    arr.push(content)
    @aa[name] = arr; 
  end


def sequence_title input
    title = input.split(':')[0]
    return title; 
  end
def sequence_data input
    data= input.split(':')[1..-1].join(':');
    return data; 
  end

def sequence_start? input
    return input.include?(':')
  end


def break_sequence? input
    if @greedy == false 
    return input.includes('\n')
    else
      return input.includes(':')
    end
  end
  
  def setup_input()
  
input = ''
input = "
2/2/2011


.feelingbetter: ugh, .... woke up tat 7:30 fater fall asleep at 2:30, had dificulty falling asleep too 
no pankcakces togay i'm annoyed. 

phsycology: i think you mind cannot resist merging ideas


mastercam 
get through 7, and 8 , we are trying to figure out how to build up the stock ohlding, doesn't seem to be here 
Feature BAsed Milling? 
rotary indexing looks great
there is an advanced fixture ifn volume 2 .... go there after you understand the chains 


browsn rice --- try it agin ... let us see .... 
"

input = 
"
2/2/2011


.feelingbetter: ugh, .... woke up tat 7:30 fater fall asleep at 2:30, had dificulty falling asleep too 
no pankcakces togay i'm annoyed. 

phsycology: i think you mind cannot resist merging ideas


mastercam: 
get through 7, and 8 , we are trying to figure out how to build up the stock ohlding, doesn't seem to be here 
Feature BAsed Milling? 
rotary indexing looks great
there is an advanced fixture ifn volume 2 .... go there after you understand the chains 


diet: brown rice pancakes --- try it agin ... let us see .... 

living dirty: 
wash beard for shave, use 2nd heaphones


tobuy: 2nd headphones just in case cause goes missing 

.feelingbetter: ugh... ugh .... red blood in stoo , what did i eat ? red meat/ too much, or onions? ..... never been this bad ... godo thing we encourtered in now


diet:tobuy: no salt...but what are risks

.feelingbetter: will probably be tired soon ...


rq: air doors - that's what that's called: those 'air doors' great for bugs .... y not use automatic? with air when door is open? 


.feelingbetter: had to take a nap .... damn so tired, still kind of am 


learning: starts with imagination, first you have to konw what you want to do, or plan on doing. then we'll read some books to figure out what are the mcommon methods and see if they get you close to what ou want. 

concepts, definitions, narratives, wrkflows, exercises, problem solving initiateves

css: new app, 4 buttons took 40 minutes .... {} error, public can only be used in a class
damn that was easier that we thought it woudl be


wherego: rich: mindprepare: there is no point in being rich just fo t esake of moeny, people spend time making themselves tired 

"  
    return input
  end
  
  #!/usr/bin/env ruby

#~ ARGV.each do|a|
  #~ puts "Argument: #{a}"
#~ end
 
 if ! defined? input 
  input = nil 
  input = ARGV[0] 
end
if input == nil
    input = setup_input()
  end
  
split = input.split("\n")

puts split.length

split.each do | line | 
  #puts   line.inspect
  #puts sequence_start?( line).to_s + ' ' +line
  if sequence_start? line
    @in_mode =true
    @current_name = sequence_title line
    @content = sequence_data line   
    add_to_aa(@current_name, @content)
    #@in_mode =false
    next
  end
  #puts 'line: '  + line
    #~ if break_sequence? && @in_mode
    #~ @in_mode = false
  #~ end  
  #if in mode add to aa
  if @in_mode 
    add_to_aa(@current_name, line)
  else
    add_to_aa('unknown', line)
  end
end
sorted_keys =  @aa.keys.sort
output = '' 
sorted_keys.each do | k |
  output += "\n" 
  puts ''
  puts k
  output += "\n"   +  k
  v = @aa[k]
  v.each do | value |
    puts '   ' + value.inspect; 
  output += "\n"     + value#.inspect; 
  end
end

output
#return 'sss'
#~ @aa.each do | k, v |
  #~ puts ''
  #~ puts k
  #~ v.each do | value |
    #~ puts '   ' + value.inspect; 
  #~ end
#~ end

