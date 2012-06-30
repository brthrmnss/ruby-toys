# encoding: UTF-8
require 'rubygems'
	require 'fileutils'
class ConvertFiles
  #@tasks @task_list @task_to_PID
  def initialize trace = false
	@tasks = ''
	@task_to_PID = {}
	@task_list  = []
	@trace = trace
	puts "CloseTasks"
	@files = []
  end
  
  def get_task_list
	@tasks = run_cmd 'tasklist /NH /fo CSV'
	#task_list
	@pids = []
	@task_list  = []
	array_tasks = @tasks.split("\n")
	#puts 'length ' +array_tasks.length.to_s #@tasks.inspect
	#asd.g
	array_tasks.each do | x |
	name_split = x.split('","')
	name = name_split[0]
	name.slice!(0)
	pid = name_split[1] 
	if @trace 
		#puts 'Tasks & PID'
		puts  name + ' ' + pid  
	end
	@task_list.push( name )
	@pids.push( pid )

	end

  end
  
  def load_folder folder , sounds = [] 
	sound_folder = folder.gsub("\\", "/")
	opts = {}
	opts[:encoding] = "UTF-8"
	files = Dir.entries(sound_folder, opts)
	unicode_names = Dir.entries(sound_folder)
	skip = ['.', '..' ] 
	filenames = [] ; 
	renamed = [] ; 
	other = sound_folder.split '/'
	puts other.inspect
	puts 'o'
	other = other[0..-2]
	other.push('converted')
	other = other.join('/')
	puts other.inspect
	dest_folder = other
	write = false
	if write 
	FileUtils.rm_rf( dest_folder) if ( File.exist?( dest_folder ) ) 
	Dir.mkdir( dest_folder ) 
	end

	files.each_with_index do | file, i | 
	 
		 
		 next if skip.include?(file)
		 filename = File.basename(file)
		 ext = File.extname(file)
		 #unicode_filename = File.basename(unicode_names[i])
		 #
		 filenames.push(filename)
		 new_name = (renamed.size+1).to_s+ext
		 renamed.push(new_name)
		 #puts unicode_filename
		 if write 
		FileUtils.cp sound_folder+'/'+filename, dest_folder+'/'+new_name
		end
		#File.delete filename; 
		 entry = {}
		 
	 end
	 
	 puts filenames.inspect
	 puts renamed.inspect
	 local_filename =  'output.txt' 
	 File.open(local_filename, 'w') {|f| f.write(filenames.inspect) }
  end 
  
  def gfiles 
	return @files 
  end
  
end


if __FILE__ == $0 then
	#folder url, open all files, rename, and state old name to new name mapping in two seperate string arrays 
  x = ConvertFiles.new
 x.load_folder ('G:\My Documents\work\flex4\Mobile2\RosettaStoneBuilder_Flex\bin-debug\assets\sounds\ipa\orig')
puts x.gfiles()
end




