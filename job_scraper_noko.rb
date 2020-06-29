require 'nokogiri'

require "open-uri"

def call(whole_node)
  whole_node.each do |whole_node|
    puts "\n"
    puts "Post Title:  #{title(whole_node)} - Date: #{post_date(whole_node)}"
    puts "Post Company: #{post_company(whole_node)} - Location: #{post_location(whole_node)}"
    puts "Post Link: #{post_link(whole_node)}\n\n"
    puts "==="*44
  end
end

def url
  'http://www.indeed.com/jobs?q=ruby+developer&l=Tampa%2C+FL'
end

def page
  Nokogiri::HTML(open(url))
end

def whole_node
  page.xpath('//div[@data-tn-component="organicJob"]')
end

def header(whole_node)
  whole_node.at_xpath('./h2/a')
end

def title(whole_node)
  if header(whole_node).text.include? "Senior|senior"
    "======SKIP========"
  else
    header(whole_node).text.strip
  end
end

def post_date(whole_node)
  whole_node.at_css("span.date").text
end

def post_location(whole_node)
  whole_node.at_css("span.location").text
end

def post_company(whole_node)
  whole_node.at_css("span.company").text.strip
end

def post_link(whole_node)
  href_link = header(whole_node).attributes['href'].value
  "www.indeed.com#{href_link}"
end


puts "Number of Posts #{whole_node.size}"
call(whole_node)