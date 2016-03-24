# grails.el

[![MELPA](http://melpa.org/packages/grails-badge.svg)](http://melpa.org/#/grails)
[![MELPA Stable](http://stable.melpa.org/packages/grails-badge.svg)](http://stable.melpa.org/#/grails)

Grails.el is an Emacs minor mode that allows an easy navigation 
of Grails projects.

## Features

Grails.el allows you to __fast open__ a domain class, a controller, a service or a view providing
customized open functions for each Grails file type. Now with autocompletion and history support.

Moreover __it can jump__ from the current domain|controller|service to the 
related domain|controller|service. You can also jump to the Bootstrap
and UrlMappings file. And yes, you can jump from the current controller action
to the related view __NEW__.

This minor mode __doesn't have any external dependencies__ and works nicely 
with Grails 2 and __Grails 3__ projects.

### Demo

![Emacs grails.el demo](https://raw.githubusercontent.com/lifeisfoo/emacs-grails/master/res/emacs-grails-el-demo.gif)

### Available functions and default key bindings
  
| Function |  Default key binding | Effect |
| -------- | -------- | ------ |
| grails-domain-from-file | `C-c` `-` `d`  | Open the Domain class related to the current file (e.g. if current buffer is `controllers/UserController.groovy`, it opens  `domain/User.groovy` |
| grails-controller-from-file |`C-c` `-` `c`  | Open the Controller class related to the current file (e.g. if current buffer is `domain/User.groovy`, it opens  `controllers/UserController.groovy` |
| grails-service-from-file | `C-c` `-` `s`  | Open the Service class related to the current file (e.g. if current buffer is `controllers/UserController.groovy`, it opens  `services/UserService.groovy` |
| grails-view-from-context | `C-c` `-` `v` `v` | Open the view related to the current controller action |
| grails-view-from-cursor | `C-c` `-` `v` `w` | Open the view related to the current controller, with name equals to the current word (cursor) |
| grails-urlmappings-file | `C-c` `-` `u`  | Open the UrlMappings file |
| grails-bootstrap-file | `C-c` `-` `b`  | Open the Bootstrap file |
| grails-domain-from-name | `C-c` `-` `n` `d`| Open a find file prompt inside `grails-app/domain/` |
| grails-controller-from-name | `C-c` `-` `n` `c`| Open a find file prompt inside `grails-app/controllers/` |
| grails-service-from-name |`C-c` `-` `n` `s`| Open a find file prompt inside `grails-app/services/` |
| grails-view-from-name | `C-c` `-` `n` `v`| Open a find file prompt inside `grails-app/views/` |
| grails-version | `C-c` `-` `p`  | Show grails project properties (only grails version by now) |

#### Class names with packages and jump features
Class names with __packages are fully supported__. E.g.:

- `C-c` `-` `c` (if current buffer is `domain/my/package/User.groovy`) will open `controllers/my/package/UserController.groovy` 

### Custom key bindings

[Emacs key binding convention](https://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Binding-Conventions.html#Key-Binding-Conventions) say that a minor mode can only
define bindings like `C-c punctuation_char other_char ...` also avoiding
`{, }, <, >, : or ;` as the first punctuation char. So, the default bindings
for `grails.el` starts always with the sequence `C-c -`. __If you want shorter
bindings__, and I'm sure you want them, just read below.

This mode expose a `grails-key-map` variable that you can use to customize
default key bindings available only when grails mode is active.
Just add to your `.emacs` file a `define-key` for every command that you want
to bind to a custom key binding.

E.g.:

    ;; your .emacs file

    (require 'grails) ;; do not add this if you've installed it from melpa


    ;; jump commands

    (define-key grails-key-map (kbd "C-c d") 'grails-domain-from-file)
    (define-key grails-key-map (kbd "C-c c") 'grails-controller-from-file)
    (define-key grails-key-map (kbd "C-c s") 'grails-service-from-file)
    (define-key grails-key-map (kbd "C-c v") 'grails-view-from-context)
    (define-key grails-key-map (kbd "C-c w") 'grails-view-from-cursor)
    (define-key grails-key-map (kbd "C-c u") 'grails-urlmappings-file)
    (define-key grails-key-map (kbd "C-c b") 'grails-bootstrap-file)


    ;; find file commands

    ;; equals to C-x C-f called from /your/project/grails-app/domain/
    (define-key grails-key-map (kbd "C-c C-f d") 'grails-domain-from-name)

    ;; equals to C-x C-f called from /your/project/grails-app/controllers/
    (define-key grails-key-map (kbd "C-c C-f c") 'grails-controller-from-name)

    ;; equals to C-x C-f called from /your/project/grails-app/services/
    (define-key grails-key-map (kbd "C-c C-f s") 'grails-service-from-name)

    ;; equals to C-x C-f called from /your/project/grails-app/views/
    (define-key grails-key-map (kbd "C-c C-f v") 'grails-view-from-name)


    ;; show Grails project properties (only version by now)
    (define-key grails-key-map (kbd "C-c p") 'grails-version)

Available commands are listed in the table above.

## Installation

Copy this file to to some location in your Emacs load path.  Then add
`(require 'grails)` to your Emacs initialization (.emacs,
init.el, or something):

    (require 'grails)

## Configuration

### Always active in project tree

To auto enable grails minor mode, create a .dir-locals.el file
in the root of the grails project with this configuration:

    ((nil . ((grails . 1))))

In this way, the grails minor mode will be always active inside your project tree.

__The first time__ that this code is executed, Emacs will show a security
prompt: __answer "!" to mark code secure__ and save your decision (a configuration 
line is automatically added to your .emacs file).

This is the suggested default configuration.

### Active by major mode

In order to have grails minor mode auto enabled only when using certain modes, 
place this inside your `.dir-locals.el`:

     ((groovy-mode (grails . 1))
     (html-mode (grails . 1))
     (java-mode (grails . 1)))
     
In this way, the grails minor mode will be auto enabled when any of
these major modes are loaded (only in this directory tree - the project tree)
(you can attach it to other modes if you want).

## Contributing
Pull requests are welcome. 

Check open issues for feature requests or current bugs.

## License

This software is released under the [GPL license version 3](http://www.gnu.org/licenses/gpl-3.0.en.html), or (at your option) any later version.
