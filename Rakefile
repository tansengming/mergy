require 'rake/clean'

CLEAN.include %w{meri.html cnn.html out.html}

task :default => :run

task :console do
  sh 'irb -r rubygems -r open-uri -r hpricot -r mergy'
end

task :run do
  sh 'ruby mergy.rb test/meritocracy.html > test/out.html'
end

task :test do
  sh 'ruby mergy.rb test/meritocracy.html > test/meri.html'
  sh 'ruby mergy.rb -i test/url.list > test/cnn.html'
end