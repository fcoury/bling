require 'rubygems'

class Bling
	def initialize(bling_file = "bling.yml")
		raise ArgumentError, "bling file not found" unless File.exists?(bling_file)
		@yaml = YAML::load_file(bling_file)
	end

	def require_env(env = nil)
		self.each_gem_for(env) do |entry|
  		gem *([entry['name'], entry['version']].compact)
  		require entry['lib'] || entry['name']
		end
	end

	def list_gems(env = nil)
		self.each_gem_for(env) do |entry|
			line = entry['name']
			line += " [#{entry['version']}]" if entry['version']
			$stdout.puts line
		end
	end

	def install_gems(env = nil)
		only_if_present = lambda{|pre, val| val.to_s.empty? ? "" : " #{pre}#{val}"}
		gem_installed = false
		each_gem_for(env) do |entry|
			begin
				version = only_if_present.call('-v=', entry['version'].to_s.gsub(/[=~<>]/, ''))
				source = only_if_present.call('--source=', entry['source'])
				gem *([entry['name'], entry['version']].compact)
			rescue Gem::LoadError
				gem_installed = true
				$stdout.puts "installing #{entry['name']} #{version}"
				`gem install #{entry['name']} #{version} #{source} `
			end
		end
		$stdout.puts "nothing to install!" unless gem_installed
	end

	protected
	def each_gem_for(env, &block)
		return unless @yaml
		(@yaml['all'] | (@yaml[env] || [])).each do |entry|
			yield entry if block_given?
		end
	end
end

def gem_version
  if ENV.include?('RAILS_GEM_VERSION')
    ENV['RAILS_GEM_VERSION']
  else
    parse_gem_version(read_environment_rb)
  end
end

def parse_gem_version(text)
  $1 if text =~ /^[^#]*RAILS_GEM_VERSION\s*=\s*["']([!~<>=]*\s*[\d.]+)["']/
end

def read_environment_rb
  File.read("config/environment.rb")
end