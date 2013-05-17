# encoding: utf-8
require_relative 'hack_utils'

# display user tables using SQL injection
HackUtils.post_answer(5, :id => "' OR 1=1 --", :pass => 'abcd')

# post user data
HackUtils.post_answer(5, :id => '112', :pass => 'fasd')
