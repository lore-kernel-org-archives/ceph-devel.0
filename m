From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 10/15] src/msg/Messenger.h: pass function parameter by reference
Date: Thu,  7 Feb 2013 20:41:58 +0100
Message-ID: <1360266123-28972-11-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34161 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759075Ab3BGTsE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:48:04 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix "(performance) Function parameter 'm' should be passed by reference."
from cppchecker.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/msg/Messenger.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/msg/Messenger.h b/src/msg/Messenger.h
index b75e442..f47c2cf 100644
--- a/src/msg/Messenger.h
+++ b/src/msg/Messenger.h
@@ -184,7 +184,7 @@ public:
    *
    * @param m The name to set.
    */
-  void set_myname(const entity_name_t m) { my_inst.name = m; }
+  void set_myname(const entity_name_t& m) { my_inst.name = m; }
   /**
    * Set the unknown address components for this Messenger.
    * This is useful if the Messenger doesn't know its full address just by
-- 
1.8.1.2

