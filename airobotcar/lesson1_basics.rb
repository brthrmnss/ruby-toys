class Array
    def sum
        self.inject{|sum,x| sum + x }
    end
end

def print o
	puts o.inspect
end
def putss *args
	puts args.inspect
end

 #make uniform ditribution
 def make_ud n
	 p = []
	n.times do | i | 
		p << 1/n.to_f
	end
	p
end


#puts make_ud(5).inspect
print make_ud(5)

#assume 2 cells are red, 3  are green 
#robot sense red color ... so grid goes up 
#how to incorporate into a bleivf?
# a product 
#multiply by large number .6, adn green .2, ... ratio of three times a slikely 

# we mutlipy ... but it is not a valid probabiltiy distribution 
# how to make it prob distro? devied by sum 

#often written as 
# p ( Xi | Z ) 
#probabily of each cell | after we've seen our measurement )
#posteriio distro of place xi given Z 

p =[0.2,0.2, 0.2,0.2,0.2]
@p_hit = 0.6
@p_miss = 0.2 

#meaure indifuals 
p[0]=p[0]*@p_miss; 

p = [0.2,0.2 ,0.2,0.2,0.2]
@world = ['green', 'red', 'red', 'green', 'green']
Z = 'green'
#p and Z
#outpt normalilze ditrio, q reflects normalsize product of input probability 
#and the corresponding phit of miss, in accordiance to wearhter aggree or disagree
#wnat a function ad a dat alocalizer, we call it over and over again
def sense( p, _Z)
	q = [] 
	#~ p.each_with_index do | x_i, i  | 
		#~ p[i] *= p_hit if i == z
		#~ p[i] *= p_miss if i == z
	#~ end
	p.each_with_index do | x_i, i  | 
		#if meausrement is nssame number as expected
		hit = _Z == @world[i]
		hit = (hit) ? 1 : 0
		q << p[i]*(hit*@p_hit+(1-hit)*@p_miss)
	end
	
	#normalize output of sense to add to one
	sum = q.sum()
	#q.inject{|sum,x| sum + x }
	putss 'sum', sum
	q.each_with_index do | x, i |
		q[i] = x/sum
	end
	#calcualted key function of localization 
	#meausrement updated
	q
end

puts "sense result", sense(p, Z).inspect


measurements = ['red', 'green']
#modify so any sequence of measurements after any length 
def sense_many p, measurements
	#q: we have 3 vairables here ... and they are what? 
	measurements.each do | _Z | 
		p = sense(p, _Z ) 
	end
	#put measurement back into itself
	p
end

puts "sense result 2x", sense_many(p, measurements).inspect

p = [0,0,1,0,0]
#grid id move to left or right 
def move(p, _U)
	q = []
	p.each_with_index  do | x, i |
		q << p[ (i-_U) % p.size ]
		#y minus sign? ... to shift to right, we need to find 
		#element to the left.  search for where robot 
		#has come from 
	end
	q
end
 
puts "move to right 1", move(p, 1).inspect
 
 @p_overshoot = 0.1
@p_undershoot = 0.1
 @p_exact = 0.8
 
 #looks just like psuedo code
 def move_inexact(p, _U)
	q = []
	p.each_with_index  do | x, i |
		s =@p_exact *  p[ (i-_U) % p.size ]
		s +=@p_overshoot *  p[ (i-_U-1) % p.size ]
		s +=@p_undershoot *  p[ (i-_U+1) % p.size ]
		q << s
	end
	q
end
 
 
 puts "move inexcat to right 1", move_inexact(p, 1).inspect
 
 p =  move_inexact(p, 1)
 p =  move_inexact(p, 1)
  puts "move inexcat to twice", p.inspect
  
 p = [0,0,1,0,0]
 def move_inexact_x_times p, _U, x 
	 #@p = [2] 
	x.times do  
		p =  move_inexact(p, _U)
	end
	p
end


p =  move_inexact_x_times(p, 1, 1000)
puts "move inexact 1000x times", p.inspect
 
 #try it with 2 movmeents and measurement
 #compute postierio ditro
 #first sense red, then move 1 , then sense green adn move right again
 #start with unifor prior
 p = [0.2,0.2,0.2,0.2,0.2]
 motions = [1,1]
 @world = ['green', 'red', 'red', 'green', 'green']
 measurements = ['red', 'green'] 
  measurements = ['red', 'red'] 
 def compute_postior_distro p, measurements, motions
	 measurements.each_with_index  do | x, i |
		p = sense( p, measurements[i] )
		p = move( p, motions[i] )		
	 end
	p
end
 
 p = compute_postior_distro p, measurements, motions
 puts "move inexact 1000x times", p.inspect