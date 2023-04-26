require 'nokogiri'
require 'open-uri'
require 'json'

# 获取 link.txt 文件的路径
link_path = File.join(__dir__, 'link.txt')

urls = File.readlines(link_path).map(&:strip)

# 爬取链接中的文本
texts = urls.map do |url|
  doc = Nokogiri::HTML(open(url))
  doc.text
end

# 合并文本
merged_text = texts.join("\n\n")

# 将文本转换为 JSON 格式并写入文件
json_data = { tvconfig: merged_text }.to_json
File.write('tvconfig.json', json_data)
