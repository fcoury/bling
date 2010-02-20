require 'rake'

Gem::Specification.new do |s|
  s.name     = "bling"
  s.version  = "0.1.1"
  s.date     = "19Feb2010"
  s.summary  = "bling bling gem management"
  s.email    = "theath@gmail.com"
  s.homepage = "http://github.com/terrbear/bling"
  s.description = "drop in replacement for bundler"
  s.has_rdoc = false
  s.authors  = ["Terry Heath"]
  s.files    = FileList[ "lib/bling.rb", 
												"lib/bling/**/*.rb",
												"bin/*"].to_a

	s.require_path = 'lib'

	s.bindir = 'bin'
	s.executables << "bling"
end
