From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 1/6] Revert "Don't install rbd-fuse binary"
Date: Wed, 30 Jan 2013 19:00:40 +0100
Message-ID: <1359568845-7634-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51055 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756484Ab3A3SAt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jan 2013 13:00:49 -0500
In-Reply-To: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

This reverts commit 35e5d74e5c5786bc91df5dc10b5c08c77305df4e.

-> fix build instead
---
 src/Makefile.am | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index 996fd4e..c30c0c1 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -26,8 +26,6 @@ bin_PROGRAMS =
 # like bin_PROGRAMS, but these targets are only built for debug builds
 bin_DEBUGPROGRAMS =
 sbin_PROGRAMS =
-noinst_PROGRAMS =
-
 sbin_SCRIPTS = \
 	ceph-disk-prepare \
 	ceph-disk-activate \
@@ -166,7 +164,7 @@ bin_PROGRAMS += ceph-fuse
 rbd_fuse_SOURCES = rbd_fuse/rbd-fuse.c
 rbd_fuse_LDADD = -lfuse librados.la librbd.la $(LIBGLOBAL_LDA)
 rbd_fuse_CXXFLAGS = ${AM_CXXFLAGS}
-noinst_PROGRAMS += rbd-fuse
+bin_PROGRAMS += rbd-fuse
 
 endif
 
-- 
1.8.1.1

