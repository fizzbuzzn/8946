# encoding: utf-8
require_relative 'hack_utils'

# set user-agent
# 'mode' is hidden input 
HackUtils.post_answer(42, {:mode => 'check'}, {'User-Agent' => '8946'})
