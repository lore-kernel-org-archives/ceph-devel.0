From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH] Use LIBEDIT_LIBS in Makefile.am
Date: Wed, 28 Sep 2011 10:47:34 +0200
Message-ID: <201109280847.p8S8lYS9003894@pentland.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42282 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab1I1Irj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Sep 2011 04:47:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


The editline library might require some additional libs, so
instead of hardcoding '-ledit' we should be using LIBEDIT_LIBS
in Makefile.am

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 src/Makefile.am |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index 704f1fa..b7ab7ae 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -49,7 +49,7 @@ ceph_SOURCES = \
 	tools/ceph.cc \
 	tools/common.cc \
 	mon/PGMap.cc
-ceph_LDADD = $(LIBGLOBAL_LDA) -ledit
+ceph_LDADD = $(LIBGLOBAL_LDA) $(LIBEDIT_LIBS)
 ceph_CXXFLAGS = ${AM_CXXFLAGS}
 
 if WITH_GTK2
@@ -77,7 +77,7 @@ gceph_SOURCES = \
 	mon/PGMap.cc \
 	tools/gceph.cc \
 	tools/gui.cc
-gceph_LDADD = $(LIBGLOBAL_LDA) -ledit $(GTKMM_LIBS)
+gceph_LDADD = $(LIBGLOBAL_LDA) $(LIBEDIT_LIBS) $(GTKMM_LIBS)
 gceph_CXXFLAGS = ${AM_CXXFLAGS} $(GTKMM_CFLAGS) \
 	-DCEPH_TOOL_GUIDIR="\"${ceph_tool_guidir}\""
 bin_PROGRAMS += gceph
@@ -955,7 +955,7 @@ libclient_la_SOURCES = \
 	client/Inode.cc \
 	client/MetaRequest.cc \
 	client/Trace.cc
-libclient_la_LIBADD = libcommon.la
+libclient_la_LIBADD = libcommon.la $(LIBEDIT_LIBS)
 noinst_LTLIBRARIES += libclient.la
 
 dist-hook:
-- 
1.6.0.2

