lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'command_service_object/version'

Gem::Specification.new do |spec|
  spec.name          = 'command_service_object'
  spec.version       = CommandServiceObject::VERSION
  spec.authors       = ['Adham EL-Deeb']
  spec.email         = ['adham.eldeeb90@gmail.com']

  spec.summary       = 'Rails Generator for command service object.'
  spec.description   = 'command_service_object gem helps you to generate'\
    ' service and command objects using rails generator.'
  spec.homepage      = 'https://github.com/adham90/command_service_object'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'thor', '~> 0.20.3'
  spec.add_runtime_dependency 'virtus', '~> 1.0.5'
end
