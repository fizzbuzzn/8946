require_relative 'hack_utils'
require 'zip/zip'
require 'rmagick'

data = Zip::ZipFile.open('take13_sozai.zip'){|z| z.read(z.find_entry('take13.jpg')) }

m = Magick::Image.from_blob(data)
m.each_with_index do |img, idx|
  outname = "take13-#{idx}.png"
  puts "write '#{outname}' from take13.jpg(PSD format file)"
  img.format = 'PNG'
  img.write(outname)
end

# take13-2.png includes quiz.
# answer is RDP(Remote Desktop Protocol) port number.
HackUtils.post_answer(13, :input_no => 3389)
