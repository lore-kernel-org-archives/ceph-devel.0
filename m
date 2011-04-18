From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Java-rados announcement
Date: Sun, 17 Apr 2011 18:34:23 -0700
Message-ID: <D20F8B6A-0A44-41BA-B98C-5956E8CBA55E@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:43495 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab1DRBeY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 21:34:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Noah Watkins <noahwatkins@gmail.com>

I've put together Java bindings for RADOS available at:

  git://github.com/noahdesu/ceph.git java-rados

Contains:
  - Bindings with JNI
  - Full set of unit tests
  - JavaDoc markup

Thanks,
Noah

 .gitignore                                         |    1 +
 configure.ac                                       |    1 +
 src/bindings/java/.gitignore                       |    4 +
 src/bindings/java/README                           |   45 ++
 src/bindings/java/build.xml                        |   83 +++
 .../java/java/net/newdream/ceph/rados/Cluster.java |  249 +++++++++
 .../java/net/newdream/ceph/rados/ClusterStats.java |   75 +++
 .../java/net/newdream/ceph/rados/IOContext.java    |  332 +++++++++++
 .../net/newdream/ceph/rados/ObjectIterator.java    |   77 +++
 .../java/net/newdream/ceph/rados/PoolStats.java    |  130 +++++
 .../net/newdream/ceph/rados/RadosException.java    |   28 +
 .../java/net/newdream/ceph/rados/RadosObject.java  |  169 ++++++
 .../java/net/newdream/ceph/rados/RadosVersion.java |   54 ++
 src/bindings/java/native/Makefile.am               |   30 +
 src/bindings/java/native/common.h                  |   19 +
 src/bindings/java/native/exceptions.c              |   78 +++
 .../java/native/net_newdream_ceph_rados_Cluster.c  |  520 +++++++++++++++++
 .../java/native/net_newdream_ceph_rados_Cluster.h  |  125 +++++
 .../native/net_newdream_ceph_rados_ClusterStats.c  |   41 ++
 .../native/net_newdream_ceph_rados_ClusterStats.h  |   21 +
 .../native/net_newdream_ceph_rados_IOContext.c     |  588 ++++++++++++++++++++
 .../native/net_newdream_ceph_rados_IOContext.h     |  125 +++++
 .../net_newdream_ceph_rados_ObjectIterator.c       |   63 +++
 .../net_newdream_ceph_rados_ObjectIterator.h       |   37 ++
 .../native/net_newdream_ceph_rados_PoolStats.c     |   50 ++
 .../native/net_newdream_ceph_rados_PoolStats.h     |   21 +
 .../native/net_newdream_ceph_rados_RadosVersion.c  |   31 +
 .../native/net_newdream_ceph_rados_RadosVersion.h  |   21 +
 src/bindings/java/test/ClusterStatsTest.java       |   31 +
 src/bindings/java/test/ClusterTest.java            |  139 +++++
 src/bindings/java/test/IOContextTest.java          |  190 +++++++
 src/bindings/java/test/PoolStatsTest.java          |   47 ++
 src/bindings/java/test/RadosObjectTest.java        |  105 ++++
 src/bindings/java/test/RadosTestUtils.java         |   11 +
 src/bindings/java/test/RadosVersionTest.java       |   14 +
 35 files changed, 3555 insertions(+), 0 deletions(-)


