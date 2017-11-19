require 'nokogiri'

require "open-uri"

url = 'http://www.readmanga.today'

page = Nokogiri::HTML(open(url))

puts "### Search for nodes by xpath"

page.xpath('//div[@class="manga_updates"]//dl[child::dt][child::dd]').each do |whole_node|

  # should be the main title of the manga ------------
    header = whole_node.at_css('a.manga_info')
    if (header.text).include? "hot"
      title = (header.text).split(" hot")[0]
    else
      title =  header.text
    end
  # release date of the chapter  ------------
    release_date = whole_node.at_css("span.time").text

  # The chapter number of the manga ------------
    name_with_chapter = whole_node.at_xpath('./dd[preceding-sibling::dt]/a')

    if (/\d{1,}/).match(name_with_chapter.text)
      text = name_with_chapter.text
      chapter_number = text.match(/\d{1,}/)[0]
    end

  # Manga href(link)
    href_link = whole_node.at_xpath('./dd[preceding-sibling::dt]/a')
    link = href_link.attributes['href'].value
    all_page_version = "#{link}/all-pages"


    puts "Manga #{title} - #{chapter_number} :::: #{release_date}"
    puts "Manga href: #{link}"
    puts "Manga All Page Version: #{all_page_version}\n\n"



end




