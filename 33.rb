require 'exifr'

path = File.join(File.dirname(__FILE__), 'take33_sozai.jpg')
puts "target: #{path}"
img = EXIFR::JPEG.new(path)

lat = img.exif[:gps_latitude]
lat = lat.zip([1, 60, 3600]).inject(0){|r, e| r += (e[0]/e[1]) }.to_f

lng = img.exif[:gps_longitude]
lng = lng.zip([1, 60, 3600]).inject(0){|r, e| r+= (e[0]/e[1]) }.to_f

puts "model: '#{img.model}'"
puts "latitude:  #{lat} #{img.exif[:gps_latitude_ref]}"
puts "longitude: #{lng} #{img.exif[:gps_longitude_ref]}"
puts "http://maps.google.com/maps?q=#{lat},#{lng}"
