From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 19/30] messages/MClientRequest.h: remove twice included sys/types.h
Date: Wed, 28 Nov 2012 13:57:27 +0100
Message-ID: <1354107458-30941-20-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34824 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755092Ab2K1NER (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:04:17 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included sys/types.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/messages/MClientRequest.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/messages/MClientRequest.h b/src/messages/MClientRequest.h
index e8ce763..9dc9383 100644
--- a/src/messages/MClientRequest.h
+++ b/src/messages/MClientRequest.h
@@ -40,7 +40,6 @@
 #include <sys/types.h>
 #include <utime.h>
 #include <sys/stat.h>
-#include <sys/types.h>
 #include <fcntl.h>
 
 
-- 
1.8.0

