require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'yaml'

agent = Mechanize.new

page = agent.get('http://www.indianrail.gov.in/train_Schedule.html')

#pp page

google_form = page.form('trn_num')

trnnum = 14553

puts("================================================")

google_form.lccp_trnname = '14553'

#google_form.print
#pp google_form
puts(page.class)
puts("================================================")
page = agent.submit(google_form)
puts(page.class)
npage = Nokogiri::HTML(page.content)
#puts(page.content)
puts(npage.class)
tables = npage.css("table")
puts(tables.length)
#puts(tables[5].content)
#puts(tables[24].content) #Contains the table schedule

#puts(tables[23].content) # Contains Base info of days, from to extra

#puts("table 23====================")
#puts(tables[23].content)

# puts("End table 23====================")

#  ========== 
#  = Banner = 
#  ========== 
html_data = tables[23]
puts(html_data.class)
html_doc = Nokogiri::HTML(tables[23].to_s())
puts(html_doc.class)

rows = html_doc.css("tr")
puts(rows.length)

str1 = rows[0].content
arr1 = str1.split("\n")
puts(arr1.class)
puts(arr1.length)
#puts(arr1.to_json)
#puts(arr1.to_yaml)
#puts(rows[0].content)  #Has Header columns
puts(rows[1].content)  #Has data columns

puts(Dir.pwd)
filename = trnnum.to_s() + ".txt"
aFile = File.new(filename,"w")
aFile.syswrite(tables[23].content)
aFile.syswrite(tables[24].content)
aFile.close()

puts('End================================================Done')
#pp page