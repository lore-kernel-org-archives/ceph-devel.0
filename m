From: Sage Weil <sage@newdream.net>
Subject: [PATCH 02/11] ceph: refactor SETLAYOUT and SETDIRLAYOUT ioctl checks into common helper
Date: Fri,  4 May 2012 15:53:59 -0700
Message-ID: <1336172048-6848-3-git-send-email-sage@newdream.net>
References: <1336172048-6848-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37641 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760560Ab2EDWyN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 18:54:13 -0400
In-Reply-To: <1336172048-6848-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Both of these methods perform similar checks; move that code to a helper
so that we can ensure the checks are consistent.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/ioctl.c |   82 +++++++++++++++++++++++++-----------------------------
 1 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 4feab52..0e2f021 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -34,6 +34,36 @@ static long ceph_ioctl_get_layout(struct file *file, void __user *arg)
 	return err;
 }
 
+static long __validate_layout(struct ceph_mds_client *mdsc,
+			      struct ceph_ioctl_layout *l)
+{
+	int i, err;
+
+	/* preferred_osd is no longer supported */
+	if (l->preferred_osd != -1)
+		return -EINVAL;
+
+	/* validate striping parameters */
+	if ((l->object_size & ~PAGE_MASK) ||
+	    (l->stripe_unit & ~PAGE_MASK) ||
+	    ((unsigned)l->object_size % (unsigned)l->stripe_unit))
+		return -EINVAL;
+
+	/* make sure it's a valid data pool */
+	mutex_lock(&mdsc->mutex);
+	err = -EINVAL;
+	for (i = 0; i < mdsc->mdsmap->m_num_data_pg_pools; i++)
+		if (mdsc->mdsmap->m_data_pg_pools[i] == l->data_pool) {
+			err = 0;
+			break;
+		}
+	mutex_unlock(&mdsc->mutex);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -43,15 +73,11 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	struct ceph_ioctl_layout l;
 	struct ceph_inode_info *ci = ceph_inode(file->f_dentry->d_inode);
 	struct ceph_ioctl_layout nl;
-	int err, i;
+	int err;
 
 	if (copy_from_user(&l, arg, sizeof(l)))
 		return -EFAULT;
 
-	/* preferred_osd is no longer supported */
-	if (l.preferred_osd != -1)
-		return -EINVAL;
-
 	/* validate changed params against current layout */
 	err = ceph_do_getattr(file->f_dentry->d_inode, CEPH_STAT_CAP_LAYOUT);
 	if (!err) {
@@ -71,24 +97,9 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	if (l.data_pool)
 		nl.data_pool = l.data_pool;
 
-	if ((nl.object_size & ~PAGE_MASK) ||
-	    (nl.stripe_unit & ~PAGE_MASK) ||
-	    ((unsigned)nl.object_size % (unsigned)nl.stripe_unit))
-		return -EINVAL;
-
-	/* make sure it's a valid data pool */
-	if (l.data_pool > 0) {
-		mutex_lock(&mdsc->mutex);
-		err = -EINVAL;
-		for (i = 0; i < mdsc->mdsmap->m_num_data_pg_pools; i++)
-			if (mdsc->mdsmap->m_data_pg_pools[i] == l.data_pool) {
-				err = 0;
-				break;
-			}
-		mutex_unlock(&mdsc->mutex);
-		if (err)
-			return err;
-	}
+	err = __validate_layout(mdsc, &nl);
+	if (err)
+		return err;
 
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETLAYOUT,
 				       USE_AUTH_MDS);
@@ -124,33 +135,16 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	struct inode *inode = file->f_dentry->d_inode;
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
-	int err, i;
+	int err;
 	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
 
 	/* copy and validate */
 	if (copy_from_user(&l, arg, sizeof(l)))
 		return -EFAULT;
 
-	if ((l.object_size & ~PAGE_MASK) ||
-	    (l.stripe_unit & ~PAGE_MASK) ||
-	    !l.stripe_unit ||
-	    (l.object_size &&
-	        (unsigned)l.object_size % (unsigned)l.stripe_unit))
-		return -EINVAL;
-
-	/* make sure it's a valid data pool */
-	if (l.data_pool > 0) {
-		mutex_lock(&mdsc->mutex);
-		err = -EINVAL;
-		for (i = 0; i < mdsc->mdsmap->m_num_data_pg_pools; i++)
-			if (mdsc->mdsmap->m_data_pg_pools[i] == l.data_pool) {
-				err = 0;
-				break;
-			}
-		mutex_unlock(&mdsc->mutex);
-		if (err)
-			return err;
-	}
+	err = __validate_layout(mdsc, &l);
+	if (err)
+		return err;
 
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETDIRLAYOUT,
 				       USE_AUTH_MDS);
-- 
1.7.9

