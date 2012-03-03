From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Fri, 02 Mar 2012 16:47:28 -0800
Message-ID: <4F516A20.8060901@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:51305 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab2CCAr2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 19:47:28 -0500
Received: from martini.local (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id AEE941008A88
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 16:47:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Generic libcephfs Java wrappers.

This is the first of a patch series that can eventually replace the current Java wrappers that are Hadoop specific. This group implements enough of the libcephfs API to support Hadoop functionality, includes Debian packaging, autoconf magics that look for default Java installations, and some basic JUnit tests.

The patches are available in the git repository at:

  git://github.com/noahdesu/ceph.git wip/java-cephfs

Noah Watkins (3):
  java: add Java and C++ source files
  java: setup autotools to build cephfs-java
  debian: add libcephfs-java package

 configure.ac                                       |   74 ++
 debian/.gitignore                                  |    1 +
 debian/control                                     |    8 +-
 debian/libceph1-java.install                       |    2 +
 debian/rules                                       |    1 +
 src/Makefile.am                                    |   15 +-
 src/java/.gitignore                                |    4 +
 src/java/Makefile.am                               |   49 +
 src/java/README                                    |   43 +
 src/java/build.xml                                 |   67 ++
 .../java/net/newdream/ceph/fs/CephConstants.java   |   38 +
 .../java/net/newdream/ceph/fs/CephDirectory.java   |   84 ++
 .../java/net/newdream/ceph/fs/CephException.java   |   21 +
 .../ceph/fs/CephInvalidStateException.java         |   11 +
 src/java/java/net/newdream/ceph/fs/CephMount.java  |  360 +++++++
 .../net/newdream/ceph/fs/CephNativeLoader.java     |   16 +
 src/java/java/net/newdream/ceph/fs/CephProxy.java  |  217 ++++
 src/java/java/net/newdream/ceph/fs/CephStat.java   |   15 +
 .../java/net/newdream/ceph/fs/CephStatVFS.java     |   14 +
 src/java/java/net/newdream/ceph/fs/CephStruct.java |   33 +
 src/java/native/libcephfs_jni.cc                   | 1037 ++++++++++++++++++++
 src/java/test/CephMountCreateTest.java             |   76 ++
 src/java/test/CephMountTest.java                   |   72 ++
 23 files changed, 2256 insertions(+), 2 deletions(-)
 create mode 100644 debian/libceph1-java.install
 create mode 100644 src/java/.gitignore
 create mode 100644 src/java/Makefile.am
 create mode 100644 src/java/README
 create mode 100644 src/java/build.xml
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephConstants.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephDirectory.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephException.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephInvalidStateException.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephMount.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephNativeLoader.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephProxy.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephStat.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephStatVFS.java
 create mode 100644 src/java/java/net/newdream/ceph/fs/CephStruct.java
 create mode 100644 src/java/native/libcephfs_jni.cc
 create mode 100644 src/java/test/CephMountCreateTest.java
 create mode 100644 src/java/test/CephMountTest.java

-- 
1.7.5.4
