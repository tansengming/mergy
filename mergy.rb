# If you've ever wanted to merge a couple of html files into one big ass file,
# this is your thing.

require 'rubygems'
require 'open-uri'
require 'hpricot'

class Mergy
  attr_reader :hpricots
  def initialize(paths)
    @paths = paths
    @uris = @paths.map{|path| URI.parse(path)}
    @hpricots = @paths.map{|url| Hpricot(open(url))}
    fix_images
  end
  
  def fix_images
    @hpricots.each do |h|
      uri = @uris[@hpricots.index(h)]
      
      (h/'img').each do |img|       
        img['src'] = "#{uri.scheme}://#{uri.host}#{img['src']}" if img['src'].match(/^\//)
      end
    end
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
