From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 28/30] remove twice included linux/types.h
Date: Wed, 28 Nov 2012 13:57:36 +0100
Message-ID: <1354107458-30941-29-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34778 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754597Ab2K1ND3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:03:29 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Cleanup includes: remove twice included linux/types.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 qa/workunits/direct_io/test_sync_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qa/workunits/direct_io/test_sync_io.c b/qa/workunits/direct_io/test_sync_io.c
index 1a84fee..613631e 100644
--- a/qa/workunits/direct_io/test_sync_io.c
+++ b/qa/workunits/direct_io/test_sync_io.c
@@ -12,7 +12,6 @@
 //#include "../client/ioctl.h"
 
 #include <linux/ioctl.h>
-#include <linux/types.h>
 #define CEPH_IOCTL_MAGIC 0x97
 #define CEPH_IOC_SYNCIO _IO(CEPH_IOCTL_MAGIC, 5)
 
-- 
1.8.0

