# encoding: utf-8
require_relative 'hack_utils'

=begin
  == java script in html ==
  //パスワードチェック
  function fnFormSubmit(){
  //-------------------------------------------------------------------------------------
    var id   = 'admintake8';            //IDの設定
    var pass = (Math.round(8%2)*(88951634/2))+(6660/4)*4/3+6726;    //パスワードの設定
    //-------------------------------------------------------------------------------------
    if (document.form1.id.value == id && document.form1.pass.value == pass) {
      alert('Congratulations! 正解！！');
    } else {
      alert('残念！');
    }
    document.form1.submit();
  }
=end

id   = 'admintake8'
pass = ((8%2).round*(88951634/2))+(6660/4)*4/3+6726
puts "id: #{id}, pass: #{pass}"
HackUtils.post_answer(8, :id => id, :pass => pass)
