require 'rubygems'
require 'open-uri'
require 'hpricot'

class Mergy
  def initialize(paths)
    @paths = paths
    @hpricots = @paths.map{|url| Hpricot(open(url))}
  end
  
  def self.from_list(filename)
    new(File.read(filename).split("\n"))
  end
  
  def self.from_cmdline(files)
    new(files.to_a)
  end
  
  def to_s
    @str = ''
    @str << doc_type
    @str << '<html>'
    @str << '<head>'
    @str << @hpricots.map{|h| h.at('head').inner_html}.join
    @str << '</head>'
    @str << '<body>'
    @str << @hpricots.map{|h| h.at('body').inner_html}.join
    @str << '</body></html>' 
  end
  
  def doc_type
    if doc = @hpricots.first and el = doc.children.select{|e| e.class == Hpricot::DocType }
      el.to_s
    else
      '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
    end
  end
end

if ARGV.first == '-h'
  RDoc::usage()
elsif ARGV.length == 2 and ARGV.first == '-i'
  puts Mergy.from_list(ARGV[1])
elsif ARGV.length > 0 and ARGV.first != '-i'
  puts Mergy.from_cmdline(ARGV)
else
  raise ArgumentError, RDoc::usage('usage')
end if File.basename(__FILE__) == $0
