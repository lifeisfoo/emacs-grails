# grails-minor-mode

Grails minor mode is an Emacs minor mode that allows an easy navigation 
of Grails projects.

## Features

Grails-minor-mode allows you to fast open a domain class, a controller 
or service just typing it's name. Moreover it can jump from the current
domain|controller|service to the relative domain|controller|service.

### Available commands
  
| Shortcut | Effect | Example |
| -------- | ------ | ------- |
| C-c - d  | Open the Domain class relative to the current file | If current file is `controllers/UserController.groovy`, it opens  `domain/User.groovy` |
| C-c - c  | Open the Controller class relative to the current file | If current file is `domain/User.groovy`, it opens  `controllers/UserController.groovy` |
| C-c - s  | Open the Service class relative to the current file | If current file is `controllers/UserController.groovy`, it opens  `services/UserService.groovy` |
| C-c - n d| Ask for a class name and open to the relative Domain class | If `name` is `User`, it opens  `domain/User.groovy` |
| C-c - n c| Ask for a class name and open to the relative Controller class | If `name` is `User`, it opens  `controllers/UserController.groovy` |
| C-c - n s| Ask for a class name and open to the relative Service class | If `name` is `User`, it opens  `services/UserService.groovy` |

#### Class names with packages
Class names with __packages are fully supported__.

- C-c - c (if current buffer is `domain/my/package/User.groovy`) will open `controllers/my/package/UserController.groovy` 
- C-c - n c `my/package/User` will open `controllers/my/package/UserController.groovy`

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
