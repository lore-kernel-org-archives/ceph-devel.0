From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] mds: allow purging "dirty parent" stray inode
Date: Tue,  4 Jun 2013 11:19:26 +0800
Message-ID: <1370315966-10363-2-git-send-email-zheng.z.yan@intel.com>
References: <1370315966-10363-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3188 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757177Ab3FDDTb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 23:19:31 -0400
In-Reply-To: <1370315966-10363-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index e2ecba8..7b4f2fa 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -9156,7 +9156,7 @@ void MDCache::eval_stray(CDentry *dn)
       dout(20) << " pending recovery" << dendl;
       return;  // don't mess with file size probing
     }
-    if (in->get_num_ref() > (int)in->is_dirty()) {
+    if (in->get_num_ref() > (int)in->is_dirty() + (int)in->is_dirty_parent()) {
       dout(20) << " too many inode refs" << dendl;
       return;
     }
@@ -9449,6 +9449,9 @@ void MDCache::_purge_stray_logged(CDentry *dn, version_t pdv, LogSegment *ls)
   // drop inode
   if (in->is_dirty())
     in->mark_clean();
+  if (in->is_dirty_parent())
+    in->clear_dirty_parent();
+
   remove_inode(in);
 
   // drop dentry?
-- 
1.8.1.4

