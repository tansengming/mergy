require 'open-uri'
require 'hpricot'

class Mergy
  def initialize(filename)
    @str, @urls = '', File.read(filename).split("\n")
    @urls.each do |url|
      @str << URI.parse(url).read
    end
  end

  def to_s
    @str
  end
end

if ARGV.first == '-h'
  RDoc::usage()
elsif ARGV.length == 2 and ARGV.first == '-i'
  puts Mergy.new(ARGV[1])
else
  raise ArgumentError, RDoc::usage('usage')
end if File.basename(__FILE__) == $0
