


class GenerateTimeStampClass
 
  def initialize trace = false
      @trace = trace
      puts "GenerateTimeStampClass"
  end
  
  def generate local_filename
    #http://www.tutorialspoint.com/ruby/ruby_date_time.htm
    time = Time.now
      file = "
package  outside
{
	public class TimeStamp
	{
		static public var Time :  String = '#{time.strftime("%m-%d-%Y %H:%M:%S")}'; 
	}
}      
      
      
      "
		file
    File.open(local_filename, 'w') {|f| f.write(file) }
# Save a string to a file.
#~ myStr = "This is a test"
#~ aFile = File.new("myString.txt", "w")
#~ aFile.write(myStr)
#~ aFile.close

	end

 
 
end


stamp = GenerateTimeStampClass.new()
stamp.generate(
'G:\My Documents\work\mobile\NewsAppFlex\src\outside\TimeStamp.as'
)
file = 'G:\My Documents\work\mobile\NewsApp2\src\outside\TimeStamp.as'
stamp.generate(file)