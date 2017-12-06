require 'nokogiri'
require "open-uri"

require 'rubygems'
require 'mechanize'

agent = Mechanize.new

url = 'http://www.indeed.com'


page = agent.get(url)





puts " ##"*44

# ====== Search form =======
search_form = page.form
search_form.q = 'Ruby Developer'

# ====== Submit ==========
search_page = agent.submit(search_form)

# ====== Filter ===========
pp search_page.search('//a[@data-tn-element="jobTitle"]').map(&:text)

puts " #$ "*33


