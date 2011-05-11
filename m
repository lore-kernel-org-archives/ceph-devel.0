From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH 3/3] ceph: do not use i_wrbuffer_ref as refcount for Fb cap
Date: Wed, 11 May 2011 10:29:54 +0000
Message-ID: <1305109794-7967-3-git-send-email-henry.cy.chang@gmail.com>
References: <1305109794-7967-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33717 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568Ab1EKP6j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 11:58:39 -0400
Received: by pwi15 with SMTP id 15so305249pwi.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 08:58:39 -0700 (PDT)
In-Reply-To: <1305109794-7967-1-git-send-email-henry.cy.chang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

We increments i_wrbuffer_ref when taking the Fb cap. This breaks
the dirty page accounting and causes looping in
__ceph_do_pending_vmtruncate, and ceph client hangs.

This bug can be reproduced occasionally by running blogbench.

Add a new field i_wb_ref to inode and dedicate it to Fb reference
counting.

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 fs/ceph/caps.c  |   16 ++++++++--------
 fs/ceph/inode.c |    1 +
 fs/ceph/super.h |    2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 9fa0866..2a5404c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -819,7 +819,7 @@ int __ceph_caps_used(struct ceph_inode_info *ci)
 		used |= CEPH_CAP_FILE_CACHE;
 	if (ci->i_wr_ref)
 		used |= CEPH_CAP_FILE_WR;
-	if (ci->i_wrbuffer_ref)
+	if (ci->i_wb_ref || ci->i_wrbuffer_ref)
 		used |= CEPH_CAP_FILE_BUFFER;
 	return used;
 }
@@ -1990,11 +1990,11 @@ static void __take_cap_refs(struct ceph_inode_info *ci, int got)
 	if (got & CEPH_CAP_FILE_WR)
 		ci->i_wr_ref++;
 	if (got & CEPH_CAP_FILE_BUFFER) {
-		if (ci->i_wrbuffer_ref == 0)
+		if (ci->i_wb_ref == 0)
 			ihold(&ci->vfs_inode);
-		ci->i_wrbuffer_ref++;
-		dout("__take_cap_refs %p wrbuffer %d -> %d (?)\n",
-		     &ci->vfs_inode, ci->i_wrbuffer_ref-1, ci->i_wrbuffer_ref);
+		ci->i_wb_ref++;
+		dout("__take_cap_refs %p wb %d -> %d (?)\n",
+		     &ci->vfs_inode, ci->i_wb_ref-1, ci->i_wb_ref);
 	}
 }
 
@@ -2169,12 +2169,12 @@ void ceph_put_cap_refs(struct ceph_inode_info *ci, int had)
 		if (--ci->i_rdcache_ref == 0)
 			last++;
 	if (had & CEPH_CAP_FILE_BUFFER) {
-		if (--ci->i_wrbuffer_ref == 0) {
+		if (--ci->i_wb_ref == 0) {
 			last++;
 			put++;
 		}
-		dout("put_cap_refs %p wrbuffer %d -> %d (?)\n",
-		     inode, ci->i_wrbuffer_ref+1, ci->i_wrbuffer_ref);
+		dout("put_cap_refs %p wb %d -> %d (?)\n",
+		     inode, ci->i_wb_ref+1, ci->i_wb_ref);
 	}
 	if (had & CEPH_CAP_FILE_WR)
 		if (--ci->i_wr_ref == 0) {
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 03d6daf..70b6a48 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -355,6 +355,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_rd_ref = 0;
 	ci->i_rdcache_ref = 0;
 	ci->i_wr_ref = 0;
+	ci->i_wb_ref = 0;
 	ci->i_wrbuffer_ref = 0;
 	ci->i_wrbuffer_ref_head = 0;
 	ci->i_shared_gen = 0;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b1f1b8b..f5cabef 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -293,7 +293,7 @@ struct ceph_inode_info {
 
 	/* held references to caps */
 	int i_pin_ref;
-	int i_rd_ref, i_rdcache_ref, i_wr_ref;
+	int i_rd_ref, i_rdcache_ref, i_wr_ref, i_wb_ref;
 	int i_wrbuffer_ref, i_wrbuffer_ref_head;
 	u32 i_shared_gen;       /* increment each time we get FILE_SHARED */
 	u32 i_rdcache_gen;      /* incremented each time we get FILE_CACHE. */
-- 
1.7.2.3

