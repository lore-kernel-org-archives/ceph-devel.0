From: Sage Weil <sage@newdream.net>
Subject: [PATCH 1/3] ceph: take inode lock when finding an inode alias
Date: Wed, 28 Dec 2011 18:05:13 -0800
Message-ID: <1325124315-3487-2-git-send-email-sage@newdream.net>
References: <1325124315-3487-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41605 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab1L2ChF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Dec 2011 21:37:05 -0500
In-Reply-To: <1325124315-3487-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@dreamhost.com>

From: Alex Elder <elder@dreamhost.com>

In the ceph_dir_*_complete() functions, a call to
__d_find_any_alias() is used to get a dentry for a inode.
Previously this was done under the inode's i_lock, but
recently this change converted things to use the ceph
inode's i_ceph_lock instead:
    be655596 ceph: use i_ceph_lock instead of i_lock

Finding an inode alias operates (only) on the Linux inode, so
we really do need to take the Linux lock for this.  Since i_lock
is ordered inside i_ceph_lock, we can safely do this for all
these ceph cases.

For now, just copy the d_find_any_alias() function from
"fs/dcache.c" and use that instead.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
 fs/ceph/dir.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 3eeb976..e58b0d1 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1104,9 +1104,21 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 	return alias;
 }
 
+/* The following code copied from "fs/dcache.c" */
+static struct dentry * d_find_any_alias(struct inode *inode)
+{
+	struct dentry *de;
+
+	spin_lock(&inode->i_lock);
+	de = __d_find_any_alias(inode);
+	spin_unlock(&inode->i_lock);
+	return de;
+}
+/* End of code copied from "fs/dcache.c" */
+
 void ceph_dir_set_complete(struct inode *inode)
 {
-	struct dentry *dentry = __d_find_any_alias(inode);
+	struct dentry *dentry = d_find_any_alias(inode);
 	
 	if (dentry && ceph_dentry(dentry)) {
 		dout(" marking %p (%p) complete\n", inode, dentry);
@@ -1116,7 +1128,7 @@ void ceph_dir_set_complete(struct inode *inode)
 
 void ceph_dir_clear_complete(struct inode *inode)
 {
-	struct dentry *dentry = __d_find_any_alias(inode);
+	struct dentry *dentry = d_find_any_alias(inode);
 
 	if (dentry && ceph_dentry(dentry)) {
 		dout(" marking %p (%p) NOT complete\n", inode, dentry);
@@ -1126,7 +1138,7 @@ void ceph_dir_clear_complete(struct inode *inode)
 
 bool ceph_dir_test_complete(struct inode *inode)
 {
-	struct dentry *dentry = __d_find_any_alias(inode);
+	struct dentry *dentry = d_find_any_alias(inode);
 
 	if (dentry && ceph_dentry(dentry))
 		return test_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
-- 
1.7.2.5

