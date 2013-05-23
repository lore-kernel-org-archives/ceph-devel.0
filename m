From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 21/30] mds: warn on unconnected snap realms
Date: Thu, 23 May 2013 16:06:49 +0800
Message-ID: <1369296418-14871-22-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39281 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386Ab3EWINP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:15 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When there are more than one active MDS, restarting MDS triggers
assertion "reconnected_snaprealms.empty()" quite often. If there
is no snapshot in the FS, the items left in reconnected_snaprealms
should be other MDS' mdsdir. I think it's harmless.

If there are snapshots in the FS, the assertion probably can catch
real bugs. But at present, snapshot feature is broken, fixing it is
non-trivial. So replace the assertion with a warning.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index a67f605..8fc1ab8 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5213,9 +5213,22 @@ void MDCache::open_snap_parents()
     gather.set_finisher(new C_MDC_OpenSnapParents(this));
     gather.activate();
   } else {
+    if (!reconnected_snaprealms.empty()) {
+      stringstream warn_str;
+      for (map<inodeno_t,map<client_t,snapid_t> >::iterator p = reconnected_snaprealms.begin();
+	   p != reconnected_snaprealms.end();
+	   ++p) {
+	warn_str << " unconnected snaprealm " << p->first << "\n";
+	for (map<client_t,snapid_t>::iterator q = p->second.begin();
+	     q != p->second.end();
+	     ++q)
+	  warn_str << "  client." << q->first << " snapid " << q->second << "\n";
+      }
+      mds->clog.warn() << "open_snap_parents has:" << "\n";
+      mds->clog.warn(warn_str);
+    }
     assert(rejoin_waiters.empty());
     assert(missing_snap_parents.empty());
-    assert(reconnected_snaprealms.empty());
     dout(10) << "open_snap_parents - all open" << dendl;
     do_delayed_cap_imports();
 
-- 
1.8.1.4

