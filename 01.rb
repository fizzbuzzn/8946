# encoding: utf-8
require_relative 'hack_utils'

url = 'http://www.hackerschool.jp/hack/take1.php'
resp  = RestClient.get url
doc = Nokogiri::HTML(resp.body)
js = doc.css('div.hero-unit/script').text
puts js

id = js.match(/id\s+=\s+'(\w+?)'/).to_a[1]
pass = js.match(/pass\s+=\s+'(\w+?)'/).to_a[1]
puts "id:#{id}, pass: #{pass}"

HackUtils.post_answer(1, :id => id, :pass => pass)
