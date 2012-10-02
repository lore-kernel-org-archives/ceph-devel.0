From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 10/12] mds: Trim non auth subtree directory
Date: Tue,  2 Oct 2012 16:55:50 +0800
Message-ID: <1349168152-13281-10-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865Ab2JBI4T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:19 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Trim non auth subtree directory if all its dentries were trimmed
and it's not bound of auth subtree.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 1348b3e..397b991 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5412,6 +5412,15 @@ bool MDCache::trim(int max)
       ++i)
     lru.lru_insert_mid(*i);
 
+  for (map<CDir*, set<CDir*> >::iterator p = subtrees.begin();
+       p != subtrees.end();) {
+    CDir *dir = p->first;
+    p++;
+    if (!dir->is_auth() && !dir->get_inode()->is_auth()) {
+      if (dir->get_num_ref() == 1)  // subtree pin
+	trim_dirfrag(dir, 0, expiremap);
+    }
+  }
   // trim root?
   if (max == 0 && root) {
     list<CDir*> ls;
-- 
1.7.11.4

