# encoding: utf-8
require_relative 'hack_utils'

=begin
  == java script in html ==
	function binary(input) {
		return input.toString(2);
	}

	//パスワードチェック
	function fnFormSubmit(){
		if (binary(parseInt(document.form1.input_id.value))==10001011110010) {
			alert('Congratulations! 正解！！'); 
		} else {
			alert('残念！');
		}
		document.form1.submit();
	}
=end

num = 0b10001011110010
puts "num: #{num.to_s(2)} -> #{num}"
HackUtils.post_answer(16, :input_id => num)
