# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{Evo}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["TJ Holowaychuk"]
  s.date = %q{2009-11-04}
  s.description = %q{Evo Content Management System}
  s.email = %q{tj@vision-media.ca}
  s.extra_rdoc_files = ["lib/evo.rb", "lib/evo/version.rb", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake"]
  s.files = ["History.md", "Rakefile", "Readme.md", "lib/evo.rb", "lib/evo/version.rb", "spec/GEM_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake", "Manifest", "Evo.gemspec"]
  s.homepage = %q{http://github.com/visionmedia/evo}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Evo", "--main", "Readme.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{evo}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Evo Content Management System}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
