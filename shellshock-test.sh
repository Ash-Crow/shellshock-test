#!/bin/bash
# Based on http://lacuisinedegandi.net/post/2014/09/30/ShellShock-%3A-statut

echo "==== Test 1: CVE-2014-6271 ===="
echo -e "Should not print 'vulnerable'\n"

env x='() { :;}; echo vulnerable' bash -c "echo this is a test"

echo -e "\n\n=========================== \n"

echo "==== Test 2: CVE-2014-7169 ===="
echo -e "Should not print the date and time\n"

cd /tmp; env x='() { (a)=>\' bash -c "echo date"; cat echo


echo -e "\n\n=========================== \n"

echo "==== Test 3: CVE-2014-7186 ===="
echo -e "Should not print 'CVE-2014-7186 vulnerable, redir_stack'\n"

bash -c 'true <<EOF <<EOF <<EOF  <<EOF <<EOF \
<<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF \
<<EOF <<EOF' || echo "CVE-2014-7186 vulnerable, redir_stack"


echo -e "\n\n=========================== \n"

echo "==== Test 4: CVE-2014-7187 ===="
echo -e "Should not print 'CVE-2014-7187 vulnerable, word_lineno'\n"

(for x in {1..200} ; do echo "for x$x in ; do :"; done;  \
for x in {1..200} ; do echo done ; done) | \
bash || echo "CVE-2014-7187  vulnerable, word_lineno"
