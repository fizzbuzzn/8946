# encoding: utf-8
require_relative 'hack_utils'

=begin
  //パスワードチェック
  function fnFormSubmit(){
    if(document.referrer=="http://www.hackerschool.jp/hack/take17_dummy_referrer/"){
      if (binary(parseInt(document.form1.input_id.value))==11010100001011) {
        self.location=document.form1.input_id.value + '.html';
      } else {
          alert('残念！');
          document.form1.submit();
      }
    }else{
      alert('残念！');
      document.form1.input_id.value = "";//パスワード初期化
      document.form1.submit();
    }
  }
=end
params = { :input_id => 0b11010100001011 }
headers = {'Referer' => "http://www.hackerschool.jp/hack/take17_dummy_referrer/"}
HackUtils.post_answer(17, params, headers)
