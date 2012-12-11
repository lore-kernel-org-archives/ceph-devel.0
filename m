From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 03/14] mds: properly mark dirfrag dirty
Date: Tue, 11 Dec 2012 16:30:49 +0800
Message-ID: <1355214660-26354-4-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59907 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149Ab2LKIbI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:08 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If predirty_journal_parents() does not propagate changes in dir's
fragstat into corresponding inode's dirstat, it should mark the
inode as dirfrag dirty. This happens when we modify dir fragments
that are auth subtree roots.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 58a8b8a..c8055ea 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -1993,6 +1993,11 @@ void MDCache::predirty_journal_parents(Mutation *mut, EMetaBlob *blob,
       mds->locker->mark_updated_scatterlock(&pin->nestlock);
       mut->ls->dirty_dirfrag_nest.push_back(&pin->item_dirty_dirfrag_nest);
       mut->add_updated_lock(&pin->nestlock);
+      if (do_parent_mtime || linkunlink) {
+	mds->locker->mark_updated_scatterlock(&pin->filelock);
+	mut->ls->dirty_dirfrag_dir.push_back(&pin->item_dirty_dirfrag_dir);
+	mut->add_updated_lock(&pin->filelock);
+      }
       break;
     }
     if (!mut->wrlocks.count(&pin->versionlock))
-- 
1.7.11.7

