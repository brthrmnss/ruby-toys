=begin
this script will take files in a folder 
and search another folder and put them next to fiels with the same name 
=end
test = true
test = false
 
STDOUT.sync = true
class MoveFiles
		
	require_relative "../exec_helpers.rb"
	require 'time'
	
	include ExecHelpers
	def initialize(joined_folder=nil, locations_folder=nil, command_only=false, test=false, include_dir=nil)
		@joined_dir = convert_path joined_folder
		@locations_dir  = convert_path locations_folder
		@match = 0; 
	end
	
	def move
		
		#in location folder
		#get each file 
		#get filename old 
		@joined_files = get_files_in_folder(@joined_dir) #flast list of files in joined folder
		@files = get_files_in_folder(@locations_dir, true, false, nil, true) #= flat list of files all files in location folder
		@files.each do | file | 
			try_to_find_match_and_move_file( file )
			#return if @match > 5 
		end
		
 
		#~ @joined_files.each do | file | 
			#~ puts file 
		#~ end
	end
	
	#try to find match and move
	def try_to_find_match_and_move_file(filename)
		filename_no_ext =remove_extension(filename) 
		#get file from new location 
		#puts filename_no_ext
		#return
		@joined_files.each do | joined_file |
			joined_file_no_ext = remove_extension(joined_file ) 
			if joined_file_no_ext.include?(filename_no_ext) 
				#putss 'move', filename_no_ext
				move_file_to(joined_file, filename) 
				@match+=1
				return
			end
		end
	end
		
	#move file to same folder as location file
	def move_file_to(file, location_file)
		#filename_no_ext = File.basename(filename); 
		loc_file_dir = get_file_path( location_file ) 
		putss 'copy', file, loc_file_dir
		#File.cp( file, loc_file_dir) 
		copy_files_to_folder([file], loc_file_dir)
	end		

 end
 
 
 m = MoveFiles.new('C:\Users\user1\Videos2', 'Y:\down\bbb\ccc\VTC - Java\Complete Java Video Tutorials Courses')
 
m.move()