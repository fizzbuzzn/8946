# ADFGVX cipher
# see also:
#   http://en.wikipedia.org/wiki/ADFGVX_cipher
require 'pp'

class Adfgvx
  COODINATE = ['A', 'D', 'F', 'G', 'V', 'X']
  def initialize(key)
    @key = key
    @map = Hash.new{|h, k| h[k] = {} }
  end

  def trans_key
    if @trans_key.nil?
      key_arr = @key.split(//).uniq
      @trans_key = key_arr.map{|k| key_arr.sort.index(k)}
    end
    @trans_key
  end

  def puts_map
    puts "   " + COODINATE.join(' ')
    COODINATE.each do |x|
      vals = COODINATE.map {|y| @map[x][y].nil? ?  "-" : "#{@map[x][y]}" }
      puts "#{x}: #{vals.join(' ')}"
    end
  end

  def fill_map(plain, encrypted)
    reversed = reverse_adfgvx(encrypted)
    coord = reversed.scan(/../) # extract each 2bytes
    coord.zip(plain.split(//)).each do |xy, ch|
      x,y= xy.split(//)
      @map[x][y] = ch
    end
  end

  def reverse_adfgvx(cyphier)
    row_size = cyphier.size / trans_key.size
    rev =[]
    #c=0
    trans_key.each_with_index do |k, idx|
      rev[idx] = cyphier[idx*row_size, row_size]
      # ugh!
      # if cyphier.size > (row_size*trans_key.size + idx)
      #   rev[idx] += cyphier[row_size*trans_key.size + idx]
      #   c+=1
      # end
      #puts "[#{idx}] #{rev[idx]}"
    end
    #p rev
    rev2 = []
    trans_key.each_with_index do |k,idx|
      rev2[idx] =rev[k]
    end
    #p rev2
    tmp = rev2.map{|row| row.split(//) }
    return tmp.transpose.flatten.join
  end

  def decrypt(encrypted)
    rev = reverse_adfgvx(encrypted)
    str = ''
    rev.scan(/../).each do |key|
      x,y = key.split(//)
      str += @map[x][y]
    end
    str
  end

  def decrypt_with_transpoted(encrypted)
    rev = reverse_adfgvx(encrypted)
    str = ''
    rev.scan(/../).each do |key|
      x,y = key.split(//)
      str += @map[y][x] # use transpoted value!
    end
    str
  end
end

dec = Adfgvx.new('hackerschool')

# hint1
plain = 'whitehackerzto8946'
encrypted = 'VDAXDGGGAFFVVAVAGAFXVXAAVDVXVFFVFXFG'
dec.fill_map(plain, encrypted)
puts "'#{plain}' -> '#{encrypted}'"
dec.puts_map
puts

# hint2
plain = 'abcdelmnos12345678'
encrypted = 'FFGVGDGXFVVAAAAGDGXXVAVGXAFXXGDXAGVD'
dec.fill_map(plain, encrypted)
puts "'#{plain}' -> '#{encrypted}'"
dec.puts_map
puts

question = 'GGAGAXVAGGVAGAVAFAGGFGVAAFGAGAGGGDFAAGAGDADVFGAXAAFAGD'
answer = dec.decrypt_with_transpoted(question)
puts "decrypted: '#{answer}'"
