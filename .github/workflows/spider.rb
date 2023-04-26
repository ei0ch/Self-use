require 'nokogiri'
require 'open-uri'
require 'json'

# 读取链接列表
# 获取 link.txt 文件的路径
link_path = File.join(__dir__, 'link.txt')

urls = File.readlines(link_path).map(&:strip)

# 爬取链接中的文本
texts = urls.map do |url|
  uri = URI.parse(url)
  doc = Nokogiri::HTML(open(uri))
  doc.text
end

# 将文本转换为 JSON 格式并写入文件
json_data = { merged_text: merged_text }.to_json
File.write('merged_text.json', json_data)

