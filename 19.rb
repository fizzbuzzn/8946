# encoding: utf-8
require 'date'
require_relative 'hack_utils'

def rot13(str)
  str.tr!("A-Za-z", "N-ZA-Mn-za-m")
end

url = 'http://www.hackerschool.jp/hack/take19.php?id=1&id2=99'
params = { 
  :input_id => 'abcd',
  :ymd => Date.today.strftime('%Y/%m/%d'),
  :pass => rot13('whitehackerz'),
}
HackUtils.post_answer_with_url(url, params)
