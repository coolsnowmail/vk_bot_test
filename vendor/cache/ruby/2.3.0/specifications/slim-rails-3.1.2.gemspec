# -*- encoding: utf-8 -*-
# stub: slim-rails 3.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "slim-rails"
  s.version = "3.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Leonardo Almeida"]
  s.date = "2017-03-03"
  s.description = "Provides the generator settings required for Rails 3+ to use Slim"
  s.email = ["lalmeida08@gmail.com"]
  s.homepage = "https://github.com/slim-template/slim-rails"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Slim templates generator for Rails 3+"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 3.1"])
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_runtime_dependency(%q<slim>, ["~> 3.0"])
      s.add_development_dependency(%q<sprockets-rails>, [">= 0"])
      s.add_development_dependency(%q<rocco>, [">= 0"])
      s.add_development_dependency(%q<redcarpet>, [">= 0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
      s.add_development_dependency(%q<actionmailer>, [">= 3.1"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
    else
      s.add_dependency(%q<actionpack>, [">= 3.1"])
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<slim>, ["~> 3.0"])
      s.add_dependency(%q<sprockets-rails>, [">= 0"])
      s.add_dependency(%q<rocco>, [">= 0"])
      s.add_dependency(%q<redcarpet>, [">= 0"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
      s.add_dependency(%q<actionmailer>, [">= 3.1"])
      s.add_dependency(%q<appraisal>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 3.1"])
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<slim>, ["~> 3.0"])
    s.add_dependency(%q<sprockets-rails>, [">= 0"])
    s.add_dependency(%q<rocco>, [">= 0"])
    s.add_dependency(%q<redcarpet>, [">= 0"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
    s.add_dependency(%q<actionmailer>, [">= 3.1"])
    s.add_dependency(%q<appraisal>, [">= 0"])
  end
end
