;;; grails.el --- Minor mode for Grails projects
;;
;; Copyright (c) 2016 Alessandro Miliucci
;;
;; Authors: Alessandro Miliucci <lifeisfoo@gmail.com>
;; Version: 0.1.1
;; URL: https://github.com/lifeisfoo/emacs-grails
;; Package-Requires: ((emacs "24"))

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Description:

;; Grails.el is a minor mode that allows an easy
;; navigation of Gails projects.  It allows jump to a model, to a view,
;; to a controller or to a service.
;;
;; For more details, see the project page at
;; https://github.com/lifeisfoo/emacs-grails
;;
;; Installation:
;;
;; Copy this file to to some location in your Emacs load path.  Then add
;; "(require 'grails)" to your Emacs initialization (.emacs,
;; init.el, or something).
;;
;; Example config:
;;
;;   (require 'grails)

;; Then, to auto enable grails mode, create a .dir-locals.el file
;; in the root of the grails project with this configuration:

;; ((groovy-mode (grails . 1))
;;  (html-mode (grails . 1))
;;  (java-mode (grails . 1)))

;; In this way, the grails mode will be auto enabled when any of
;; these major modes are loaded (only in this directory tree - the project tree)
;; (you can attach it to other modes if you want).

;; The first time that this code is executed, Emacs will show a security
;; prompt: answer "!" to mark code secure and save your decision.
;; (a configuration line is automatically added to your .emacs file)

;; In order to have grails minor mode always enabled inside your project tree,
;; place inside your `.dir-locals.el`:

;;   ((nil . ((grails . 1))))
;;

;;; Code:

(defun grails-extract-name (controller-file-path start-from ending-regex)
  "Transform MyClassController.groovy to MyClass, or my/package/MyClassController.groovy to my/package/MyClass."
  (let ((end (string-match ending-regex (substring controller-file-path start-from nil))))
    (substring (substring controller-file-path start-from nil) 0 end)))

(defun grails-clean-name (file-name)
  "Detect current file type and extract it's clean class-name"
  (let ((start (string-match "/grails-app/" file-name)))
    (let ((end (match-end 0)))
      (let ((in-grails-path (substring file-name end nil))) ;; substring that follow 'grails-app/' to the end
	(let ((dir-type (substring in-grails-path (string-match "^[a-zA-Z]+" in-grails-path) (match-end 0))))
	  (cond ((string= dir-type "controllers") (grails-extract-name in-grails-path (+ 1 (match-end 0)) "Controller\.groovy"))
		((string= dir-type "domain") (grails-extract-name in-grails-path (+ 1 (match-end 0)) "\.groovy"))
		((string= dir-type "views") 'views) ;; TODO: not yet implemented 
		((string= dir-type "services") (grails-extract-name in-grails-path (+ 1 (match-end 0)) "Service\.groovy"))
		(t (error "File not recognized")))
	  )))))

(defun grails-app-base (path)
  "Get the current grails app base path /my/abs/path/grails-app/ if exist, else nil"
  (let ((inizio (string-match "/grails-app/" path)))
    (if inizio
	(substring path 0 (match-end 0))
      () ;; if this is not a grails app return nil
      )))

(defun grails-generic-from-file (type cur-file)
  (cond ((string= type "controller") (concat (grails-app-base cur-file) "controllers/" (grails-clean-name cur-file) "Controller.groovy"))
	((string= type "domain") (concat (grails-app-base cur-file) "domain/" (grails-clean-name cur-file) ".groovy"))
	((string= type "service") (concat (grails-app-base cur-file) "services/" (grails-clean-name cur-file) "Service.groovy"))
	(t (error "Type not recognized"))))

;;TODO use current directory insted of buffer-file-name
(defun grails-generic-from-name (type cur-name)
  (cond ((string= type "controller") (concat (grails-app-base (buffer-file-name)) "controllers/" cur-name "Controller.groovy"))
	((string= type "domain") (concat (grails-app-base (buffer-file-name)) "domain/" cur-name ".groovy"))
	((string= type "service") (concat (grails-app-base (buffer-file-name)) "services/" cur-name "Service.groovy"))
	(t (error "Type not recognized"))))

;; TODO: unique generic-from-* function
;; (defun generic-from-all (dest-type dest-name-type dest-name)
;;   (let ((base-path (cond ((string= dest-name-type "current-file") (grails-app-base dest-name))
;; 			 ((string= dest-name-type "name") (grails-app-base (buffer-file-name)))
;; 			 (t (error "Dest-name-type not recognized")))))
;;     (let ((grails-name (cond ((string= dest-name-type "current-file") (grails-clean-name dest-name))
;; 			     ((string= dest-name-type "name") dest-name)
;; 			     (t (error "Dest-name-type not recognized")))))
;;       (cond ((string= dest-type "controller") (concat base-path "controllers/" grails-name "Controller.groovy"))
;; 	    ((string= dest-type "domain") (concat base-path "domain/" grails-name ".groovy"))
;; 	    ((string= dest-type "service") (concat base-path "services/" grails-name "Service.groovy"))
;;	    (t (error "Type not recognized"))))))

(defun grails-domain-from-file ()
  "Generate the domain file path from name, e.g. -> domain/User.groovy"
  (interactive)
  (switch-to-buffer
   (find-file-noselect
    (grails-generic-from-file "domain" (buffer-file-name)))))

(defun grails-controller-from-file ()
  "Generate the controller file path from name, e.g. -> controllers/UserController.groovy"
  (interactive)
  (switch-to-buffer
   (find-file-noselect
    (grails-generic-from-file "controller" (buffer-file-name)))))

(defun grails-service-from-file ()
  "Generate the service file path from name, e.g. -> services/UserService.groovy"
  (interactive)
  (switch-to-buffer
   (find-file-noselect
    (grails-generic-from-file "service" (buffer-file-name)))))

(defun grails-domain-from-name (name)
  "Jump to a Grails model with name, e.g. User"
  (interactive "sGrails domain name: ")
  (switch-to-buffer
   (find-file-noselect
    (grails-generic-from-name "domain" (format "%s" name)))))

(defun grails-controller-from-name (name)
  "Jump to a Grails controller with name, e.g. User"
  (interactive "sGrails controller name: ")
  (switch-to-buffer
   (find-file-noselect
    (grails-generic-from-name "controller" (format "%s" name)))))

(defun grails-service-from-name (name)
  "Jump to a Grails service with the name provided."
  (interactive "sGrails service name: ")
  (switch-to-buffer
   (find-file-noselect
    (grails-generic-from-name "service" (format "%s" name)))))

;; TODO: view-from-file show list or try to match from controller context

(defun grails-key-map ()
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap (kbd "C-c - d") 'grails-domain-from-file)
    (define-key keymap (kbd "C-c - c") 'grails-controller-from-file)
    (define-key keymap (kbd "C-c - s") 'grails-service-from-file)
    (define-key keymap (kbd "C-c - n d") 'grails-domain-from-name)
    (define-key keymap (kbd "C-c - n c") 'grails-controller-from-name)
    (define-key keymap (kbd "C-c - n s") 'grails-service-from-name)
    keymap))

;;;###autoload
(define-minor-mode grails
  "Grails minor mode.
     With no argument, this command toggles the mode.
     Non-null prefix argument turns on the mode.
     Null prefix argument turns off the mode.
     When Grails minor mode is enabled you have some
     shortcut to fast navigate a Grails project."
  :init-value nil
  :lighter " Grails"
  :keymap (grails-key-map)
  :group 'grails)

(provide 'grails)

;;; grails.el ends here
