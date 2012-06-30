
require 'rubygems'
require 'rack'
require 'sinatra'
require "sinatra/reloader"

set :bind, 'localhost'
set :port, 9003
STDOUT.sync = true
include ExecHelpers

	get '/crossdomain.xml' do
		file = "<?xml version=\"1.0\"?>
			<!DOCTYPE cross-domain-policy SYSTEM \"http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd\">
			<cross-domain-policy>
			<allow-access-from domain=\"*\" />
			</cross-domain-policy> "
		end
	get '/hello' do
		file = "yo"
		require 'pry'
		binding.pry
	end
		
	#http://http://localhost:9001/update_dir?command_only=true&test=true
	get '/update_dir' do
	 #return ''
		dir = params['dir']
		include_dirs = params['include_dirs']
		require 'json'
		include_dirs = JSON.parse( include_dirs )
		include_dirs.each do | x | 
			x.gsub!('.', '/' )
		end
		#puts include_dirs
		#puts include_dirs.class
		#asdf.g
		#puts q 'yo'
		command_only = params_tf( params['command_only'] )
		test = params_tf params['test']
		test = true if params['test'] == nil 
		putss 'test?', test 
		files_only = params_tf params['files_only']
		
		
		
		#test = false
		#putss 'cm', command_only,  params['command_only']
		puts command_only
		utils = FlexUtils.new(dir, nil, command_only, test,include_dirs)
		if files_only 
			files = utils.update_folder( true)
			return files.to_json
		end
		filename = utils.update_folder 
		return "" if filename == ''
		if command_only 
			return filename 
		end
		file = File.open(filename, 'r')
		return "" if file.mtime < (Time.now() -1*60)
			
		content = file.read()
		#content_type 'application/octet-stream'
		content
		send_file(filename, :filename =>filename, :type => "application/octet-stream")
		#return 'g'
	end
	
	
puts "ran"
 