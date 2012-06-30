

swf = '"G:\My Documents\work\mobile3\CSSFlex3\bin-debug\CSSFlex3.swf"'
fdb = '"C:\Program Files (x86)\Adobe\Adobe Flash Builder 4.5\sdks\4.5.1\bin\fdb.exe"'
cmd = fdb + ' run '  + swf
#cmd = cmd.gsub('\\', '/')
#puts cmd 
#exec cmd
#x =exec "echo","*"
#x =exec "echo *"
#exec cmd
#puts Dir.pwd
#exec cmd;#'C:/Program Files (x86)/Adobe/Adobe Flash Builder 4.5/sdks/4.5.1/bin/fdb.exe' 
#~ exec([fdb, 
	#~ "run", 
	#~ swf]
	#~ )
#exec "irb", "g"
#system("echo", "*")
#puts x 
#(cmd)
 #output = IO.popen(cmd)
 system(cmd)