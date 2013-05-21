require_relative 'hack_utils'
require 'zip/zip'

d = Zip::ZipFile.open('take28_sozai.zip') {|z| z.read(z.find_entry('take28_sozai.exe'))}

# extract utf-16 strings more than 5 characters
strings = d.scan(/(([\x30-\x7f\r\n\t\s]\x00){5,})/).to_a.map { |a| a[0].gsub(/\x00/,'') }
puts "---- utf-16 strings in binary ----"
p strings

puts "---- post strings as password ----"
doc=nil
begin
  dev_null = File.open(File::NULL, 'w')
  strings.each do |str|
    puts "posting '#{str}'..."
    $stdout = dev_null
    doc = HackUtils.post_answer(28, :input_id => str)
    $stdout = STDOUT
    break if doc.css('div.hero-unit h2').text =~ /^Congratulations/
  end
ensure 
  dev_null.close
end
puts doc.css('div.hero-unit').text
