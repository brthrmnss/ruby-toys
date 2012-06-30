#require "rubygems"
#require "curltube"
#require "viddl-rb"
class DownloadVideo
	
		
	#~ folder = 'U:\downloads\bbb\bbc\downloads\Compressed\rb2k-viddl-rb-8099163\rb2k-viddl-rb-8099163'
	#~ puts File.exists?( 'U:\downloads\bbb\bbc\downloads\Compressed\rb2k-viddl-rb-8099163\rb2k-viddl-rb-8099163\viddl-rb-0.4.5.gem')
	#require 'U:\downloads\bbb\bbc\downloads\Compressed\rb2k-viddl-rb-8099163\rb2k-viddl-rb-8099163\viddl-rb-0.4.5'
	#Dir.chdir = 'u:'
	#require folder+ '\bin\viddl-rb '

	#~ puts File.exists? folder+ '\bin\viddl-rb '
	#~ $LOAD_PATH << folder
	#~ $LOAD_PATH << folder+'\bin'
	require "viddl-rb"
	#load "viddl-rb-0.4.5"
	#viddle-rb "http://www.youtube.com/watch?v=nc__3nsfxwA&feature=related"
	#curltube "http://www.youtube.com/watch?v=DW5wYg1ycSA&feature=related"

	def make_temp_script commands, merge=nil#, delete_after=true
		temp_script = 'run_rebuild.bat' 
		if commands.class == Array 
			commands = commands.join("\n")
		end
		File.open(temp_script, 'w') {|f| f.write( commands ) }
		call temp_script 
		#File.delete temp_script
	end

	def call cmd
		if @debug 
			cmd 
		else 
			system(cmd)
		puts 'ran'
		end
	end

	def convert( url, base )#, ripped_audio, audio_ripped_name='ripped' )
		final_dir = ''
		final_dir =base;# 'U:/downloads/bbb/bbc/downloads/Compressed/rb2k-viddl-rb-8099163/output'
		 
		 require 'fileutils'
		#url = "http://www.youtube.com/watch?v=P3PDLsJQcGI"
		#url = "http://www.youtube.com/watch?v=oiWWKumrLH8"
		file_name = Viddl::process(url);
		file_name = file_name[0]
		#asdf.g
		#puts "test"
		file_name = "Shortest_Video_on_Youtube_Part_4.mp4" if file_name == nil
		#puts "file name "  + file_name
		#return; 
		if final_dir != nil 
			puts "move"
			require 'fileutils'
			FileUtils.mv(file_name, final_dir )
		end
		puts "test2"
		 file_name =final_dir + '/'+file_name
		#~ if audio 
			#~ puts "audio" 
			#~ input_file =  final_dir + '/'+file_name
			#~ output_file = final_dir + '/'+file_name
			#~ old_extension = File.extname(output_file)
			#~ output_file.gsub!( old_extension, '.mp3' ) 
			#~ puts 'convert to ' + output_file
			#~ make_temp_script	"ffmpeg -y -i  \"#{input_file}\" \"#{output_file}\""
			#~ require 'fileutils'
			#~ file_name = output_file.gsub(final_dir + '/','' )
			#~ if ripped_audio_dir != nil 
				#~ puts "move", File.directory?(final_dir+'/'+ripped_audio_dir), final_dir+'/'+ripped_audio_dir
				#~ FileUtils.makedirs (final_dir+'/'+ripped_audio_dir) if File.directory?(final_dir+'/'+ripped_audio_dir) == false
				#~ FileUtils.mv(input_file, final_dir+'/'+ripped_audio_dir  )
			#~ end
		#~ end
		puts "finished"
		@file_name = file_name
		file_name
	end
	#converts @file_name to audio, and can place original in speical subfolder 
	#if you have changed name of the @file_name, set the 2nd optional parameter 
	def convert_audio place_in_subfolder, new_filename = nil
		ripped_audio_dir =  place_in_subfolder
		#~ audio = false 
		#~ audio = true
		
		
		@file_name = new_filename if new_filename != nil 
		file_name = @file_name; 
		puts "audio "  + @file_name
		input_file =  file_name
		output_file = file_name
		
		old_extension = File.extname(output_file)
		output_file = output_file.gsub( old_extension, '.mp3' ) 
		puts 'convert to ' + output_file 
		make_temp_script	"ffmpeg -y -i  \"#{input_file}\" \"#{output_file}\""
		require 'fileutils'
		 puts "path " + File.dirname( @file_name ) 
		# return

		#file_name = output_file.gsub(final_dir + '/','' )
		if ripped_audio_dir != nil 
			
			if ripped_audio_dir.include?('/') == false  #if not full path, create one ...
				ripped_audio_dir = File.dirname( @file_name ) + '/' + ripped_audio_dir
			end
			puts "move", File.directory?(ripped_audio_dir), ripped_audio_dir
			FileUtils.makedirs (ripped_audio_dir) if File.directory?(ripped_audio_dir) == false
			FileUtils.mv(input_file, ripped_audio_dir  )
		end
		output_file
	end
end

if __FILE__ == $0 then
	a  = DownloadVideo.new()
	puts a.convert( 'http://www.youtube.com/watch?v=oiWWKumrLH8', 
	'U:/downloads/bbb/bbc/downloads/Compressed/rb2k-viddl-rb-8099163/output').inspect
	audio_rip = a.convert_audio 'ripped'
	puts "audio "  + audio_rip
	puts "finished"
end