def doit(x)
    sleep(rand(10))
    puts "Done... #{x}"
end

thingstodo = ["a","b","c","d","e","f","g"]
tasklist = []

# Set the threads going

thingstodo.each { |thing|
    task = Thread.new(thing) { |this| doit(this) } 
    tasklist << task
} 

# Wait for the threads to finish

tasklist.each { |task|
    task.join
}
