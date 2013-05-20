# encoding: utf-8
require_relative 'hack_utils'

# response header includes the password like 'PASSWORD(take#21): ...'
url = 'http://www.hackerschool.jp/hack/take21.php'
resp  = RestClient.get url
pass = resp.headers[:'password(take#21)']
puts "password: '#{pass}'"

HackUtils.post_answer(21, :pass => pass)
