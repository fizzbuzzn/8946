require_relative 'hack_utils'

# set device information into user-agent
url = 'http://www.hackerschool.jp/hack/take35_mobile/index.php'
headers = {
  user_agent:'DoCoMo/2.0 N901iS(c100;TB;W24H12;ser365079045783623;icc12345678901234567890)',
}
resp = RestClient.post(url, {:mode => 'chk'}, headers)
puts resp.body
doc = Nokogiri::HTML(resp.body)
password = doc.css('b').text
puts
puts "password: #{password}"

HackUtils.post_answer(35, :input_id => password)
