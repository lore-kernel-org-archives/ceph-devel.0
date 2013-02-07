From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 11/15] src/osd/OSD.h: use empty() instead of size()
Date: Thu,  7 Feb 2013 20:41:59 +0100
Message-ID: <1360266123-28972-12-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34129 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756283Ab3BGTrU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:47:20 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix warning for usage of *.size(). Use empty() since it should be
prefered as it has, following the standard, a constant time
complexity regardless of the containter type. The same is not
guaranteed for size().

warning from cppchecker was:
[osd/OSD.h:265]: (performance) Possible inefficient checking for
   'last_scrub_pg' emptiness.
[osd/OSD.h:274]: (performance) Possible inefficient checking for
   'last_scrub_pg' emptiness.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/osd/OSD.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/osd/OSD.h b/src/osd/OSD.h
index b411c17..03d78cc 100644
--- a/src/osd/OSD.h
+++ b/src/osd/OSD.h
@@ -262,7 +262,7 @@ public:
   }
   bool first_scrub_stamp(pair<utime_t, pg_t> *out) {
     Mutex::Locker l(sched_scrub_lock);
-    if (last_scrub_pg.size() == 0)
+    if (last_scrub_pg.empty())
       return false;
     set< pair<utime_t, pg_t> >::iterator iter = last_scrub_pg.begin();
     *out = *iter;
@@ -271,7 +271,7 @@ public:
   bool next_scrub_stamp(pair<utime_t, pg_t> next,
 			pair<utime_t, pg_t> *out) {
     Mutex::Locker l(sched_scrub_lock);
-    if (last_scrub_pg.size() == 0)
+    if (last_scrub_pg.empty())
       return false;
     set< pair<utime_t, pg_t> >::iterator iter = last_scrub_pg.lower_bound(next);
     if (iter == last_scrub_pg.end())
-- 
1.8.1.2

