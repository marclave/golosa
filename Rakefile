require 'json'

desc "Sets up C://Golosa and the config file if not present"
task :install do
  Dir.mkdir(Dir.pwd + "\\GolosaData") unless Dir.exist?(Dir.pwd + "\\GolosaData")
  Dir.chdir(Dir.pwd + "\\GolosaData")
  f = File.open("config.yml", "w")
  STDOUT.print "Add an inital language =>  "
  input = STDIN.gets.chomp
  f.write({"languages" => [input]}.to_json)
end
