require 'rest-client'
require 'nokogiri'

module HackUtils
  @@session_id = nil

  BASE_URL = 'http://www.hackerschool.jp/hack/'

  def self.session_id=(phpssid)
    @@session_id = phpssid
  end

  def self.post_answer(no, params={}, other_headers={})
    url = BASE_URL + "take#{no}.php"
    self.post_answer_with_url(url, params, other_headers)
  end

  def self.post_answer_with_url(url, params={}, headers={})
    cookies = {}
    cookies['PHPSESSID'] = @@session_id unless @@session_id.nil?
    cookies.merge! headers[:cookies] if headers.has_key? :cookies
    headers[:cookies] = cookies
    resp  = RestClient.post url, params, headers
    doc = Nokogiri::HTML(resp.body)
    puts doc.css('div.hero-unit').text
  end
end
