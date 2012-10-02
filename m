From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 09/12] mds: Properly update dirty dir fragstat during log replay
Date: Tue,  2 Oct 2012 16:55:49 +0800
Message-ID: <1349168152-13281-9-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782Ab2JBI4R (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:17 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Dirty dir fragstat is managed by filelock instead of nestlock.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/journal.cc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 38f8c0e..0de3f39 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -488,14 +488,20 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
       dir->get_inode()->filelock.mark_dirty();
       dir->get_inode()->nestlock.mark_dirty();
 
-      if (!(dir->fnode.rstat == dir->fnode.accounted_rstat) ||
-	  !(dir->fnode.fragstat == dir->fnode.accounted_fragstat)) {
+      if (!(dir->fnode.rstat == dir->fnode.accounted_rstat)) {
 	dout(10) << "EMetaBlob.replay      dirty nestinfo on " << *dir << dendl;
 	mds->locker->mark_updated_scatterlock(&dir->inode->nestlock);
 	logseg->dirty_dirfrag_nest.push_back(&dir->inode->item_dirty_dirfrag_nest);
       } else {
 	dout(10) << "EMetaBlob.replay      clean nestinfo on " << *dir << dendl;
       }
+      if (!(dir->fnode.fragstat == dir->fnode.accounted_fragstat)) {
+	dout(10) << "EMetaBlob.replay      dirty fragstat on " << *dir << dendl;
+	mds->locker->mark_updated_scatterlock(&dir->inode->filelock);
+	logseg->dirty_dirfrag_dir.push_back(&dir->inode->item_dirty_dirfrag_dir);
+      } else {
+	dout(10) << "EMetaBlob.replay      clean fragstat on " << *dir << dendl;
+      }
     }
     if (lump.is_new())
       dir->mark_new(logseg);
-- 
1.7.11.4

