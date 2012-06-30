module ExecHelpers

	@debug = true
	@debug = false

 
	 def q str
	    return '"'+str.to_s+'"'
	  end
	   def quote str
	    return '"'+str.to_s+'"'
	  end
	  
	def call cmd
		if @debug 
			cmd 
		else 
			puts "run command", cmd

			system(cmd) if cmd != nil 
			#puts 'ran'
		end
	end

	def make_temp_script commands, merge=nil#, delete_after=true
		temp_script = 'run_rebuild.bat' 
		if commands.class == Array 
			commands = commands.join("\n")
		end
		File.open(temp_script, 'w') {|f| f.write( commands ) }
		call temp_script 
		#File.delete temp_script
	end
	
	def fix_path path
		path.gsub!("\\", "/")
	end
	
	
	def putss *rest
	    puts rest.join(', ' ) 
    end
    
    
    	def get_files_in_folder directory, return_full_path = true, keep_dots = false , skip = [], recursive = false  
		#directory = @temp_folder2 + '/' +directory
		directory = directory.gsub("\\", "/")
		files = Dir.entries(directory)
		if keep_dots == false 
			files.delete('..')
			files.delete('.')			
		end
		output_files = []
		files.each do | file | 
			
			next if skip != nil && skip.include?( file ) 
			full_path =  directory + '/' + file
			if File.directory?( full_path ) 
				if recursive == false 
					next 
				else
					inner_files = get_files_in_folder full_path, return_full_path, keep_dots, skip, recursive
					output_files = output_files+ inner_files
					next
				end
			end
			output_files << full_path
		end
		return output_files
	end
    
        def write_text filename, contents, directory
		Dir.mkdir(directory) if File.exists?(directory) == false 
		File.open(directory+'/'+filename, 'w') {|f| f.write(contents) }
	end
        
    
    	def copy_files_to_folder files, directory, delete=false
		Dir.mkdir(directory) if File.exists?(directory) == false 
		require 'FileUtils'
		files.each do | file | 
			 FileUtils.cp_r( [file], directory ) 
			 File.delete(file) if delete
		end
		 
	 end
	 
	 def remove_extension(file)
		basename = File.basename(file); 
		filename_no_ext = basename.gsub(File.extname(file), '' )  
		return filename_no_ext
	end
	
	def get_file_path(file)
		#basename = File.basename(file); 
		path = file.gsub(File.basename(file), '' )  
		return path
	end
	
	 #take windows version in nix version
	def convert_path directory
		directory = directory.gsub("\\", "/")
		 directory
	 end
	 alias  :fix_path :convert_path
	  #can never remember ths line
	def read_file local_filename
		f = File.open(local_filename)
		s = f.read
		#puts local_filename
		#puts s 
		#puts s
		#File.open(local_filename, 'w') {|f| f.write(doc) }
		s
	end
		  #can never remember ths line
	def write_file local_filename, contents
		 
		 File.open(local_filename, 'w') {|f| f.write(contents) }
		 
	end
	def download_url_to full_url, to_here
	      require 'open-uri'
	      writeOut = open(to_here, "wb")
	      writeOut.write(open(full_url).read)
	      writeOut.close
        end
      
	def make_path_if_needed path
		require 'fileutils'
		putss 'make_path_if_needed', path
		FileUtils::mkdir_p(path) if File.exists?(path) == false 
		
	end
	
	
	#convert true false to primative true/false (symbol)
	def params_tf input
		return true if input == true || input == 'true' 
		return false if input == false || input == 'false'
		return false; 
	end
	
end
 

  