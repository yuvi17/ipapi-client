Gem::Specification.new do |spec|
  spec.name        = 'ipstack_client'
  spec.version     = '0.0.2'
  spec.date        = '2020-04-25'
  spec.summary     = "IPStack Client for Ruby"
  spec.description = "A simple Ruby Client Interface for accessing GEOIP services of IPStack"
  spec.authors     = ["Yuvraj Jaiswal"]
  spec.email       = 'kumaryuvraj118@gmail.com'
 # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been
  # added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0")
                     .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
  spec.homepage    = 'https://github.com/yuvi17/ipstack_client'
  spec.required_ruby_version = '>= 2.4.0'
  spec.add_dependency 'redis', '>= 4.0.2'
  spec.add_dependency 'rest-client', '>= 2.0.0'
  spec.license     = 'MIT'
end