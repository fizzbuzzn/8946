# encoding: utf-8
require_relative 'hack_utils'

# get subversion file
url = 'http://www.hackerschool.jp/hack/svn/.svn/text-base/index.php.svn-base'
data = RestClient.get url
id = data.match(/ID: (\w+)/).to_a[1]
pass = data.match(/pass:\s+(\w+)/).to_a[1]
puts "id: #{id}, pass:#{pass}"

url = 'http://www.hackerschool.jp/hack/svn/index.php'
HackUtils.post_answer_with_url(url, :id => id, :pass => pass)
