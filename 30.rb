# encoding: utf-8
require 'prime'
require_relative 'hack_utils'

n = 8946
prime = Prime.take(n).last # get nth prime number
puts "Prime(#{n}) => #{prime}"

HackUtils.post_answer(30, :input_id => prime)
