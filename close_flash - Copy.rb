# To change this template, choose Tools | Templates
# and open the template in the editor.

puts "Hello World"

class Close
  @tasks
  def get_task_list
      tasks = run_cmd 'tasklist'
  end


  def kill_process pid
      result = run_cmd 'tskill ' + pid
  end


  def kill_flex task_name = ''
    #task_name = 'flashplayer_10_sa_debug.e'
    task_name = 'FlashPlayer.exe' if task_name == ''
    #Regex regex = new Regex(@"\w+|""[\w\s]*""");

	#require 'sys/proctable'
	#require 'time'

	#Sys::ProcTable.ps.each { |ps|
	#  if ps.name.include?(task_name)
	#    Process.kill('KILL', ps.pid)
	#  end
	#}

	run_cmd "taskkill /im #{task_name} /f"

    while get_task_list.include?(task_name)
       tasks = get_task_list
   #    tasks = tasks.gsub(/( |(".*?"))/, " ")
    #      tasks = tasks.gsub( /\s*,\s*/, " ")
       tasks = tasks.gsub( /\s+/, " ")
        tasks = tasks.gsub("  ", "-")

       puts tasks
       tasks = tasks.split( ' ' )
       tasks.each_with_index do | task, i |
         if task == task_name
           kill_process tasks[i+1]
           puts "killed #{tasks[i+1]}"
         end
       end

#       tasks = tasks.split( /( |(".*?"))/ )
#       tasks.each do | task |
#         puts task
#       end
    #  result = run_cmd 'tskill ' + task_name
    end

    task_name = 'adl.exe';#(2'
    #Regex regex = new Regex(@"\w+|""[\w\s]*""");

    while get_task_list.include?(task_name)
       tasks = get_task_list
   #    tasks = tasks.gsub(/( |(".*?"))/, " ")
    #      tasks = tasks.gsub( /\s*,\s*/, " ")
       tasks = tasks.gsub( /\s+/, " ")
        tasks = tasks.gsub("  ", "-")

       puts tasks
       tasks = tasks.split( ' ' )
       tasks.each_with_index do | task, i |
         if task == task_name
           kill_process tasks[i+1]
           puts "killed #{tasks[i+1]}"
         end
       end

#       tasks = tasks.split( /( |(".*?"))/ )
#       tasks.each do | task |
#         puts task
#       end
    #  result = run_cmd 'tskill ' + task_name
    end


  end

  def run_cmd cmd, trace = false

      #file = enquote file
     # cmd = "#{cmd}   > myfilev.txt"

      cmd2 =  "#{cmd} "

      #cmd = "tasklist   > myfilev.txt"
      #cmd2 =  "tasklist "

      puts 'get duration' + ' ' + cmd2  if trace
      #asdf.g
      
      
      hostname = `#{cmd2}`.chomp

      puts  'host name 1 ' +  hostname if trace
      #hostname = `#{cmd2} 2>&1`.chomp
     #	puts 'host name 2 ' +  hostname

      #	#system(cmd)
      #      File.open("myfilev.txt", "r") do |infile|
      #          while (line = infile.gets)
      #                  #puts "#{counter}: #{line}"
      #                  if line.include? 'Duration:'
      #					shouts 'duration line', line
      #                    duration = line.split('Duration: ')[1]
      #                  @duration = duration.split(', start:')[0]
      #                  end
      #               #   counter = counter + 1
      #          end
      #        end
      #
#      if hostname != nil && hostname != '' && @duration == nil
#        duration = hostname.split('Duration: ')[1]
#        @duration = duration.split(', start:')[0]
#      end

      hostname
  end
#get duration tasklist   > myfilev.txt tasklist
#get duration tasklist   > myfilev.txt tasklist   > myfilev.txt





end
g = Close.new
g.get_task_list
g.kill_flex
#g.get_task_list
#g.kill_flex 'PicasaPhotoViewer.exe'

#Close.new.get_task_list