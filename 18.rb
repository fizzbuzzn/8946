# encoding: utf-8
require_relative 'hack_utils'


=begin
  == java script in html ==
	//パスワードチェック
	function fnFormSubmit(){
		/**********************************************************/
		var seikai = 'angou_value';	//暗号化した答え
		/**********************************************************/
		
		var pass = document.form1.input_id.value;
		var ans = '';
		var x = '';
		var y = '';
		//入力された文字を1文字ずつ暗号化していく
		for (i=0; i<=pass.length-1; i++){
			x=pass.charAt(i);
			y='';
			if (x=='a') {y='z'}
			if (x=='b') {y='y'}
			if (x=='c') {y='x'}
			if (x=='d') {y='w'}
			if (x=='e') {y='v'}
			if (x=='f') {y='u'}
			if (x=='g') {y='t'}
			if (x=='h') {y='s'}
			if (x=='i') {y='r'}
			if (x=='j') {y='q'}
			if (x=='k') {y='p'}
			if (x=='l') {y='o'}
			if (x=='m') {y='n'}
			if (x=='n') {y='m'}
			if (x=='o') {y='l'}
			if (x=='p') {y='k'}
			if (x=='q') {y='j'}
			if (x=='r') {y='i'}
			if (x=='s') {y='h'}
			if (x=='t') {y='g'}
			if (x=='u') {y='f'}
			if (x=='v') {y='e'}
			if (x=='w') {y='d'}
			if (x=='x') {y='c'}
			if (x=='y') {y='b'}
			if (x=='z') {y='a'}
			if (x==' ') {y='_'}
			ans+=y;
		}

		//入力された文字「ans」を暗号化し、それがangou_valueと一致したら正解		
		if (ans==seikai) {
			alert('Congratulations! 正解！！'); 
			document.form1.submit();
		} else {
			alert('残念！');
			document.form1.input_id.value = "";
			document.form1.submit();
		}
		
	}
=end

def decrypt(str)
  t1 = [('a'..'z').to_a, ' '].flatten
  t2 = [('a'..'z').to_a.reverse, '_'].flatten
  str.each_char.map{|c| t1[t2.index(c)] }.join
end

encrypted = 'angou_value'
ans = decrypt(encrypted)
puts "encrypted:'#{encrypted}' -> answer:'#{ans}'"

HackUtils.post_answer(18, :input_id => ans)
