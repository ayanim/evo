# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{evo}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["TJ Holowaychuk"]
  s.date = %q{2009-12-01}
  s.default_executable = %q{evo}
  s.description = %q{Evolution Content Management System}
  s.email = %q{tj@vision-media.ca}
  s.executables = ["evo"]
  s.extra_rdoc_files = ["bin/evo", "lib/evo.rb", "lib/evo/boot.rb", "lib/evo/config/environment.rb", "lib/evo/package.rb", "lib/evo/packages/block/block.yml", "lib/evo/packages/block/lib/block.rb", "lib/evo/packages/block/spec/block_spec.rb", "lib/evo/packages/jobqueue/jobqueue.yml", "lib/evo/packages/jobqueue/lib/worker.rb", "lib/evo/packages/jobqueue/models/job_model.rb", "lib/evo/packages/jobqueue/public/javascripts/jobqueue.js", "lib/evo/packages/jobqueue/routes/jobqueue_routes.rb", "lib/evo/packages/jobqueue/spec/job_spec.rb", "lib/evo/packages/jobqueue/views/jobs.haml", "lib/evo/packages/system/lib/extensions.rb", "lib/evo/packages/system/lib/helpers.rb", "lib/evo/packages/system/lib/hook_helpers.rb", "lib/evo/packages/system/lib/javascript_queue.rb", "lib/evo/packages/system/lib/menu.rb", "lib/evo/packages/system/lib/message_queue.rb", "lib/evo/packages/system/lib/package_helpers.rb", "lib/evo/packages/system/lib/queue.rb", "lib/evo/packages/system/lib/session_helpers.rb", "lib/evo/packages/system/lib/theme_helpers.rb", "lib/evo/packages/system/lib/view_helpers.rb", "lib/evo/packages/system/public/javascripts/evo.js", "lib/evo/packages/system/public/javascripts/jquery.floating-headers.js", "lib/evo/packages/system/public/javascripts/jquery.goodies.js", "lib/evo/packages/system/public/javascripts/jquery.inline-search.js", "lib/evo/packages/system/public/javascripts/jquery.js", "lib/evo/packages/system/public/javascripts/jquery.rest.js", "lib/evo/packages/system/public/javascripts/jquery.table-select.js", "lib/evo/packages/system/public/javascripts/jquery.ui.js", "lib/evo/packages/system/public/javascripts/system.js", "lib/evo/packages/system/routes/system_routes.rb", "lib/evo/packages/system/spec/system_helpers_spec.rb", "lib/evo/packages/system/spec/system_javascript_queue.rb", "lib/evo/packages/system/spec/system_menu_item_spec.rb", "lib/evo/packages/system/spec/system_menu_spec.rb", "lib/evo/packages/system/spec/system_message_queue_spec.rb", "lib/evo/packages/system/spec/system_routes_spec.rb", "lib/evo/packages/system/spec/system_views_spec.rb", "lib/evo/packages/system/system.yml", "lib/evo/packages/system/views/_block.haml", "lib/evo/packages/user/lib/helpers.rb", "lib/evo/packages/user/models/permission_model.rb", "lib/evo/packages/user/models/role_model.rb", "lib/evo/packages/user/models/session_model.rb", "lib/evo/packages/user/models/user_model.rb", "lib/evo/packages/user/public/javascripts/user.js", "lib/evo/packages/user/routes/user_edit_routes.rb", "lib/evo/packages/user/routes/user_permission_routes.rb", "lib/evo/packages/user/routes/user_register_routes.rb", "lib/evo/packages/user/routes/user_role_routes.rb", "lib/evo/packages/user/routes/user_routes.rb", "lib/evo/packages/user/spec/spec_helper_spec.rb", "lib/evo/packages/user/spec/spec_helpers.rb", "lib/evo/packages/user/spec/user_helpers_spec.rb", "lib/evo/packages/user/spec/user_role_spec.rb", "lib/evo/packages/user/spec/user_routes_spec.rb", "lib/evo/packages/user/spec/user_session_spec.rb", "lib/evo/packages/user/spec/user_spec.rb", "lib/evo/packages/user/user.yml", "lib/evo/packages/user/views/_edit_form.haml", "lib/evo/packages/user/views/_list.haml", "lib/evo/packages/user/views/_login_form.haml", "lib/evo/packages/user/views/_registration_form.haml", "lib/evo/packages/user/views/_roles.haml", "lib/evo/packages/user/views/edit.haml", "lib/evo/packages/user/views/list.haml", "lib/evo/packages/user/views/login.haml", "lib/evo/packages/user/views/permissions.haml", "lib/evo/packages/user/views/register.haml", "lib/evo/theme.rb", "lib/evo/themes/chrome/chrome.yml", "lib/evo/themes/chrome/lib/helpers.rb", "lib/evo/themes/chrome/public/images/arrow-dark.png", "lib/evo/themes/chrome/public/images/arrow.png", "lib/evo/themes/chrome/public/images/background.png", "lib/evo/themes/chrome/public/images/h1.png", "lib/evo/themes/chrome/public/images/h2.png", "lib/evo/themes/chrome/public/images/h3.png", "lib/evo/themes/chrome/public/images/h4.png", "lib/evo/themes/chrome/public/images/sprites.add.png", "lib/evo/themes/chrome/public/images/sprites.background.png", "lib/evo/themes/chrome/public/images/sprites.delete.png", "lib/evo/themes/chrome/public/images/sprites.png", "lib/evo/themes/chrome/public/images/sprites.tab.png", "lib/evo/themes/chrome/public/images/v1.png", "lib/evo/themes/chrome/public/images/v2.png", "lib/evo/themes/chrome/public/javascripts/chrome.js", "lib/evo/themes/chrome/views/page.haml", "lib/evo/themes/chrome/views/style.sass", "lib/evo/version.rb"]
  s.files = ["History.md", "Manifest", "Rakefile", "Readme.md", "bin/evo", "evo.gemspec", "lib/evo.rb", "lib/evo/boot.rb", "lib/evo/config/environment.rb", "lib/evo/package.rb", "lib/evo/packages/block/block.yml", "lib/evo/packages/block/lib/block.rb", "lib/evo/packages/block/spec/block_spec.rb", "lib/evo/packages/jobqueue/jobqueue.yml", "lib/evo/packages/jobqueue/lib/worker.rb", "lib/evo/packages/jobqueue/models/job_model.rb", "lib/evo/packages/jobqueue/public/javascripts/jobqueue.js", "lib/evo/packages/jobqueue/routes/jobqueue_routes.rb", "lib/evo/packages/jobqueue/spec/job_spec.rb", "lib/evo/packages/jobqueue/views/jobs.haml", "lib/evo/packages/system/lib/extensions.rb", "lib/evo/packages/system/lib/helpers.rb", "lib/evo/packages/system/lib/hook_helpers.rb", "lib/evo/packages/system/lib/javascript_queue.rb", "lib/evo/packages/system/lib/menu.rb", "lib/evo/packages/system/lib/message_queue.rb", "lib/evo/packages/system/lib/package_helpers.rb", "lib/evo/packages/system/lib/queue.rb", "lib/evo/packages/system/lib/session_helpers.rb", "lib/evo/packages/system/lib/theme_helpers.rb", "lib/evo/packages/system/lib/view_helpers.rb", "lib/evo/packages/system/public/javascripts/evo.js", "lib/evo/packages/system/public/javascripts/jquery.floating-headers.js", "lib/evo/packages/system/public/javascripts/jquery.goodies.js", "lib/evo/packages/system/public/javascripts/jquery.inline-search.js", "lib/evo/packages/system/public/javascripts/jquery.js", "lib/evo/packages/system/public/javascripts/jquery.rest.js", "lib/evo/packages/system/public/javascripts/jquery.table-select.js", "lib/evo/packages/system/public/javascripts/jquery.ui.js", "lib/evo/packages/system/public/javascripts/system.js", "lib/evo/packages/system/routes/system_routes.rb", "lib/evo/packages/system/spec/system_helpers_spec.rb", "lib/evo/packages/system/spec/system_javascript_queue.rb", "lib/evo/packages/system/spec/system_menu_item_spec.rb", "lib/evo/packages/system/spec/system_menu_spec.rb", "lib/evo/packages/system/spec/system_message_queue_spec.rb", "lib/evo/packages/system/spec/system_routes_spec.rb", "lib/evo/packages/system/spec/system_views_spec.rb", "lib/evo/packages/system/system.yml", "lib/evo/packages/system/views/_block.haml", "lib/evo/packages/user/lib/helpers.rb", "lib/evo/packages/user/models/permission_model.rb", "lib/evo/packages/user/models/role_model.rb", "lib/evo/packages/user/models/session_model.rb", "lib/evo/packages/user/models/user_model.rb", "lib/evo/packages/user/public/javascripts/user.js", "lib/evo/packages/user/routes/user_edit_routes.rb", "lib/evo/packages/user/routes/user_permission_routes.rb", "lib/evo/packages/user/routes/user_register_routes.rb", "lib/evo/packages/user/routes/user_role_routes.rb", "lib/evo/packages/user/routes/user_routes.rb", "lib/evo/packages/user/spec/spec_helper_spec.rb", "lib/evo/packages/user/spec/spec_helpers.rb", "lib/evo/packages/user/spec/user_helpers_spec.rb", "lib/evo/packages/user/spec/user_role_spec.rb", "lib/evo/packages/user/spec/user_routes_spec.rb", "lib/evo/packages/user/spec/user_session_spec.rb", "lib/evo/packages/user/spec/user_spec.rb", "lib/evo/packages/user/user.yml", "lib/evo/packages/user/views/_edit_form.haml", "lib/evo/packages/user/views/_list.haml", "lib/evo/packages/user/views/_login_form.haml", "lib/evo/packages/user/views/_registration_form.haml", "lib/evo/packages/user/views/_roles.haml", "lib/evo/packages/user/views/edit.haml", "lib/evo/packages/user/views/list.haml", "lib/evo/packages/user/views/login.haml", "lib/evo/packages/user/views/permissions.haml", "lib/evo/packages/user/views/register.haml", "lib/evo/theme.rb", "lib/evo/themes/chrome/chrome.yml", "lib/evo/themes/chrome/lib/helpers.rb", "lib/evo/themes/chrome/public/images/arrow-dark.png", "lib/evo/themes/chrome/public/images/arrow.png", "lib/evo/themes/chrome/public/images/background.png", "lib/evo/themes/chrome/public/images/h1.png", "lib/evo/themes/chrome/public/images/h2.png", "lib/evo/themes/chrome/public/images/h3.png", "lib/evo/themes/chrome/public/images/h4.png", "lib/evo/themes/chrome/public/images/sprites.add.png", "lib/evo/themes/chrome/public/images/sprites.background.png", "lib/evo/themes/chrome/public/images/sprites.delete.png", "lib/evo/themes/chrome/public/images/sprites.png", "lib/evo/themes/chrome/public/images/sprites.tab.png", "lib/evo/themes/chrome/public/images/v1.png", "lib/evo/themes/chrome/public/images/v2.png", "lib/evo/themes/chrome/public/javascripts/chrome.js", "lib/evo/themes/chrome/views/page.haml", "lib/evo/themes/chrome/views/style.sass", "lib/evo/version.rb", "spec/fixtures/app/application.rb", "spec/fixtures/app/config/environment.rb", "spec/fixtures/app/databases/evo.development.db", "spec/fixtures/app/packages/foo/foo.yml", "spec/fixtures/app/packages/foo/public/foo.txt", "spec/fixtures/app/packages/foo/public/style.css", "spec/fixtures/app/packages/foo/public/system/javascripts/jquery.ui.js", "spec/fixtures/app/packages/foo/routes/foo_routes.rb", "spec/fixtures/app/packages/foo/spec/foo_spec.rb", "spec/fixtures/app/packages/foo/spec/nested/nested_foo_spec.rb", "spec/fixtures/app/packages/foo/views/_context.haml", "spec/fixtures/app/packages/foo/views/_item.haml", "spec/fixtures/app/packages/foo/views/bar.erb", "spec/fixtures/app/packages/foo/views/bar.haml", "spec/fixtures/app/packages/foo/views/baz.erb", "spec/fixtures/app/packages/foo/views/capture_haml.haml", "spec/fixtures/app/packages/foo/views/items/_item.haml", "spec/fixtures/app/packages/foo/views/items/list.haml", "spec/fixtures/app/packages/foo/views/jobqueue/foo.haml", "spec/fixtures/app/packages/foo/views/jobqueue/jobs.erb", "spec/fixtures/app/packages/foo/views/malicious.haml", "spec/fixtures/app/packages/foo/views/print.sass", "spec/fixtures/app/packages/foo/views/regions.haml", "spec/fixtures/app/packages/system/views/_item.haml", "spec/fixtures/app/themes/chrome/public/javascripts/chrome.js", "spec/fixtures/app/themes/invalid/invalid.yml", "spec/fixtures/app/themes/wahoo/public/foo.txt", "spec/fixtures/app/themes/wahoo/public/style.css", "spec/fixtures/app/themes/wahoo/spec/foo_spec.rb", "spec/fixtures/app/themes/wahoo/spec/nested/nested_foo_spec.rb", "spec/fixtures/app/themes/wahoo/views/bar.haml", "spec/fixtures/app/themes/wahoo/views/foo/print.sass", "spec/fixtures/app/themes/wahoo/views/page.haml", "spec/fixtures/app/themes/wahoo/wahoo.yml", "spec/spec.opts", "spec/spec_helper.rb", "spec/unit/evo_spec.rb", "spec/unit/package_spec.rb", "spec/unit/shared/all_packages.rb", "spec/unit/spec_helper_spec.rb", "spec/unit/theme_spec.rb", "templates/default/application.rb", "templates/default/config/environment.rb", "templates/default/databases/evo.development.db", "templates/default/packages/application/application.yml", "templates/default/packages/application/public/javascripts/application.js", "templates/default/packages/application/routes/application_routes.rb", "templates/default/packages/application/spec/application_spec.rb", "templates/default/packages/application/views/hello.haml"]
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
      s.add_runtime_dependency(%q<daemon-spawn>, [">= 0"])
      s.add_runtime_dependency(%q<tilt>, [">= 0"])
      s.add_runtime_dependency(%q<rext>, [">= 0.6.1"])
      s.add_runtime_dependency(%q<formz>, [">= 0.1.0"])
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
      s.add_dependency(%q<daemon-spawn>, [">= 0"])
      s.add_dependency(%q<tilt>, [">= 0"])
      s.add_dependency(%q<rext>, [">= 0.6.1"])
      s.add_dependency(%q<formz>, [">= 0.1.0"])
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
    s.add_dependency(%q<daemon-spawn>, [">= 0"])
    s.add_dependency(%q<tilt>, [">= 0"])
    s.add_dependency(%q<rext>, [">= 0.6.1"])
    s.add_dependency(%q<formz>, [">= 0.1.0"])
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