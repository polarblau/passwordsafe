# Password Safe
A command line application that can store and retrieve passwords from an encrypted file.

Based on 'Tutorial: Build your own password safe with Ruby!' at http://rbjl.net/41-tutorial-build-your-own-password-safe-with-ruby which won't run on my machine.  So rather than try to fix it, I decided to build my own, with an actual attempt at testing/BDD.  This was primarily done for my own education, tips/suggestions are welcome.

## Currently implemented
**NOTE** This gem is currently in alpha, if you'd like to try it and make suggestions feel free but please do not store valuble information in it yet.


    password add name password
Use passwordsafe to add a password with NAME to the safe.  The utility will prompt for a master password to use to encrypt the file. *Do NOT loose your master password, it is unrecoverable!*

    password get name
Use passwordsafe to retrive an existing password out of your safe.  The utility will prompt for a master password.

## Not Implemented yet

    password list
    password remove name
    password help

# Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. I won't accept pull requests without at least specs, features get you bonus points.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request.

# License

Copyright (c) 2010 thecatwasnot

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

