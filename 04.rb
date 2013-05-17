# encoding: utf-8
require_relative 'hack_utils'

# extract comment in html
url = 'http://www.hackerschool.jp/hack/take4.php'
resp  = RestClient.get url
doc = Nokogiri::HTML(resp.body)
comment = doc.css('div.hero-unit').children.select{|e| e.kind_of? Nokogiri::XML::Comment }[0].text
puts comment

# extract password string and decrypt md5 hash
# http://md5.gromweb.com is md5 look up service
id_md5 = comment.match(/iD：([\w=]+)/).to_a[1]
id = RestClient.get "http://md5.gromweb.com/query/#{id_md5}"
pass_md5 = comment.match(/PASS：([\w=]+)/).to_a[1]
pass = RestClient.get "http://md5.gromweb.com/query/#{pass_md5}"
puts "id:#{id_md5} => #{id}, pass: #{pass_md5} => #{pass}"

HackUtils.post_answer(4, :id => id, :pass => pass)
