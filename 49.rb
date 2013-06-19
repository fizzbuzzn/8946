# crypt function
require_relative 'hack_utils'

pass = "tanaka"
salt = '8946'
hash = '89B1pK00C26w6'
alnum = (?0..?z).to_a
answer =''
alnum.product(alnum).each do |ch|
  e = (pass + ch.join + salt).crypt(salt)
  puts "pass:#{pass+ch.join}, #{e} #{e==hash ? '<- matched!!' : ''}"
  if e==hash
    answer = pass+ch.join
    break
  end
end
answer += "a" # add 1 charactor
puts "password: #{answer}"
HackUtils.post_answer(49, :pass => answer)
