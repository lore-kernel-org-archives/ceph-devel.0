From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH -v2] Generic libcephfs Java bindings
Date: Wed, 14 Mar 2012 23:21:41 -0700
Message-ID: <575E1B43-986C-4165-AF8E-B6C256263498@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:55091 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab2COGVn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Mar 2012 02:21:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>, Greg Farnum <gregory.farnum@dreamhost.com>, Joe Buck <buck@soe.ucsc.edu>, Noah Watkins <jayhawk@soe.ucsc.edu>

This is version 2 of the generic libcephfs Java bindings based on feedback from the original patch set (thanks!). The short-log at the bottom of the e-mail shows the commits made based on feedback, but the Git branch below has them all rebased into fewer patches for a clean history.

Thanks,
- Noah

Consolidated patch set is available in the git repository at:

  git://github.com/noahdesu/ceph wip/java-cephfs

Noah Watkins (3):
      java: add Java and C++ source files
      automake: setup autotools to build cephfs-java
      debian: add libcephfs-java package

Sage Weil (2):
      do_autogen.sh: add -j flag to enable java stuff
      Makefile: add src/include to #include path for libcephfs_jni_la

============================================================
Original change log based on feedback
============================================================

Noah Watkins (12):
      java: add Java and C++ source files
      java: setup autotools to build cephfs-java
      debian: add libcephfs-java package
      java: add MIT license
      java: document valid states in JavaDoc
      java: order methods according to libcephfs.h
      java: fix typo; update testing notes
      java: remove redundant mount() interface
      java: use protected getdnames(int bufSize)
      java: switch classpath to com.ceph.fs
      java: remove unused macro
      java: document CPP macro-foo

Sage Weil (2):
      do_autogen.sh: add -j flag to enable java stuff
      Makefile: add src/include to #include path for libcephfs_jni_la

 configure.ac                                       |   74 ++
 debian/.gitignore                                  |    1 +
 debian/control                                     |    8 +-
 debian/libceph1-java.install                       |    2 +
 debian/rules                                       |    1 +
 do_autogen.sh                                      |    5 +-
 src/Makefile.am                                    |   15 +-
 src/java/.gitignore                                |    4 +
 src/java/Makefile.am                               |   49 +
 src/java/README                                    |   48 +
 src/java/build.xml                                 |   67 ++
 src/java/java/com/ceph/fs/CephConstants.java       |   57 +
 src/java/java/com/ceph/fs/CephDirectory.java       |  122 +++
 src/java/java/com/ceph/fs/CephException.java       |   40 +
 .../com/ceph/fs/CephInvalidStateException.java     |   30 +
 src/java/java/com/ceph/fs/CephMount.java           |  449 ++++++++
 src/java/java/com/ceph/fs/CephNativeLoader.java    |   35 +
 src/java/java/com/ceph/fs/CephProxy.java           |  235 +++++
 src/java/java/com/ceph/fs/CephStat.java            |   34 +
 src/java/java/com/ceph/fs/CephStatVFS.java         |   33 +
 src/java/java/com/ceph/fs/CephStruct.java          |   55 +
 src/java/native/libcephfs_jni.cc                   | 1069 ++++++++++++++++++++
 src/java/test/CephMountCreateTest.java             |   92 ++
 src/java/test/CephMountTest.java                   |  101 ++
 24 files changed, 2623 insertions(+), 3 deletions(-)
 create mode 100644 debian/libceph1-java.install
 create mode 100644 src/java/.gitignore
 create mode 100644 src/java/Makefile.am
 create mode 100644 src/java/README
 create mode 100644 src/java/build.xml
 create mode 100644 src/java/java/com/ceph/fs/CephConstants.java
 create mode 100644 src/java/java/com/ceph/fs/CephDirectory.java
 create mode 100644 src/java/java/com/ceph/fs/CephException.java
 create mode 100644 src/java/java/com/ceph/fs/CephInvalidStateException.java
 create mode 100644 src/java/java/com/ceph/fs/CephMount.java
 create mode 100644 src/java/java/com/ceph/fs/CephNativeLoader.java
 create mode 100644 src/java/java/com/ceph/fs/CephProxy.java
 create mode 100644 src/java/java/com/ceph/fs/CephStat.java
 create mode 100644 src/java/java/com/ceph/fs/CephStatVFS.java
 create mode 100644 src/java/java/com/ceph/fs/CephStruct.java
 create mode 100644 src/java/native/libcephfs_jni.cc
 create mode 100644 src/java/test/CephMountCreateTest.java
 create mode 100644 src/java/test/CephMountTest.java

