task :build do
  print "Building CoffeeScript files..."
	`bundle exec coffee -c -b -o dist/js src/js`
	puts " [Done]"
end

task :watch do
  Process.fork do
    exec("bundle exec coffee -w -b -c -o dist/js src/js")
  end
  Process.waitall
end
