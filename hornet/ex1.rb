#!/usr/bin/env ruby
require 'hornetseye'
#require 'Rmagick'
#require 'Rmagick'
#raise "Syntax: inputcolour.rb <input file> <output file>" if ARGV.size != 2
#img = Hornetseye::MultiArray.load_ubyte ARGV[0]
#img = Hornetseye::MultiArray.methods
#puts img
img = Hornetseye::MultiArray.load_ubyte "boondocks guy.jpg"
img.save_ubyte "boot.jpg"
# You can use 'img.show' instead to show the image in a window.