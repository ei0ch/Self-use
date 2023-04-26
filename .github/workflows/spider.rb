require 'nokogiri'
require 'open-uri'
require 'json'

# 获取 link.txt 文件的路径
link_path = File.join(__dir__, 'link.txt')

urls = File.readlines(link_path).map(&:strip)

texts = urls.map do |url|
  doc = Nokogiri::HTML(open(url))
  doc.text
end

date = Time.now.strftime('%Y-%m-%d')
time_ = Time.now.strftime('%H:%M:%S')
num_urls = urls.size

header = "爬取日期：#{date}，爬取时间：#{time_}，爬取链接数：#{num_urls}\n\n"
text = header + texts.join("\n\n")

File.write('merged_text.txt', text)

start_time = Time.now

# 爬取的代码

end_time = Time.now
elapsed_time = end_time - start_time

info = {
  '爬取日期': date,
  '爬取时间': time_,
  '爬取链接数': num_urls,
  '访问时间': elapsed_time
}

File.write('tvconfig.json', JSON.generate(info))
