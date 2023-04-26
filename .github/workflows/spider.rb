require 'nokogiri'
require 'open-uri'
require 'json'

# 读取链接列表
urls = File.readlines('link.txt').map(&:strip)

# 爬取链接中的文本
texts = urls.map do |url|
  doc = Nokogiri::HTML(open(url))
  doc.text
end

# 将文本转换为 JSON 格式并写入文件
json_data = { merged_text: merged_text }.to_json
File.write('merged_text.json', json_data)

