(require 'ert)
(require 'grails)

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
  (should (equal
           (grails-clean-name
            "~/grails-app/views/myView.gsp")
           'views))
  ;; error
  (should-error (grails-clean-name
                 "~/grails-app/custom/Test.groovy")))

(ert-deftest grails-test-app-base ()
  "Tests the grails-app-base function."
  (should (equal
           (grails-app-base
            "/path/grails-app/domain/Test.groovy")
           "/path/grails-app/"))
  (should-not (equal
               (grails-app-base
                "/path/grails-app/domain/Test.groovy")
               "/path/grails-app"))
  (should-not (equal
               (grails-app-base
                "/path/grails-app/domain/Test.groovy")
               "/error/"))
  (should (equal
           (grails-app-base
            "/not/a/grails/path")
           nil)))

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

(ert-deftest grails-test-find-file-auto ()
  "Tests the grails-find-file-auto function."
  (should (equal
           (grails-find-file-auto 'domain "~/grails-app/controllers/UserController.groovy")
           "~/grails-app/domain/User.groovy"))
  (should (equal
           (grails-find-file-auto 'controller "~/grails-app/domain/User.groovy")
           "~/grails-app/controllers/UserController.groovy"))
  (should (equal
           (grails-find-file-auto 'service "~/grails-app/domain/User.groovy")
           "~/grails-app/services/UserService.groovy"))
  (should-error (grails-find-auto 'zervice "~/grails-app/domain/User.groovy")))
