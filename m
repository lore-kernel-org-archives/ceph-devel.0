From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Broken build on current unstable branch
Date: Wed, 17 Nov 2010 12:06:12 -0700
Message-ID: <1290020772.6990.23.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:37411 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758687Ab0KQTGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Nov 2010 14:06:23 -0500
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 159254EA6EF
	for <ceph-devel@vger.kernel.org>; Wed, 17 Nov 2010 12:06:17 -0700 (MST)
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id oAHJ63u7016670 for
 <ceph-devel@vger.kernel.org>; Wed, 17 Nov 2010 12:06:03 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Build for current unstable (d57181d3d5b0) 
is broken for me on RedHat 5.5, like this:

make  all-am
make[2]: Entering directory `/bigdata1/home/jaschut/git/ceph.git/src'
make[2]: *** No rule to make target `/ceph_ver.c', needed by `ceph_ver.o'.  Stop.
make[2]: Leaving directory `/bigdata1/home/jaschut/git/ceph.git/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/bigdata1/home/jaschut/git/ceph.git/src'
make: *** [all-recursive] Error 1


This fixes the above for me:

diff --git a/src/Makefile.am b/src/Makefile.am
index 7bf088e..487f205 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -398,7 +398,7 @@ clean-local:
 
 # libs
 libcommon_a_SOURCES = \
-	$(builddir)/ceph_ver.c \
+	$(srcdir)/ceph_ver.c \
 	$(libcommon_files)
 
 # this list ommits the ceph_ver.c file


With the above, the build then breaks like this:

make  all-am
make[2]: Entering directory `/bigdata1/home/jaschut/git/ceph.git/src'
make[2]: *** No rule to make target `/ceph_ver.h', needed by `ceph_ver.c'.  Stop.
make[2]: Leaving directory `/bigdata1/home/jaschut/git/ceph.git/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/bigdata1/home/jaschut/git/ceph.git/src'
make: *** [all-recursive] Error 1


Evidently, for this version of automake (1.9.6), $(builddir)
is empty; e.g. I found this:
http://www.mail-archive.com/automake@gnu.org/msg15428.html

FWIW, the following, when added to the above, fixes the build for me:

diff --git a/src/Makefile.am b/src/Makefile.am
index 7bf088e..38916c8 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -352,8 +352,8 @@ docdir = ${datadir}/doc/ceph
 doc_DATA = $(srcdir)/sample.ceph.conf
 doc_SCRIPTS = sample.fetch_config
 
-sample.fetch_config: fetch_config
-	cp -f $(srcdir)/fetch_config $(builddir)/sample.fetch_config
+ $(top_builddir)/src/sample.fetch_config: fetch_config
+	cp -f $(srcdir)/fetch_config $(top_builddir)/src/sample.fetch_config
 
 shell_commondir = $(libdir)/ceph
 shell_common_SCRIPTS = ceph_common.sh
@@ -382,13 +382,13 @@ crush_include_DATA = \
 FORCE:
 .git_version: FORCE
 	$(srcdir)/check_version $(srcdir)/.git_version
-ceph_ver.h: .git_version
-	$(srcdir)/make_version $(srcdir)/.git_version $(builddir)/ceph_ver.h
+$(top_builddir)/src/ceph_ver.h: .git_version
+	$(srcdir)/make_version $(srcdir)/.git_version $(top_builddir)/src/ceph_ver.h
 
-ceph_ver.c: $(builddir)/ceph_ver.h
-common/debug.cc: $(builddir)/ceph_ver.h
-common/BackTrace.cc: $(builddir)/ceph_ver.h
-config.cc: $(builddir)/ceph_ver.h
+ceph_ver.c: $(top_builddir)/src/ceph_ver.h
+common/debug.cc: $(top_builddir)/src/ceph_ver.h
+common/BackTrace.cc: $(top_builddir)/src/ceph_ver.h
+config.cc: $(top_builddir)/src/ceph_ver.h
 
 # cleaning
 clean-local:
@@ -398,7 +398,7 @@ clean-local:
 
 # libs
 libcommon_a_SOURCES = \
-       $(builddir)/ceph_ver.c \
+       $(srcdir)/ceph_ver.c \
        $(libcommon_files)
 
 # this list ommits the ceph_ver.c file


Also FWIW, the following alternative, in addition to
the ceph_ver.c fix above, also fixes the build for me:

diff --git a/src/Makefile.am b/src/Makefile.am
index 7bf088e..c3db491 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -353,7 +353,7 @@ doc_DATA = $(srcdir)/sample.ceph.conf
 doc_SCRIPTS = sample.fetch_config
 
 sample.fetch_config: fetch_config
-	cp -f $(srcdir)/fetch_config $(builddir)/sample.fetch_config
+	cp -f $(srcdir)/fetch_config sample.fetch_config
 
 shell_commondir = $(libdir)/ceph
 shell_common_SCRIPTS = ceph_common.sh
@@ -383,12 +383,12 @@ FORCE:
 .git_version: FORCE
 	$(srcdir)/check_version $(srcdir)/.git_version
 ceph_ver.h: .git_version
-	$(srcdir)/make_version $(srcdir)/.git_version $(builddir)/ceph_ver.h
+	$(srcdir)/make_version $(srcdir)/.git_version ceph_ver.h
 
-ceph_ver.c: $(builddir)/ceph_ver.h
-common/debug.cc: $(builddir)/ceph_ver.h
-common/BackTrace.cc: $(builddir)/ceph_ver.h
-config.cc: $(builddir)/ceph_ver.h
+ceph_ver.c: ceph_ver.h
+common/debug.cc: ceph_ver.h
+common/BackTrace.cc: ceph_ver.h
+config.cc: ceph_ver.h
 
 # cleaning
 clean-local:


If any of the above is commit-worthy:

Signed-off-by: Jim Schutt <jaschut@sandia.gov>

Thanks -- Jim



