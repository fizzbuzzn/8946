# encoding:utf-8
require 'digest/md5'
require 'ruby-progressbar'
require 'parallel'

# brute force md5 decryption

target_md5 = 'f5373797c9d023716793c8c3a9f71970'

kana = ('あ'..'ん').to_a
kana3 = kana.product(kana, kana).map{|ks| ks.join }
progress = ProgressBar.create(:format => '%a|%B|%p%%  (%e)', :total => kana3.size)
Parallel.each(kana3, :finish => lambda { |i, item| progress.increment }) { |k|
  kana.each do |c|
    str = k+c
    if Digest::MD5.hexdigest(str) == target_md5
      progress.finish
      puts "answer: '#{str}'"
      exit
    end
  end
}
