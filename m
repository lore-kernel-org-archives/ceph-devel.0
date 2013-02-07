From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 12/15] src/osd/PG.h: use empty() instead of size()
Date: Thu,  7 Feb 2013 20:42:00 +0100
Message-ID: <1360266123-28972-13-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34177 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759228Ab3BGTso (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:48:44 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix warning for usage of objects.size(). Use empty() since it
should be prefered as it has, following the standard, a constant
time complexity regardless of the containter type. The same is not
guaranteed for size().

warning from cppchecker was:
[osd/PG.h:599]: (performance) Possible inefficient checking for
  'objects' emptiness.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/osd/PG.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/osd/PG.h b/src/osd/PG.h
index ba80f81..3c95058 100644
--- a/src/osd/PG.h
+++ b/src/osd/PG.h
@@ -596,7 +596,7 @@ protected:
 
     /// Adjusts begin to the first object
     void trim() {
-      if (objects.size())
+      if (!objects.empty())
 	begin = objects.begin()->first;
       else
 	begin = end;
-- 
1.8.1.2

