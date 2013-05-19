# encoding: utf-8
require_relative 'hack_utils'

=begin
  == java script in html ==
	var now = new Date();
	var seconds = now.getSeconds();//秒数取得

	function fn_timer(){
		now = new Date();
		seconds = now.getSeconds();
		document.getElementById("sec").innerHTML = seconds;//秒数を画面に表示
		setTimeout('fn_timer()',1);
	}

	//入力されたナンバーのチェック
	function fn_check(){
		//入力されたナンバー
		var input_no = document.form1.input_no.value;
		
		var answer = ( ( seconds * ( seconds - 1 ) ) / 2 )*(input_no % 2);
		
		if (answer==990) {
			document.form1.answer_val.value = seconds;
		}
		document.form1.submit();
	}
=end

# input_num is odd number
# ..*(input_no % 2)
num = 1
# second = 45
# 45 * 44 / 2 == 990
# answer = ( ( seconds * ( seconds - 1 ) ) / 2 )
second = 45

HackUtils.post_answer(9, :answer_val => second, :input_no => num)
