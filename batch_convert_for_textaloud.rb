=begin
 #takes an input folder
 converts all mp3 to txt files with the file as the word name 
 now you can input into textAloud
=end
#require 'RMagick'
require_relative "exec_helpers.rb"
class ProcessImages
	include ExecHelpers
  attr_accessor :folder,:image_source_folder
  def initialize( dir = ''   )
	  @newline = "\n"
	  @directory = 'G:\My Documents\work\mobile3\RosettaStoneElips2\src\assets\units\RS English 1\Unit 1\L1.3'
	  @directory = dir if dir != ''
  end
    def get_list_of_audio_files
    @files = get_files_in_folder(@directory)
    
    time_stamp = Time.now.to_s
    time_stamp = time_stamp.gsub(':', '_' )
    dest_folder = @directory+'/'+ time_stamp
    make_path_if_needed dest_folder
    putss 'files' ,@files.length, 'dir', @directory
    #return
    includes = ['.json', '.jpg', '.png' ]
    cleaned_files = []
	@files.each do | file |
		next if included_in_string( file, includes ) 
		filename = File.basename(file)
		contents = filename.gsub(File.extname(file) , '')
		puts filename
		puts contents
		#next
		write_file(dest_folder + '/'+ contents+'.txt', contents ) 
		cleaned_files << file 
	end
 

    puts time_stamp.inspect
    
    #copy_files_to_folder @files, @directory+'/'+ time_stamp
    #resize_each_file
  end
  def get_list_of_files
    @files = get_files_in_folder(@directory)
    putss 'files' ,@files.length, 'dir', @directory
    return
    includes = ['.json', '.mp3' ]
    cleaned_files = []
	@files.each do | file |
		next if included_in_string( file, includes ) 
		
		cleaned_files << file 
	end
    @files= cleaned_files; 
    @files.each do | file |
	#    puts file 
	end
    puts "num files #{@files.length}"
    time_stamp = Time.now.to_s
    time_stamp = time_stamp.gsub(':', '_' )
    puts time_stamp.inspect
    
    copy_files_to_folder @files, @directory+'/'+ time_stamp
    resize_each_file
  end

  def rip_files
    @files = get_files_in_folder(@directory)
    includes = ['.json', '.jpg', '.sfk', '.png'  ]
    cleaned_files = []
	@files.each do | file |
		next if included_in_string( file, includes ) 
		filename = File.basename( file ) 
		puts filename
		cleaned_filename = filename.delete('^A-Za-z0-9.')
		#filenname.lowercase
		#next if   cleaned_files.include?( cleaned_filename ) 
		#next if   cleaned_files.include?( filename ) 
		text_only = cleaned_filename.gsub('.mp3', '').downcase
		#puts text_only
		puts '2 ' + filename
		text_file = filename.gsub('.mp3', '.txt')
		text_file = text_file.gsub('.txt.txt', '.mp3.txt')
		write_text( text_file, text_only, @directory+'/text' )
		cleaned_files << filename 
	end
    @files= cleaned_files; 
    @files.each do | file |
	 puts file 
	end
    puts "num files #{@files.length}"
    time_stamp = Time.now.to_s
    time_stamp = time_stamp.gsub(':', '_' )
    puts time_stamp.inspect
    
    #copy_files_to_folder @files, @directory+'/'+ time_stamp
    #resize_each_file
  end
  
def included_in_string( file, includes ) 
	
			includes.each do | remove |
		return true if  file.include?(remove)  
		end	
	return false 
end
def resize_each_file
	#puts   @files[0,1].inspect
	#return
	#@files = @files[0,1]; #decrease size for test
	@files.each do | file |
		#cmd = "convert #{q file}   -resize 170x133^   -gravity center -extent 170x113  #{q file}"
		#the above version did not work right it was cropping things up
		#http://www.imagemagick.org/Usage/resize/#resize 
		cmd = "convert #{q file} -resize 170x133 -extent 170x113  #{q file}"
		call cmd
	end	
end


    
end
 
 
if __FILE__ == $0 #then
	dir = 'G:\My Documents\work\flex4\Mobile2\RosettaStoneBuilder_Flex\bin-debug\assets\units\RS English 1\Unit 1\L1.2\plural' 
	dir = 'G:\My Documents\work\mobile3\RosettaStoneElips2\src\assets\units\RS English 1\Unit 1\L1.3\backup mp3'
	exe = ProcessImages.new(dir)#'G:\My Documents\work\mobile3\EvernoteTestElips\src\com\evernote\edam\userstore\UserStoreImpl.as')
	 exe.get_list_of_audio_files()
	#exe.rip_files()
end
 
 
=begin
  convert terminal.gif    -resize 64x64^ \
          -gravity center -extent 64x64  fill_crop_terminal.gif
          
   convert "_They_ have red flowers _She They He I_.jpg.jpg"    -resize 170x133^   -gravity center -extent 170x113  flowers.jpg
   convert "The bicycles are red..jpg"    -resize 170x133^   -gravity center -extent 170x113  bicycles.jpg
                   
           

=end