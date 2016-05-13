require 'mechanize'

agent = Mechanize.new
$site = ARGV[0] || 'https://www.zhihu.com'
root_page  = agent.get($site + '/collection/30256531?page=1')

root_page.links_with(href: /question\/(\d+)$/).map(&:href).each do |path|
  dir  = path.gsub('/', '')
  system("mkdir -p #{dir}")

  page = agent.get($site + path)
  puts "Downloading page ==> #{path}"
  page.images.map(&:to_s).each do |img_url|
    puts "\tImage ==> #{img_url}"
    system("wget #{img_url} -P #{dir}")
  end
end

