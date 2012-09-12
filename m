From: Jan Engelhardt <jengelh@inai.de>
Subject: [PATCH 1/6] build: do not modify user variables
Date: Wed, 12 Sep 2012 04:22:02 +0200
Message-ID: <1347416527-19752-2-git-send-email-jengelh@inai.de>
References: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ares07.inai.de ([5.9.24.206]:48868 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759273Ab2ILCWQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Sep 2012 22:22:16 -0400
In-Reply-To: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

(automake-1.12 even reports this)

Makefile.am:12: warning: 'CFLAGS' is a user variable, you should
not override it;
Makefile.am:12: use 'AM_CFLAGS' instead
Makefile.am:18: warning: 'LDFLAGS' is a user variable, you should
not override it;
Makefile.am:18: use 'AM_LDFLAGS' instead
Makefile.am:14: warning: 'CXXFLAGS' is a user variable, you should
not override it;
Makefile.am:14: use 'AM_CXXFLAGS' instead

Also, libs _must absolutely not_ appear in LDFLAGS -
LDADD is appropriate here.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 Makefile.am |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 3488eba..25a24de 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -9,16 +9,17 @@ OPT ?= -O2 -DNDEBUG       # (A) Production use (optimized mode)
 
 # TODO maybe support android & chromium platforms via automake too?
 
-CFLAGS = -I$(srcdir)/include $(OPT) -pthread -fno-builtin-memcmp -DLEVELDB_PLATFORM_POSIX
+AM_CFLAGS = -I$(srcdir)/include $(OPT) -pthread -fno-builtin-memcmp -DLEVELDB_PLATFORM_POSIX
 
-CXXFLAGS = -I$(srcdir)/include $(OPT) -pthread -fno-builtin-memcmp -DLEVELDB_PLATFORM_POSIX
+AM_CXXFLAGS = -I$(srcdir)/include $(OPT) -pthread -fno-builtin-memcmp -DLEVELDB_PLATFORM_POSIX
 if CSTDATOMIC
-CXXFLAGS += -DLEVELDB_CSTDATOMIC_PRESENT -std=c++0x
+AM_CXXFLAGS += -DLEVELDB_CSTDATOMIC_PRESENT -std=c++0x
 endif
-LDFLAGS = -pthread
+AM_LDFLAGS = -pthread
 
+LDADD =
 if WITH_TCMALLOC
-LDFLAGS += -ltcmalloc
+LDADD += -ltcmalloc
 endif
 
 # items will be appended to this
-- 
1.7.10.4

