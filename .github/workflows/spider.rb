require 'nokogiri'
require 'open-uri'

# 读取链接列表
urls = File.readlines('link.txt').map(&:strip)

# 爬取链接中的文本
texts = urls.map do |url|
  uri = URI.parse(url)
  doc = Nokogiri::HTML(open(uri))
  doc.text
end

# 合并文本并写入文件
merged_text = texts.join("\n\n")
File.write('merged_text.txt', merged_text)
