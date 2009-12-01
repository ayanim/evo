
# Evolution

  Ruby Content Management System.
  
## Goals

  * True modularity
  * Role / Permission based access
  * Background workers
  * Unified APIs
  * Rich Interaction
  * Super-sexy default theme
  * Pluggable themes
  
## Modularity

Evolution employs the concept of modularity via "Packages". A package
is simply a directory structure which is familiar to Evolution. Each package
may contain the following:

  * Views
  * Specs
  * Workers
  * Routes
  * Public Files
  * Assisting Libraries

Local packages (in your app) have the ability to override core functionality
without altering core. This same practice may be used with themes as well,
so if you do not like the image 'themes/chrome/images/add.png' simply create
a new image with the same path structure in your local application.

Packages are located via **Evo.load_paths** which starts looking for package(s) 
and their related files at the *application root*, and then follow on to *evo's root*.
This simple feature allows for vendorized packages, gem-based packages, overriding of
core or contrib packages via load path precedence and much more.

Themes are an extension of packages, and take precedence over all other packages, and may
override public files or views.

## Role / Permission based access

Evolution has two core unassignable roles, "Authenticated", and "Anonymous". Any number
of roles may be created, and assigned to any number of users. A matrix of permissions
is then applied to these roles, determining what users may access throughout the system.

Currently permissions are not applied at base levels such as models. We cannot simply assume
that since a user does not have the "delete users" permission, that the system itself cannot
delete users during a request, so permissions are generally applied at the routing level.

## Background Workers

Evolution plans on providing core background worker functionality,
supported through the Moneta library so that several key/value stores
may be used to queue jobs.

## Unified APIs

A major problem with Rails applications, and others a-like, is simply
that everyone has their own way of doing things. Although this is necessary
in some situations, large content management systems such as Drupal have proven
that when the community comes together on a single unified project the results
are astonishing and extremely powerful.

By everyone working together on these APIs we can assure that each package
will work flawlessly with core, ideally with no configuration at all (or provided via UI).

## Rich Interaction

One of Evolution's primary goal is to be rich with user interaction and usibility. This 
includes functionality such as inline searching, editing, and batch processing.
  
## Libraries

Below are the main libraries currently utilized by Evolution.

  * javascript:   jQuery
  * framework:    Sinatra
  * extensions:   Rext
  * executable:   Commander
  * orm:          DataMapper
  * jobs:         Moneta
  * specs:        RSpec
  * js specs:     JSpec
  
### jQuery & Plugins

Currently the following plugins are included in core:

  * jQuery core
  * jQuery UI
  * Floating table headers (keeps headers in sight with long pages)
  * Inline search (for filtering tables, lists, etc)
  * REST ($.create, $.read, $.update, $.destroy, etc)
  * Goodies (Ruby-like iterators)
  * Table select 
  
## Executable

Commander is used to create our executable `evo`, which replaces
the need for localized `rake` or similar programs. For more information
run:

    $ evo help
    
or for a specific command:

    $ evo help init
    
## Running Specs

    $ spec spec

## License

(The MIT License)

Copyright (c) 2009 TJ Holowaychuk <tj@vision-media.ca>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, an d/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
