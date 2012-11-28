From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] fix build of unittest_formatter
Date: Wed, 28 Nov 2012 16:05:48 +0100
Message-ID: <1354115148-5549-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:42130 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754601Ab2K1PF6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 10:05:58 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Add CRYPTO_CXXFLAGS to unittest_formatter_CXXFLAGS to find pk11pub.h to
be included in src/common/ceph_crypto.h.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index be851d6..2f6f486 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -764,7 +764,7 @@ check_PROGRAMS += unittest_heartbeatmap
 unittest_formatter_SOURCES = test/formatter.cc rgw/rgw_formats.cc
 unittest_formatter_LDFLAGS = $(PTHREAD_CFLAGS) ${AM_LDFLAGS}
 unittest_formatter_LDADD = ${UNITTEST_LDADD} $(LIBGLOBAL_LDA)
-unittest_formatter_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
+unittest_formatter_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
 check_PROGRAMS += unittest_formatter
 
 unittest_libcephfs_config_SOURCES = test/libcephfs_config.cc
-- 
1.8.0

