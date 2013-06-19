# encoding: utf-8
require_relative 'hack_utils'
require 'whois'

w = Whois.whois('hackerschool.jp')
puts w
HackUtils.post_answer(47, :pass => w.expires_on.strftime("%Y/%m/%d"))

