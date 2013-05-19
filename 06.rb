# encoding:utf-8
require 'base64'
require 'open-uri'
require_relative 'hack_utils'

data = RestClient.get 'http://www.hackerschool.jp/hack/take6/htpasswd.txt'
id, pass64 = data.strip.split(':')
pass = Base64.decode64(pass64)
puts "id: #{id}, pass: #{pass}(#{pass64})"

# post with basic authentication
url = 'http://www.hackerschool.jp/hack/take6/'
result = open(url, :http_basic_authentication => [id, pass]).read
doc = Nokogiri::HTML(result)
puts doc.css('div.hero-unit').text
