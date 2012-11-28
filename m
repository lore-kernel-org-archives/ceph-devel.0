From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 02/30] ceph_fuse.cc: remove twice included sys/stat.h
Date: Wed, 28 Nov 2012 13:57:10 +0100
Message-ID: <1354107458-30941-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34467 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754718Ab2K1M5m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 07:57:42 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included sys/stat.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/ceph_fuse.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/ceph_fuse.cc b/src/ceph_fuse.cc
index e645777..09aadb4 100644
--- a/src/ceph_fuse.cc
+++ b/src/ceph_fuse.cc
@@ -37,7 +37,6 @@ using namespace std;
 #endif // DARWIN
 
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <fcntl.h>
 
 void usage()
-- 
1.8.0

