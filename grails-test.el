(require 'ert)
(require 'grails)

(ert-deftest grails-test-vars-1 ()
  "Test mode vars"
  (should (eql (length grails-dir-name-by-type) 4))
  (should (string= (car (cdr (assoc 'controller grails-dir-name-by-type))) "controllers"))
  (should (string= (car (cdr (assoc 'domain grails-dir-name-by-type))) "domain"))
  (should (string= (car (cdr (assoc 'service grails-dir-name-by-type))) "services"))
  (should (string= (car (cdr (assoc 'view grails-dir-name-by-type))) "views")))

(ert-deftest grails-test-vars-2 ()
  "Test mode vars"
  (should (eql (length grails-postfix-by-type) 4))
  (should (string= (car (cdr (assoc 'controller grails-postfix-by-type))) "Controller.groovy"))
  (should (string= (car (cdr (assoc 'domain grails-postfix-by-type))) ".groovy"))
  (should (string= (car (cdr (assoc 'service grails-postfix-by-type))) "Service.groovy"))
  (should (string= (car (cdr (assoc 'view grails-postfix-by-type))) ".gsp")))

(ert-deftest grails-test-grails-grep-version ()
  "Test version detection"
  (should (eql (grails-grep-version "grailsVersion=3.1.0") 3))
  (should-not (eql (grails-grep-version "grailsVersion=2.1.0") 2));;only 3+ has gradle
  (should (eql (grails-grep-version "app.grails.version=2.1.0") 2))
  (should (eql (grails-grep-version "WrongProperty=3.1.0") nil))
  (should (eql (grails-grep-version "#comment\nanother.app.grails.version=2") nil))
  (should (eql (grails-grep-version "another.grailsVersion=3") nil)))

(ert-deftest grails-test-clean-name ()
  "Test the grails-clean-name function."
  ;; controllers
  (should (equal
           (grails-clean-name
            "~/grails-app/controllers/TestController.groovy")
           "Test"))
  (should (equal
           (grails-clean-name
            "~/grails-app/controllers/pkg/TestController.groovy")
           "pkg/Test"))
  (should-not (equal
               (grails-clean-name
                "~/grails-app/controllers/pkg/TestController.groovy")
               "Test"))
  ;; domains
  (should (equal
           (grails-clean-name
            "~/grails-app/domain/Test.groovy")
           "Test"))
  (should (equal
           (grails-clean-name
            "~/grails-app/domain/pkg/Test.groovy")
           "pkg/Test"))
  (should-not (equal
               (grails-clean-name
                "~/grails-app/domain/pkg/Test.groovy")
               "Test"))
  ;; services
  (should (equal
           (grails-clean-name
            "~/grails-app/services/TestService.groovy")
           "Test"))
  (should (equal
           (grails-clean-name
            "~/grails-app/services/pkg/TestService.groovy")
           "pkg/Test"))
  (should-not (equal
               (grails-clean-name
                "~/grails-app/services/pkg/TestService.groovy")
               "Test"))
  ;; views
  (should-error (grails-clean-name
            "~/grails-app/views/myView.gsp"))
  ;; error
  (should-error (grails-clean-name
                 "~/grails-app/custom/Test.groovy")))

(ert-deftest grails-test-dir-by-type-and-name ()
  "Test internal function"
  (should (equal
           (grails-dir-by-type-and-name 'domain "User" "~/grails-app/")
           "~/grails-app/domain/User.groovy"))
  (should (equal
           (grails-dir-by-type-and-name 'controller "User" "~/grails-app/")
           "~/grails-app/controllers/UserController.groovy"))
  (should (equal
           (grails-dir-by-type-and-name 'service "User" "~/grails-app/")
           "~/grails-app/services/UserService.groovy"))
  (should (equal
           (grails-dir-by-type-and-name 'domain "pkg/User" "~/grails-app/")
           "~/grails-app/domain/pkg/User.groovy")))
