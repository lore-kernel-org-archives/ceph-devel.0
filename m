From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] ceph: remove ceph_lookup_inode()
Date: Mon,  2 Sep 2013 15:19:53 +0800
Message-ID: <1378106394-14481-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34488 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755708Ab3IBHUY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Sep 2013 03:20:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

commit 6f60f889 (ceph: fix freeing inode vs removing session caps race)
introduced ceph_lookup_inode(). But there is already a ceph_find_inode()
which provides similar function. So remove ceph_lookup_inode(), use
ceph_find_inode() instead.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c      | 8 --------
 fs/ceph/mds_client.c | 2 +-
 fs/ceph/super.h      | 2 --
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index eae41cd..8549a48 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -62,14 +62,6 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino)
 	return inode;
 }
 
-struct inode *ceph_lookup_inode(struct super_block *sb, struct ceph_vino vino)
-{
-	struct inode *inode;
-	ino_t t = ceph_vino_to_ino(vino);
-	inode = ilookup5_nowait(sb, t, ceph_ino_compare, &vino);
-	return inode;
-}
-
 /*
  * get/constuct snapdir inode for a given directory
  */
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 603786b..b7bda5d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1054,7 +1054,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
 			vino = cap->ci->i_vino;
 			spin_unlock(&session->s_cap_lock);
 
-			inode = ceph_lookup_inode(sb, vino);
+			inode = ceph_find_inode(sb, vino);
 			iput(inode);
 
 			spin_lock(&session->s_cap_lock);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bb23ef6..6014b0a 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -694,8 +694,6 @@ extern void ceph_destroy_inode(struct inode *inode);
 
 extern struct inode *ceph_get_inode(struct super_block *sb,
 				    struct ceph_vino vino);
-extern struct inode *ceph_lookup_inode(struct super_block *sb,
-				       struct ceph_vino vino);
 extern struct inode *ceph_get_snapdir(struct inode *parent);
 extern int ceph_fill_file_size(struct inode *inode, int issued,
 			       u32 truncate_seq, u64 truncate_size, u64 size);
-- 
1.8.1.4

