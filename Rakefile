require 'rake/clean'

CLEAN.include %w{test/meri.html test/cnn.html test/out.html}

task :default => :run

task :console do
  gems = %w{rubygems open-uri hpricot mergy}
  sh "irb -r #{gems.join(' -r ')}"
end

task :run do
  sh 'ruby mergy.rb test/meritocracy.html > test/out.html'
end

task :test do
  sh 'ruby mergy.rb test/meritocracy.html > test/meri.html'
  sh 'ruby mergy.rb -i test/url.list > test/cnn.html'
end