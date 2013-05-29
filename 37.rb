# encoding: utf-8
# 上杉暗号

enc = 'くこらかにのちかかゑきこにのらゑくのきかにかきり'
kami =  'もののふの よろいのそでを かたしきて'
sx, sy =  'まくらにちかき はつかりのこゑ'.split

iroha_table = [
  %w(い ろ は に ほ へ と),
  %w(ち り ぬ る を わ か),
  %w(よ た れ そ つ ね な),
  %w(ら む う ゐ の お く),
  %w(や ま け ふ こ え て),
  %w(あ さ き ゆ め み し),
  %w(ゑ ひ も せ す ん),
]

result = []
enc.split(//).each_slice(2) do |a,b|
  x = sx.index(a)
  y = sy.index(b)
  ch = iroha_table[x][y]
  puts "#{a},#{b} => (#{x}, #{y}) => #{ch}"
  result << ch
end
puts "encrypted: #{enc}"
puts "decrypted: #{result.join}"
