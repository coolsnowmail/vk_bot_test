# -*- encoding: utf-8 -*-
# stub: shoulda-callback-matchers 1.1.4 ruby lib
# stub: ext/mkrf_conf.rb

Gem::Specification.new do |s|
  s.name = "shoulda-callback-matchers"
  s.version = "1.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Beat Richartz", "Jonathan Liss"]
  s.date = "2016-05-14"
  s.description = "Making callback tests easy on the fingers and eyes"
  s.email = "jonacom@lissismore.com"
  s.extensions = ["ext/mkrf_conf.rb"]
  s.files = ["ext/mkrf_conf.rb"]
  s.homepage = "http://github.com/jdliss/shoulda-callback-matchers"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Making callback tests easy on the fingers and eyes"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3"])
      s.add_development_dependency(%q<appraisal>, ["~> 0.5"])
      s.add_development_dependency(%q<aruba>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 1.1"])
      s.add_development_dependency(%q<rails>, [">= 3"])
      s.add_development_dependency(%q<rake>, ["~> 10"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 3"])
    else
      s.add_dependency(%q<activesupport>, [">= 3"])
      s.add_dependency(%q<appraisal>, ["~> 0.5"])
      s.add_dependency(%q<aruba>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 1.1"])
      s.add_dependency(%q<rails>, [">= 3"])
      s.add_dependency(%q<rake>, ["~> 10"])
      s.add_dependency(%q<rspec-rails>, ["~> 3"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3"])
    s.add_dependency(%q<appraisal>, ["~> 0.5"])
    s.add_dependency(%q<aruba>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 1.1"])
    s.add_dependency(%q<rails>, [">= 3"])
    s.add_dependency(%q<rake>, ["~> 10"])
    s.add_dependency(%q<rspec-rails>, ["~> 3"])
  end
end
