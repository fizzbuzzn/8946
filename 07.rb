# encoding: utf-8
require_relative 'hack_utils'

url = 'http://www.hackerschool.jp/hack/take7.php'
params = { :login => nil }
cookies ={ 'take7_login_status' => '1' } # set login status in cookie
HackUtils.post_answer(7, params, { :cookies => cookies })
