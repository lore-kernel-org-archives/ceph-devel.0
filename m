From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 08/15] src/log/Entry.h: pass function parameter by reference
Date: Thu,  7 Feb 2013 20:41:56 +0100
Message-ID: <1360266123-28972-9-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33790 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932195Ab3BGTmJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:42:09 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix "(performance) Function parameter 's' should be passed by reference."
from cppchecker.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/log/Entry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/log/Entry.h b/src/log/Entry.h
index 7f6b149..7cdf116 100644
--- a/src/log/Entry.h
+++ b/src/log/Entry.h
@@ -40,7 +40,7 @@ struct Entry {
     }
   }
 
-  void set_str(const std::string s) {
+  void set_str(const std::string &s) {
     ostream os(&m_streambuf);
     os << s;
   }
-- 
1.8.1.2

