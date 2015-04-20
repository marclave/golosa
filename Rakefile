require 'json'

desc "Sets up C://Golosa and the config file if not present"
task :install do
  Dir.mkdir(Dir.home + "/Golosa") unless Dir.exist?(Dir.home + "/Golosa")
  Dir.chdir(Dir.home + "/Golosa")
  File.new("config.yml", "w") unless File.exist?("config.yml")
  f = File.open("config.yml", "w")
  STDOUT.print "Add an inital language =>  "
  input = STDIN.gets.chomp
  f.write({"languages" => [input], "path" => Dir.home + "/Golosa"}.to_json)
end
