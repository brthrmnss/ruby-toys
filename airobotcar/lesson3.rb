class Array
    def sum
        self.inject{|sum,x| sum + x }
    end
end

class RandomGaussian
  def initialize(mean, stddev, rand_helper = lambda { Kernel.rand })
    @rand_helper = rand_helper
    @mean = mean
    @stddev = stddev
    @valid = false
    @next = 0
  end

  def rand
    if @valid then
      @valid = false
      return @next
    else
      @valid = true
      x, y = self.class.gaussian(@mean, @stddev, @rand_helper)
      @next = y
      return x
    end
  end

  private
  def self.gaussian(mean, stddev, rand)
    theta = 2 * Math::PI * rand.call
    rho = Math.sqrt(-2 * Math.log(1 - rand.call))
    scale = stddev * rho
    x = mean + scale * Math.cos(theta)
    y = mean + scale * Math.sin(theta)
    return x, y
  end
end

class RandomGaussian2
  def initialize(mean = 0.0, sd = 1.0, rng = lambda { Kernel.rand })
    @mean, @sd, @rng = mean, sd, rng
    @compute_next_pair = false
  end

  def rand
    if (@compute_next_pair = !@compute_next_pair)
      # Compute a pair of random values with normal distribution.
      # See http://en.wikipedia.org/wiki/Box-Muller_transform
      theta = 2 * Math::PI * @rng.call
      scale = @sd * Math.sqrt(-2 * Math.log(1 - @rng.call))
      @g1 = @mean + scale * Math.sin(theta)
      @g0 = @mean + scale * Math.cos(theta)
    else
      @g1
    end
  end
end

module PrintHelpers
	def print o
	puts o.inspect
	end
	def putss *args
	puts args.inspect
	end
end
include PrintHelpers

class Robot
	attr_accessor :x, :y, :orientation, :sense_noise, 
	:world_size
	#attr_reader :x, :y, :orientation, :sense_noise
	include Math

	
	def initialize()
		@landmarks = [[20.0, 20.0],
		  [80.0, 80.0],
		  [20.0, 80.0],
		  [80.0, 20.0]]
		@world_size = 100.0
		
		#puts rand(), @world_size; 
		@x = rand() * @world_size; 
		@y = rand() * @world_size; 
		@orientation = rand() *2.0*PI
		@forward_noise = 0.0
		@turn_noise = 0.0
		@sense_noise = 0.0
	end
	
	def set(new_x, new_y, new_orientation)
            if new_x < 0 or new_x >= @world_size
                raise ValueError, 'X coordinate out of bound'
            end
	    if new_y < 0 or new_y >= @world_size
                raise ValueError, 'Y coordinate out of bound'
            end
	    if new_orientation < 0 or new_orientation >= 2 *PI
                raise ValueError, 'Orientation must be in [0..2pi]'
	    end
            @x = new_x.to_f
            @y = new_y.to_f
            @orientation = new_orientation.to_f	

	# to_s
	end
    
	def to_s
		"[x=#{@x} y=#{@y} heading=#{@orientation}]"
	end
	
	def set_noise(  new_f_noise, new_t_noise, new_s_noise)
		# makes it possible to change the noise parameters
		# this is often useful in particle filters
		@forward_noise = new_f_noise.to_f
		@turn_noise = new_t_noise.to_f
		@sense_noise = new_s_noise.to_f
	end
	
	def gaussian(mu, sigma, x)   
		# calculates the probability of x for 1-dim Gaussian with mean mu and var. sigma
		#putss   'input', mu, sigma, x
		#putss    ((mu - x) ** 2) , ((sigma ** 2) / 2.0) , sqrt(2.0 * PI * (sigma ** 2))
		return exp(- ((mu - x) ** 2) / (sigma ** 2) / 2.0) / sqrt(2.0 * PI * (sigma ** 2))
	end
	
	def measurement_prob( measurement)
            # calculates how likely a measurement should be
            # which is an essential step
		prob = 1.0;
		@landmarks.each_with_index  do | x, i | 
		    dist = sqrt((@x - @landmarks[i][0]) ** 2 +  (@y - @landmarks[i][1])** 2 )
		    #prob *= self.Gaussian(dist, @sense_noise, measurement[i])
		    #putss dist, gaussian(dist, @sense_noise, measurement[i]), measurement[i]
		    prob *= gaussian(dist, @sense_noise, measurement[i])
		end
		return prob
		#Q: what is the pupros eof the random sausian ... 
	end
	
	#~ def move(  x, y, orientation = 0 )
		#~ @x += x.to_f
		#~ @y += y
		#~ @orientation += orientation.to_f
	#~ end
	
	def move(  turn, forward)
		if forward < 0 
		    raise 'Robot cant move backwards ' + forward.to_s         
		end
		# turn, and add randomness to the turning command
		# puts 'o:'+(@orientation/PI).to_s
		@orientation = @orientation + turn.to_f + random_gauss(0.0, @turn_noise)
		 
		
		@orientation = @orientation % ( 2 *PI )
		# puts 'o:'+(@orientation/PI).to_s
		# move, and add randomness to the motion command
		dist =  forward.to_f + random_gauss(0.0, @forward_noise)
		@x = @x + (cos(@orientation) * dist)
		@y = @y + (sin(@orientation) * dist)
		@x = @x % world_size    # cyclic truncate
		@y = @y % world_size
	       
		# set particle
		res = Robot.new()
		res.set(@x, @y, @orientation)
		res.set_noise(@forward_noise, @turn_noise, @sense_noise)
		return res
	end
	
	def sense()
		z = [] 
		@landmarks.each_with_index  do | x, i | 
		#puts 'b',@x - @landmarks[i][0]
			#xy = 
		    distance = sqrt((@x - @landmarks[i][0]) ** 2 + (@y - @landmarks[i][1])** 2 )
		    #prob *= self.Gaussian(dist, @sense_noise, measurement[i])
		    #putss i.to_s+': '+distance.to_s, RandomGaussian2.new(0.0, @sense_noise).rand(), @sense_noise
		    
		    distance += random_gauss(0.0, @sense_noise) 
		    z << distance
	    end
	    z
	end
	
	def random_gauss( mean, std )
		RandomGaussian2.new(mean, std).rand()
	end
	
