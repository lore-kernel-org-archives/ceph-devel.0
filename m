From: Sage Weil <sage@newdream.net>
Subject: [PATCH 17/23] ceph: handle racing calls to ceph_init_dentry
Date: Fri, 22 Jul 2011 17:02:56 -0700
Message-ID: <1311379382-9218-18-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44329 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1GWAFz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:55 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

The ->lookup() and prepopulate_readdir() callers are working with unhashed
dentries, so we don't have to worry.  The export.c callers, though, need
to initialize something they got back from d_obtain_alias() and are
potentially racing with other callers.  Make sure we don't return unless
the dentry is properly initialized (by us or someone else).

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f39a409..58ec879 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -40,14 +40,6 @@ int ceph_init_dentry(struct dentry *dentry)
 	if (dentry->d_fsdata)
 		return 0;
 
-	if (dentry->d_parent == NULL ||   /* nfs fh_to_dentry */
-	    ceph_snap(dentry->d_parent->d_inode) == CEPH_NOSNAP)
-		d_set_d_op(dentry, &ceph_dentry_ops);
-	else if (ceph_snap(dentry->d_parent->d_inode) == CEPH_SNAPDIR)
-		d_set_d_op(dentry, &ceph_snapdir_dentry_ops);
-	else
-		d_set_d_op(dentry, &ceph_snap_dentry_ops);
-
 	di = kmem_cache_alloc(ceph_dentry_cachep, GFP_NOFS | __GFP_ZERO);
 	if (!di)
 		return -ENOMEM;          /* oh well */
@@ -58,10 +50,19 @@ int ceph_init_dentry(struct dentry *dentry)
 		kmem_cache_free(ceph_dentry_cachep, di);
 		goto out_unlock;
 	}
+
+	if (dentry->d_parent == NULL ||   /* nfs fh_to_dentry */
+	    ceph_snap(dentry->d_parent->d_inode) == CEPH_NOSNAP)
+		d_set_d_op(dentry, &ceph_dentry_ops);
+	else if (ceph_snap(dentry->d_parent->d_inode) == CEPH_SNAPDIR)
+		d_set_d_op(dentry, &ceph_snapdir_dentry_ops);
+	else
+		d_set_d_op(dentry, &ceph_snap_dentry_ops);
+
 	di->dentry = dentry;
 	di->lease_session = NULL;
-	dentry->d_fsdata = di;
 	dentry->d_time = jiffies;
+	dentry->d_fsdata = di; /* almost last so that d_fsdata check is safe */
 	ceph_dentry_lru_add(dentry);
 out_unlock:
 	spin_unlock(&dentry->d_lock);
-- 
1.7.0

