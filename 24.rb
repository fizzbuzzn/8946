require 'cgi'
require 'digest/sha2'
require 'nokogiri'
require 'rest-client'

class WhiteCafe
  @@verbose = false

  def self.verbose=(bool)
    @@verbose = bool
  end

  BASE_URL = "http://whitecafe.moe.hm/books.php"
  def initialize(user, pass, base_url=BASE_URL)
    @user = user
    @pass = pass
    @url = base_url
  end

  def decode(a)
    b = a.gsub(/%([0-9A-F]{2})/){ "%c" % $1.to_i(16) }
    b.unpack("c*").map{|c| c < 0x50 ? c + 47 : c - 47 }.pack('c*').gsub('Z', ' ')
  end

  def encode(a)
    arr = a.split(' ')
    arr.map!{|str| str.unpack("c*").map{|c| c > 0x50 ? c - 47 : c + 47 }.pack('c*') }
    arr.map{|str| CGI.escape(str)}.join('+')
  end

  def password_hash(pass)
    hash = pass
    10000.times{ hash = Digest::SHA256.hexdigest(hash) }
    hash
  end

  def member_id
    return @member_id unless @member_id.nil?

    ret = query("SELECT member_id FROM members WHERE user = '#{@user}' LIMIT 1")
    if ret.empty?
      @member_id = add_member(@user, @pass)
    else
      @member_id = ret[0][0].to_i
    end
  end

  def query(str)
    puts "query: #{str}" if @@verbose

    url = "#{@url}?sql=#{encode(str)}"
    resp = RestClient.get url, :referer => @url
    doc = Nokogiri::HTML(resp.body)
    ret = []
    doc.css('table tbody tr').each do |tr|
      ret << tr.css('td').map { |td| td.text.strip.sub(/^BK-/,'') }
    end
    ret
  end

  def show_tables
    query("show tables").map{|row| row[0]}
  end

  def describe_table(table)
    query("describe #{table}").map{|row| row.pop; row }
  end

  # @return [Fixnum] return member_id
  def add_member(user, pass)
    # find valid id
    q = "SELECT member_id FROM members"
    ids = query(q).map{|row| row[0].to_i }.sort
    id = 1
    id = rand(65536) while ids.include?(id)
    hash = password_hash(pass)
    # add member
    q = "INSERT INTO members (member_id, user, password) VALUES (#{id}, '#{user}', '#{hash}')"
    query(q)
    return id
  end

  def add_history(history_id, book_id)
    q = "INSERT INTO history (history_id, member_id, book_id, date) VALUES (#{history_id}, #{member_id}, #{book_id}, #{Time.now.to_i})"
    query(q)
  end

  def not_scrap_books(limit=100)
    q = "SELECT book_id FROM books WHERE scrap = 0 AND date < #{Time.now.to_i} LIMIT #{limit}"
    query(q).map{|row| row[0].to_i }
  end

  def get_points(num = 100)
    history_ids = query("SELECT * FROM history").map{|r| r[0].to_i }
    empty_history = (1..10000).to_a - history_ids
    books_id = not_scrap_books(num)
    empty_history.each do |h_id|
      add_history(h_id, books_id.pop)
      break if books_id.empty?
    end
  end

  def current_points
    query("SELECT point FROM points WHERE member_id = #{member_id}")[0][0].to_i
  end
end

if __FILE__ == $0
  user = '2951672Cfvk'
  password = 'Wea2Tv3r'

  WhiteCafe.verbose = true
  wc = WhiteCafe.new(user, password)

  p wc.show_tables
  p wc.describe_table('books')

  #wc.get_points
  puts "User:#{user}, Pass:#{password}"
  puts "current points: #{wc.current_points}"
end
