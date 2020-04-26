Gem::Specification.new do |spec|
  spec.name        = 'ipstack-client'
  spec.version     = '0.0.2'
  spec.date        = '2020-04-25'
  spec.summary     = "IPStack Client for Ruby"
  spec.description = "A simple Ruby Client Interface for accessing GEOIP services of IPStack"
  spec.authors     = ["Yuvraj Jaiswal"]
  spec.email       = 'kumaryuvraj118@gmail.com'
  spec.files       = ["lib/ipstack-client.rb","lib/api_interface.rb"]
  spec.homepage    = 'https://github.com/yuvi17/ipstack-client'
  spec.required_ruby_version = '>= 2.4.0'
  spec.add_dependency 'redis', '>= 4.0.2'
  spec.add_dependency 'rest-client', '>= 2.0.0'
  spec.license     = 'MIT'
end