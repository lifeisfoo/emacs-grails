# grails-minor-mode

Grails minor mode is an Emacs minor mode that allows an easy navigation 
of Grails projects.

## Features

Grails-minor-mode allows you to fast open a domain class, a controller 
or service just typing it's name. Moreover it can jump from the current
domain|controller|service to the relative domain|controller|service.

## Installation

Copy this file to to some location in your Emacs load path.  Then add
`(require 'grails-minor-mode)` to your Emacs initialization (.emacs,
init.el, or something):

    (require 'grails-minor-mode)

## Configuration

Then, to auto enable grails-minor-mode, create a .dir-locals.el file
in the root of the grails project with this configuration:

    ((groovy-mode (grails-minor-mode . 1))
     (html-mode (grails-minor-mode . 1))
     (java-mode (grails-minor-mode . 1)))

In this way, the grails-minor-mode will be auto enabled when any of
these major modes are loaded (only in this directory tree - the project tree)
(you can attach it to other modes if you want).

The first time that this code is executed, Emacs will show a security
prompt: answer "!" to mark code secure and save your decision (a configuration 
line is automatically added to your .emacs file).

### License

This software is released under the [GPL license version 3](http://www.gnu.org/licenses/gpl-3.0.en.html), or (at your option) any later version.
