From: Sage Weil <sage@newdream.net>
Subject: [PATCH 2/8] ceph: do not set I_COMPLETE
Date: Thu,  3 Mar 2011 12:40:04 -0800
Message-ID: <1299184810-19125-3-git-send-email-sage@newdream.net>
References: <1299184810-19125-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52160 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758524Ab1CCUj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:39:58 -0500
In-Reply-To: <1299184810-19125-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Do not set the I_COMPLETE flag on directories until we resolve races with
dcache pruning.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c   |    2 +-
 fs/ceph/inode.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0bc68de..9b4f9d9 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -409,7 +409,7 @@ more:
 	spin_lock(&inode->i_lock);
 	if (ci->i_release_count == fi->dir_release_count) {
 		dout(" marking %p complete\n", inode);
-		ci->i_ceph_flags |= CEPH_I_COMPLETE;
+		/* ci->i_ceph_flags |= CEPH_I_COMPLETE; */
 		ci->i_max_offset = filp->f_pos;
 	}
 	spin_unlock(&inode->i_lock);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 5625463..193bfa5 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -707,7 +707,7 @@ static int fill_inode(struct inode *inode,
 		    (issued & CEPH_CAP_FILE_EXCL) == 0 &&
 		    (ci->i_ceph_flags & CEPH_I_COMPLETE) == 0) {
 			dout(" marking %p complete (empty)\n", inode);
-			ci->i_ceph_flags |= CEPH_I_COMPLETE;
+			/* ci->i_ceph_flags |= CEPH_I_COMPLETE; */
 			ci->i_max_offset = 2;
 		}
 		break;
-- 
1.7.0

