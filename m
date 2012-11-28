From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 07/30] client/Client.cc: remove twice included headers
Date: Wed, 28 Nov 2012 13:57:15 +0100
Message-ID: <1354107458-30941-8-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34470 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754787Ab2K1M5m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 07:57:42 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included common/config.h". Remove include
of sys/param.h in special __FreeBSD__ section, since this file is
included in general anyway

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/client/Client.cc | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 35cba96..b808f20 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -25,10 +25,6 @@
 
 #include <sys/statvfs.h>
 
-#if defined(__FreeBSD__)
-#include <sys/param.h>
-#endif
-
 #include <iostream>
 using namespace std;
 
@@ -67,8 +63,6 @@ using namespace std;
 #include "common/admin_socket.h"
 #include "common/errno.h"
 
-#include "common/config.h"
-
 #define dout_subsys ceph_subsys_client
 
 #include "include/lru.h"
-- 
1.8.0

