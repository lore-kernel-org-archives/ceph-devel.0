From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 09/30] client/SyntheticClient.cc: remove twice included headers
Date: Wed, 28 Nov 2012 13:57:17 +0100
Message-ID: <1354107458-30941-10-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34461 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754664Ab2K1M5l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 07:57:41 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included common/config.h and sys/types.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/client/SyntheticClient.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/client/SyntheticClient.cc b/src/client/SyntheticClient.cc
index f081244..b2a936f 100644
--- a/src/client/SyntheticClient.cc
+++ b/src/client/SyntheticClient.cc
@@ -29,12 +29,10 @@ using namespace std;
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <sys/types.h>
 #include <utime.h>
 #include <math.h>
 #include <sys/statvfs.h>
 
-#include "common/config.h"
 #include "include/assert.h"
 
 #define dout_subsys ceph_subsys_client
-- 
1.8.0

