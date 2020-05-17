require_relative 'lib/redistimeseries/version'

Gem::Specification.new do |spec|
  spec.name          = "redistimeseries"
  spec.version       = Redistimeseries::VERSION
  spec.authors       = ["Eaden McKee (eadz)"]
  spec.email         = ["mail@eaden.net"]

  spec.summary       = %q{Ruby client for Redis Timeseries.}
  spec.description   = %q{Ruby client for Redis Timeseries, a redis add-on module.}
  spec.homepage      = "https://github.com/eadz/redistimeseries"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/eadz/redistimeseries"
  spec.metadata["changelog_uri"] = "https://github.com/eadz/redistimeseries"

  spec.add_dependency 'redis', '>= 4'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
