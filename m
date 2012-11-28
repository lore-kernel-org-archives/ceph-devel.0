From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 14/30] librados/RadosClient.cc: remove twice included sys/stat.h
Date: Wed, 28 Nov 2012 13:57:22 +0100
Message-ID: <1354107458-30941-15-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34565 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754927Ab2K1M7T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 07:59:19 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included sys/stat.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/librados/RadosClient.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/librados/RadosClient.cc b/src/librados/RadosClient.cc
index ae56c76..7e76b65 100644
--- a/src/librados/RadosClient.cc
+++ b/src/librados/RadosClient.cc
@@ -16,7 +16,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
-#include <sys/stat.h>
 #include <iostream>
 #include <string>
 #include <pthread.h>
-- 
1.8.0

