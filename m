From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 23/30] os/DBObjectMap.h: remove twice included <string>
Date: Wed, 28 Nov 2012 13:57:31 +0100
Message-ID: <1354107458-30941-24-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34858 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754999Ab2K1NE4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:04:56 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included <string>

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/os/DBObjectMap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/os/DBObjectMap.h b/src/os/DBObjectMap.h
index cccc331..18c6ce4 100644
--- a/src/os/DBObjectMap.h
+++ b/src/os/DBObjectMap.h
@@ -7,7 +7,6 @@
 #include <map>
 #include <string>
 
-#include <string>
 #include <vector>
 #include <tr1/memory>
 #include <boost/scoped_ptr.hpp>
-- 
1.8.0

