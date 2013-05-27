require_relative 'hack_utils'
require 'tempfile'
require 'origami'
require 'zip/zip'

include Origami

d = Zip::ZipFile.open('take36.zip') {|z| z.read(z.find_entry('take36.pdf'))}
tf = Tempfile.new('8946')
tf.write d
tf.pos=0
pdf = PDF.read tf.path

# extract entry javascript
objects = pdf.objects
js = objects.find_all{|obj| obj.is_a?(Dictionary) and obj[:S] == :JavaScript }
js.each do |obj|
    entity = (obj[:JS].is_a?(Reference) ? obj[:JS].solve() : obj[:JS])
    script = entity.is_a?(Stream) ? entity.decode!.data : entity
    puts script
end

# extract annotation subject
annots = objects.find_all{|obj| obj.is_a?(Annotation) }
second_js, encrypted = annots.map {|a| a[:Subj].solve.data }

puts '-' * 20
puts second_js

puts '-' * 20
decrypt = encrypted.split(' ').map{|c| "%c" % (c.to_i(16) ^ 189) }.join
puts decrypt

pass = decrypt.match(/password is '(.*)'/).to_a[1]

puts pass
HackUtils.post_answer(36, :input_id => pass)
