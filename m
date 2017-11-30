From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: decease session->s_trim_caps only after caps get trimmed
Date: Thu, 30 Nov 2017 15:53:58 +0800
Message-ID: <20171130075358.7803-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbdK3HyG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Nov 2017 02:54:06 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>, stable@vger.kernel.org

d_prune_aliases() does not prune dentry that has non-zero reference
count. If we want trim_caps() to trim 'N' caps, the first 'N' inodes
in session->s_caps are all directories with child dentry, trim_caps()
can fail to trim anything.

Cc: stable@vger.kernel.org
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/mds_client.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 80339e278ad8..da181acd4a61 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1490,16 +1490,20 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 	if ((used | wanted) & ~oissued & mine)
 		goto out;   /* we need these caps */
 
-	session->s_trim_caps--;
 	if (oissued) {
 		/* we aren't the only cap.. just remove us */
 		__ceph_remove_cap(cap, true);
+		session->s_trim_caps--;
 	} else {
+		int refs;
 		/* try dropping referring dentries */
 		spin_unlock(&ci->i_ceph_lock);
 		d_prune_aliases(inode);
+		refs = atomic_read(&inode->i_count);
+		if (refs == 1)
+			session->s_trim_caps--;
 		dout("trim_caps_cb %p cap %p  pruned, count now %d\n",
-		     inode, cap, atomic_read(&inode->i_count));
+		     inode, cap, refs);
 		return 0;
 	}
 
-- 
2.13.6

