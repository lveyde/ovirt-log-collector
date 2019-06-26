#!/bin/bash -xe
[[ -d exported-artifacts ]] \
|| mkdir -p exported-artifacts

[[ -d tmp.repos ]] \
|| mkdir -p tmp.repos

autoreconf -ivf
./configure
make dist
yum-builddep ovirt-log-collector.spec
rpmbuild \
    -D "_topdir $PWD/tmp.repos" \
    -ta ovirt-log-collector-*.tar.gz

mv *.tar.gz exported-artifacts
find \
    "$PWD/tmp.repos" \
    -iname \*.rpm \
    -exec mv {} exported-artifacts/ \;
