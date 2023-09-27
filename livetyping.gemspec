# frozen_string_literal: true

require_relative "lib/livetyping/version"

Gem::Specification.new do |spec|
  spec.name = "livetyping"
  spec.version = Livetyping::VERSION
  spec.authors = ["Federico Iachetti"]
  spec.email = ["iachetti.federico@gmail.com"]

  spec.summary = "LiveTyping implementation for Ruby"
  spec.description = "LiveTyping implementation for Ruby"
  spec.homepage = "https://github.com/iachettifederico/livetyping"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/iachettifederico/livetyping"
  # spec.metadata["changelog_uri"] = "https://github.com/iachettifederico/livetyping"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) {
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
