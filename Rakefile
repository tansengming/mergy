task :default => :run

task :console do
  sh 'irb -r rubygems -r open-uri -r hpricot'
end

task :run do
  sh 'ruby mergy.rb -i test/url.list'
end
