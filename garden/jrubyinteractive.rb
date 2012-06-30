   #~ c 
    #~ def test_interactive_child_process 
      lines = [] 
      IO.popen(%q{C:\Ruby192\bin\pry-remote-em.bat}, 'r+') do |handle| 
        begin 
          while (line = handle.readline) 
            lines << line 
	    #handle.put $stdin.read
            handle.puts('foobar222') 
	    puts $stdin.read
	   #puts handle.gets()
	    handle.puts($stdin.read+"\n")
    end 
     puts 'boodd'
        rescue EOFError 
          lines << "STDIN closed" 
	end 
   puts 'boo'
      end 
      #~ assert_equal(["enter something:\n", "got: foobar\n", "STDIN closed"], lines) 
    #~ end 