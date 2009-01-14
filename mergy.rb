require 'open-uri'
require 'hpricot'

class Mergy
  def initialize(filename)
    @urls = File.read(filename).split("\n")
    @hpricots = @urls.map{|url| Hpricot(open(url))}
  end

  def to_s
    @str = ''
    @str << '<html>'
    @str << '<head>'
    @str << @hpricots.map{|h| h.at('head').inner_html}.join
    @str << '</head>'
    @str << '<body>'
    @str << @hpricots.map{|h| h.at('body').inner_html}.join
    @str << '</body></html>' 
  end
end

if ARGV.first == '-h'
  RDoc::usage()
elsif ARGV.length == 2 and ARGV.first == '-i'
  puts Mergy.new(ARGV[1])
else
  raise ArgumentError, RDoc::usage('usage')
end if File.basename(__FILE__) == $0
