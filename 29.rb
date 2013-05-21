require 'chunky_png'
require_relative 'hack_utils'

image = ChunkyPNG::Image.from_file('take29_wh.png')

vals  = []
# get first lines
image.width.times {|i|
  val = image[i, 0]
  vals << (val & 0x000000ff ) # extract alpha channel values
}

data = vals.map{|c| "%c" % c }.join
puts '-- alpha channel data to ascii --'
puts data
# Password is zteWSR47sk.
pass = data.match(/Password is (\w+)./).to_a[1]

HackUtils.post_answer(29, :input_id => pass)
