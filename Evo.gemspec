# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{Evo}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["TJ Holowaychuk"]
  s.date = %q{2009-11-04}
  s.default_executable = %q{evo}
  s.description = %q{Evolution Content Management System}
  s.email = %q{tj@vision-media.ca}
  s.executables = ["evo"]
  s.extra_rdoc_files = ["bin/evo", "lib/evo.rb", "lib/evo/boot.rb", "lib/evo/config/environment.rb", "lib/evo/package.rb", "lib/evo/packages/system/lib/javascript_queue.rb", "lib/evo/packages/system/lib/message_queue.rb", "lib/evo/packages/system/lib/queue.rb", "lib/evo/packages/system/routes/system_routes.rb", "lib/evo/packages/system/spec/system_routes_spec.rb", "lib/evo/version.rb"]
  s.files = ["Evo.gemspec", "History.md", "Manifest", "Rakefile", "Readme.md", "bin/evo", "lib/evo.rb", "lib/evo/boot.rb", "lib/evo/config/environment.rb", "lib/evo/package.rb", "lib/evo/packages/system/lib/javascript_queue.rb", "lib/evo/packages/system/lib/message_queue.rb", "lib/evo/packages/system/lib/queue.rb", "lib/evo/packages/system/routes/system_routes.rb", "lib/evo/packages/system/spec/system_routes_spec.rb", "lib/evo/version.rb", "spec/fixtures/app/config.ru", "spec/fixtures/app/config/environment.rb", "spec/fixtures/app/packages/foo/public/style.css", "spec/fixtures/app/packages/foo/routes/foo_routes.rb", "spec/fixtures/app/packages/foo/spec/foo_spec.rb", "spec/fixtures/app/packages/foo/spec/nested/nested_foo_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/unit/evo_spec.rb", "spec/unit/javascript_queue.rb", "spec/unit/message_queue_spec.rb", "spec/unit/package_spec.rb"]
  s.homepage = %q{http://github.com/visionmedia/evo}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Evo", "--main", "Readme.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{evo}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Evolution Content Management System}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<formz>, [">= 0"])
      s.add_runtime_dependency(%q<tagz>, [">= 0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0.9.11"])
      s.add_runtime_dependency(%q<dm-migrations>, [">= 0.9.11"])
      s.add_runtime_dependency(%q<dm-timestamps>, [">= 0.9.11"])
      s.add_runtime_dependency(%q<dm-validations>, [">= 0.9.11"])
      s.add_runtime_dependency(%q<dm-serializer>, [">= 0.9.11"])
      s.add_runtime_dependency(%q<dm-types>, [">= 0.9.11"])
      s.add_runtime_dependency(%q<dm-pager>, [">= 0"])
      s.add_development_dependency(%q<webrat>, [">= 0"])
    else
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<formz>, [">= 0"])
      s.add_dependency(%q<tagz>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_dependency(%q<dm-core>, [">= 0.9.11"])
      s.add_dependency(%q<dm-migrations>, [">= 0.9.11"])
      s.add_dependency(%q<dm-timestamps>, [">= 0.9.11"])
      s.add_dependency(%q<dm-validations>, [">= 0.9.11"])
      s.add_dependency(%q<dm-serializer>, [">= 0.9.11"])
      s.add_dependency(%q<dm-types>, [">= 0.9.11"])
      s.add_dependency(%q<dm-pager>, [">= 0"])
      s.add_dependency(%q<webrat>, [">= 0"])
    end
  else
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<formz>, [">= 0"])
    s.add_dependency(%q<tagz>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0.9.4"])
    s.add_dependency(%q<dm-core>, [">= 0.9.11"])
    s.add_dependency(%q<dm-migrations>, [">= 0.9.11"])
    s.add_dependency(%q<dm-timestamps>, [">= 0.9.11"])
    s.add_dependency(%q<dm-validations>, [">= 0.9.11"])
    s.add_dependency(%q<dm-serializer>, [">= 0.9.11"])
    s.add_dependency(%q<dm-types>, [">= 0.9.11"])
    s.add_dependency(%q<dm-pager>, [">= 0"])
    s.add_dependency(%q<webrat>, [">= 0"])
  end
end
