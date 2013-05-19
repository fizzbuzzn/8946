# encoding: utf-8
require_relative 'hack_utils'

headers=  {'Referer' => 'http://www.hackerschool.jp/hack/take14.php' }
HackUtils.post_answer(14, { :input_id => '8946' }, headers)
