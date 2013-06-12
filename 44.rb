# encoding: utf-8
require_relative 'hack_utils'

# php: global_variables
# see also:
# http://php.net/manual/ja/language.variables.external.php

params = { :input_id => 'a', :pass => 'b', :success => 1 }
HackUtils.post_answer(44, params)
