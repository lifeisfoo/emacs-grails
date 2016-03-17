#!/bin/sh
emacs --debug-init -batch -l ert -L . -l grails-test.el -f ert-run-tests-batch-and-exit
