From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] Makefile: fix modules that cannot find pk11pub.h when
 compiling with NSS on RHEL6
Date: Wed, 21 Mar 2012 10:09:09 -0600
Message-ID: <1332346149-32656-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:34518 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757912Ab2CUQJj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 12:09:39 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 124BD26B2F6
	for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 10:09:33 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 10:09:27 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/Makefile.am |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index cdfb43d..2062d1c 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -48,7 +48,7 @@ if LINUX
 ceph_osd_LDADD += -ldl
 endif
 bin_PROGRAMS += ceph-osd
-ceph_osd_CXXFLAGS = ${AM_CXXFLAGS} \
+ceph_osd_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS} \
 	-I$(top_srcdir)/src/leveldb/include
 
 # mds
@@ -111,6 +111,7 @@ osdmaptool_LDADD = $(LIBGLOBAL_LDA)
 bin_PROGRAMS += monmaptool crushtool osdmaptool
 
 ceph_dencoder_SOURCES = test/encoding/ceph_dencoder.cc
+ceph_dencoder_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
 ceph_dencoder_LDADD = $(LIBGLOBAL_LDA) libosd.la libmds.a libos.la libmon.la
 bin_PROGRAMS += ceph-dencoder
 
@@ -1010,6 +1011,7 @@ libmon_la_SOURCES = \
 	mon/AuthMonitor.cc \
 	mon/Elector.cc \
 	mon/MonitorStore.cc
+libmon_la_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
 libmon_la_LIBADD = libglobal.la
 noinst_LTLIBRARIES += libmon.la
 
@@ -1078,6 +1080,7 @@ libosdc_la_SOURCES = \
 	osdc/ObjectCacher.cc \
 	osdc/Filer.cc \
 	osdc/Journaler.cc
+libosdc_la_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
 libosdc_la_LIBADD = libcommon.la
 noinst_LTLIBRARIES += libosdc.la
 
-- 
1.7.8.2


