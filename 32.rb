require 'net/http'

Signal.trap(:INT){ exit }

http = Net::HTTP.new('www.hackerschool.jp')

def calc_and_post(session_id=nil)
  http = Net::HTTP.new('www.hackerschool.jp')
  # get html
  data = http.get('/hack/take32.php').body
  ht = /h_timestamp" value="(.*?)"/.match(data).to_a[1]
  it = /i_timestamp" value="(.*?)"/.match(data).to_a[1]
  question = /question">(.*?)</.match(data).to_a[1]
  a,b,c = question.split(' x ').map{|i| i.to_i}

  # post answer
  query = "i_timestamp=#{it}&h_timestamp=#{ht}&input_id=#{a*b*c}&time_set=1"
  headers = {}
  headers[:cookie] = { 'PHPSESSID' => session_id } unless session_id.nil?
  res = http.post('/hack/take32.php',query, headers)
  res.body =~ /Time lag:(\d+)/

  time = Regexp.last_match.to_a[1]
  return time.to_i
end
arr = []
# try 100 times
100.times {|i|
  time = calc_and_post()
  arr << time
  min, max = arr.minmax
  avg = arr.inject(0){|r,v| r+v}/arr.size.to_f
  puts "[% 3d] % 6dms, min:% 6dms, max:% 6dms, avg: %.2fms" % [i, time, min, max, avg]
  #puts "[#{i}] #{time}ms, min:#{min_time} max:#{max_time} avg:#{avg}"
}

