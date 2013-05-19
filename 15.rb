# encoding: utf-8
require 'net/http'
require_relative 'hack_utils'

# use net/http to avoid http redirect
url = 'http://www.hackerschool.jp/hack/take15_answer.php'
resp = Net::HTTP.get(URI.parse(url))
puts resp

answer = resp.match(/^(\w+)$/).to_a[1]
puts "answer: #{answer}"

HackUtils.post_answer(15, :input_id => answer)
