# encoding: utf-8
require 'base64'
require_relative 'hack_utils'

# extract comment in html
url = 'http://www.hackerschool.jp/hack/take3.php'
resp  = RestClient.get url
doc = Nokogiri::HTML(resp.body)
puts doc.css('div.hero-unit').class
comment = doc.css('div.hero-unit').children.select{|e| e.kind_of? Nokogiri::XML::Comment }[0].text
puts comment

# extract password string and decode base64
id = comment.match(/iD：([\w=]+)/).to_a[1]
id = Base64.decode64(id).strip
pass = comment.match(/PASS：([\w=]+)/).to_a[1]
pass = Base64.decode64(pass).strip
puts "id:#{id}, pass: #{pass}"

HackUtils.post_answer(3, :id => id, :pass => pass)
