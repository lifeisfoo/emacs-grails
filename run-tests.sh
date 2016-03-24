#!/bin/sh

txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
txtrst=$(tput sgr0)             # Reset

grails_elc=grails.elc

check_exit_status() {
    if [ $? -eq 0 ];then
        echo "$bldblu $1 passed $txtrst"
    else
        echo "$bldred $1 FAILED $txtrst"
    fi
}

emacs --debug-init -batch -l ert -L . -l grails-test.el -f ert-run-tests-batch-and-exit

check_exit_status "Unit tests"

emacs -batch -L . -f batch-byte-compile grails.el

check_exit_status "Byte compiling"

if [ -e "$grails_elc" ]
then
    rm "$grails_elc"
fi
