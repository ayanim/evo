
# Evolution

  Ruby Content Management System
  
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
