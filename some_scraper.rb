require 'nokogiri'

require "open-uri"

def call(whole_node)
  whole_node.each do |whole_node|
    puts "\n"
    puts "Manga: #{title(whole_node)} - #{chapter_number(whole_node)} :::: #{release_date(whole_node)}"
    puts "Manga href: #{link(whole_node)}"
    puts "Manga All Page Version: #{all_page_link}\n\n"
    puts "==="*44
  end
end

def url
  'https://www.readmng.com/'
end

def page
  Nokogiri::HTML(open(url))
end

def whole_node
  page.xpath('//div[@class="manga_updates"]//dl[child::dt][child::dd]')
end

def header(whole_node)
  whole_node.at_xpath('./dd[preceding-sibling::dt]/a')
end

def title(whole_node)
  # should be the main title of the manga ------------
  title = header(whole_node).text.gsub(/\s+/, " ").strip

  if title.match?("hot|-")
    title = title.split(/hot|-/)[0].strip
  end
  title
end

def release_date(whole_node)
  # release date of the chapter  ------------
  whole_node.at_css("span.time").text
end

def chapter_number(whole_node)
  # The chapter number of the manga ------------
  if (/\d{1,}/).match(header(whole_node).text)
    text = header(whole_node).text.strip
    text.match(/\d{1,}/)[0]
  end
end

def link(whole_node)
  # Manga href(link)
  href_link = whole_node.at_xpath('./dd[preceding-sibling::dt]/a')
  href_link.attributes['href'].value
end

def all_page_link
  "#{link(whole_node)}/all-pages"
end

puts "Number of Manga #{whole_node.size}"
call(whole_node)