end

#~ myrobot = Robot.new()
#~ myrobot.set(10,10,0)
#~ print myrobot
#~ myrobot.move(10,10 )
#~ print myrobot

#~ print myrobot.sense( )
r = Robot.new()
r.set_noise(5,0.1,5)
print r.set(30,50,Math::PI/2)
print r.move(-Math::PI/2, 15)
print r.sense( )
print r.move(-Math::PI/2, 10)
print r.sense( )


def make_particles n
	p = [] 
	n.times do | i | 
		particle = Robot.new()
		particle.set_noise(0.05,0.05, 5)
		p << particle #robots become particles
	end
	p
end


def move_particles particles, turn, move
	particles.each do | x | 
		x.move(turn, move ) 
	end
	particles
end


p = make_particles 1000
print p.size 
p = move_particles p, 0.1, 5
print p.size 
#print p 

measurement = [0,0,0,0]
def find_weight particles, measurement
	weights = [] 
	particles.each do | p | 
		weights  << p.measurement_prob(measurement ) 
	end
	weights
end

w = find_weight p, measurement


#~ def find_weight particles, measurement
	#~ puts 'lol'
#~ end

def resample particles, weights
	w = weights
	p = particles
	n= weights.size
	p3 = [] 
	index = rand()*n
	beta = 0.0
	mw = w.max()
	n.times do 
		beta +=  rand()*2*mw
		while beta > w[index]
			beta -= w[index]
			index = (index + 1)% n
		end
		p3 << p[index]
	end
	p3
end

p = resample( p, w ) 

def resample_repeat p, w, t
	t.times do 
		p = resample p, w
	end
	p
end

#p = resample_repeat( p, w, 10 ) 

def eval(r, p)
    sum = 0.0;
    world_size = r.world_size
    p.each_with_index do | particle, i | # calculate mean error
        dx = (p[i].x - r.x + (r.world_size/2.0)) % r.world_size - (r.world_size/2.0)
        dy = (p[i].y - r.y + (r.world_size/2.0)) % r.world_size - (r.world_size/2.0)
	#putss 'dxy', dx, dy
        err = Math::sqrt(dx * dx + dy * dy)
        sum += err
    end
    return sum / p.size.to_f
end
# 
#print w
print eval(r , p )

exit()
return
 