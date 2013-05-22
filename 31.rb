# encoding: utf-8
require 'chunky_png'
# see also: http://rdoc.info/gems/chunky_png/frames
require_relative 'hack_utils'

image = ChunkyPNG::Image.from_file('take31_sozai.png')
texts = {}
image.metadata_chunks.each do |ch|
  if ch.kind_of? ChunkyPNG::Chunk::Text
    texts[ch.keyword] = ch.value
    puts "[#{ch.keyword}] #{ch.value}"
  end
end
# get answer from Comment chunk in png
pass = texts['Comment'].sub(/8946 password is /,'')
HackUtils.post_answer(31, :input_id => pass)
