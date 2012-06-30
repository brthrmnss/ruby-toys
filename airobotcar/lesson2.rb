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
 
 #takes numbe rof coconuts, outputs number after 1 was given to monkey 
def f(n)
	o = n-1
	o*= 4/5.to_f
	o
end

putss 'given 96 nuts',f(96)


def f6(n)
	6.times do 
		n = f(n)
	end
	n
end


def is_int(n)
	#n.is_a? Integer
	n.to_i == n #? to_i : self
end

putss 'given 96 nuts',f6(96)
#putss 'given 96 nuts',is_int(96), is_int(98), is_int(98.0)
#return;
def find_number
	i = 0 
	not_found = true
	while not_found   
		i+=1
		#puts i 
		#puts is_int(f6(i))
		not_found = ! is_int(f6(i.to_f))
	end
	i
end
putss 'find number this works out on',find_number()

putss 5**6-4

def f(mu, sigma2, x)
	top = (x-mu)**2
	top /= sigma2
	total = Math::exp(-0.5*top)
	constant = 1/Math::sqrt(2*Math::PI*sigma2)
	total*constant
end

print f(10, 4, 10)

def update(mean1, var1, mean2, var2 ) 
	mean1 = mean1.to_f; mean2 = mean2.to_f; var1 = var1.to_f; var2 = var2.to_f
	new_mean = 1/(var1+var2)*(mean1*var2+var1*mean2)
	new_var = 1/( 1/var1 + 1/var2 )
	[new_mean, new_var]
end

print update(10,8,13,2)
print update(10,4,12,4)



def predict(mean1, var1, mean2, var2 ) 
	mean1 = mean1.to_f; mean2 = mean2.to_f; var1 = var1.to_f; var2 = var2.to_f
	new_mean = mean1+mean2
	new_var = var1+var2 
	[new_mean, new_var]
end

print predict(10,4,12,4)

measurements = [5,6,7,9,10]
motion = [1,1,2,1,1]
measurement_sig = 4
motion_sig  = 2
mu = 0 
sig = 10000

def ab(a, b )
	[a, b]
end
#~ rust = ab(4,5)
#~ putss rust
 #~ c,d = ab(4,66)
#~ putss rust
#~ putss [c,d]
def kalman_filter motion, measurements, motion_sig, measurement_sig, mu, sig 
	measurements.each_with_index do | x, i |
		mu, sig = update(mu, sig, measurements[i], measurement_sig ) 
		putss 'update: '+[mu, sig].inspect
		mu, sig = predict(mu, sig, motion[i], motion_sig ) 
		putss 'predict: '+[mu, sig].inspect
	end
end

kalman_filter motion, measurements, motion_sig, measurement_sig, mu, sig 
 
