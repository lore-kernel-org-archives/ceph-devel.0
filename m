From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/5] mds: fix journaling issue regarding rstat accounting
Date: Fri, 30 Nov 2012 10:36:50 +0800
Message-ID: <1354243014-21072-2-git-send-email-zheng.z.yan@intel.com>
References: <1354243014-21072-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8401 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523Ab2K3ChA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Nov 2012 21:37:00 -0500
In-Reply-To: <1354243014-21072-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Rename operation can call predirty_journal_parents() twice. So
directory fragment's rstat can be modified twice. But only the
first modification is journaled because EMetaBlob::add_dir() does
not update existing dirlump.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/events/EMetaBlob.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index 9c281e9..116b704 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -635,12 +635,12 @@ private:
 		   dirty, complete, isnew);
   }
   dirlump& add_dir(dirfrag_t df, fnode_t *pf, version_t pv, bool dirty, bool complete=false, bool isnew=false) {
-    if (lump_map.count(df) == 0) {
+    if (lump_map.count(df) == 0)
       lump_order.push_back(df);
-      lump_map[df].fnode = *pf;
-      lump_map[df].fnode.version = pv;
-    }
+
     dirlump& l = lump_map[df];
+    l.fnode = *pf;
+    l.fnode.version = pv;
     if (complete) l.mark_complete();
     if (dirty) l.mark_dirty();
     if (isnew) l.mark_new();
-- 
1.7.11.7

