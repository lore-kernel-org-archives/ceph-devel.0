From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 01/30] fusetrace_ll.cc: remove twice included sys/time.h
Date: Wed, 28 Nov 2012 13:57:09 +0100
Message-ID: <1354107458-30941-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34458 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754645Ab2K1M5l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 07:57:41 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included sys/time.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 fusetrace/fusetrace_ll.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fusetrace/fusetrace_ll.cc b/fusetrace/fusetrace_ll.cc
index 9a0a076..1b0d45f 100644
--- a/fusetrace/fusetrace_ll.cc
+++ b/fusetrace/fusetrace_ll.cc
@@ -30,7 +30,6 @@
 #ifdef HAVE_SETXATTR
 #include <sys/xattr.h>
 #endif
-#include <sys/time.h>
 #include <time.h>
 
 
-- 
1.8.0

