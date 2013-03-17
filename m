From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 07/39] mds: mark connection down when MDS fails
Date: Sun, 17 Mar 2013 22:51:10 +0800
Message-ID: <1363531902-24909-8-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476Ab3CQOwL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:52:11 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

So if the MDS restarts and uses the same address, it does not get
old messages.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDS.cc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index 859782a..282fa64 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -1046,8 +1046,10 @@ void MDS::handle_mds_map(MMDSMap *m)
     oldmap->get_failed_mds_set(oldfailed);
     mdsmap->get_failed_mds_set(failed);
     for (set<int>::iterator p = failed.begin(); p != failed.end(); ++p)
-      if (oldfailed.count(*p) == 0)
+      if (oldfailed.count(*p) == 0) {
+	messenger->mark_down(oldmap->get_inst(*p).addr);
 	mdcache->handle_mds_failure(*p);
+      }
     
     // or down then up?
     //  did their addr/inst change?
@@ -1055,8 +1057,10 @@ void MDS::handle_mds_map(MMDSMap *m)
     mdsmap->get_up_mds_set(up);
     for (set<int>::iterator p = up.begin(); p != up.end(); ++p) 
       if (oldmap->have_inst(*p) &&
-	  oldmap->get_inst(*p) != mdsmap->get_inst(*p))
+	  oldmap->get_inst(*p) != mdsmap->get_inst(*p)) {
+	messenger->mark_down(oldmap->get_inst(*p).addr);
 	mdcache->handle_mds_failure(*p);
+      }
   }
   if (is_clientreplay() || is_active() || is_stopping()) {
     // did anyone stop?
-- 
1.7.11.7

