require 'nokogiri'

require "open-uri"

url = 'http://www.indeed.com/jobs?q=ruby+developer&l=Tampa%2C+FL'

page = Nokogiri::HTML(open(url))

puts "### Search for nodes by xpath"

page.xpath('//div[@data-tn-component="organicJob"]').each do |whole_node|

  #------- should be the main title of the post ------------
  header = whole_node.at_xpath('./h2/a')
  if (header.text).include? "Senior|senior"
    title = "======SKIP========"
  else
    title =  header.text
  end
  #-------- posted date   ------------
  post_date = whole_node.at_css("span.date").text

  #-------- post job location ------------
  post_location = whole_node.at_css("span.location").text

  #-------- post company  ------------
  post_company = whole_node.at_css("span.company").text


  #--------- post link ---------------
  href_link = header.attributes['href'].value
  whole_post_link = "www.indeed.com#{href_link}"

  puts "###"*44

  puts "Post Title:  #{title} - Date: #{post_date}"
  puts "Post Company: #{post_company} - Location: #{post_location}"
  puts "Post Link: #{whole_post_link}\n"

  puts "==="*44


end




