# encoding: utf-8
require_relative 'hack_utils'
require 'cgi'
require 'v8'

url = 'http://www.hackerschool.jp/hack/take26.php'
resp  = RestClient.get url
doc = Nokogiri::HTML(resp.body)
js = doc.css('div.hero-unit/script').text
puts '-------- js ---------'
puts js

# unpack dean edward packer using javascript interpreter
ctx = V8::Context.new
ctx[:eval] = lambda{|ctx, arg| arg }
unpacked = ctx.eval(js)
puts '-------- unpacked js ---------'
puts unpacked

hint = unpacked.match(/<div.*?>(.*)<\/div>/).to_a[1]
puts '-------- hint ---------'
puts hint

hint = CGI.unescapeHTML(hint)
puts " -> #{hint}"

# translate by using google translate service
puts '-------- translation ---------'
puts "http://translate.google.co.jp/#ru/en/#{CGI.escape(hint)}"
