From: Sage Weil <sage@newdream.net>
Subject: [PATCH 2/3] ceph: take a reference to the dentry in d_find_any_alias()
Date: Wed, 28 Dec 2011 18:05:14 -0800
Message-ID: <1325124315-3487-3-git-send-email-sage@newdream.net>
References: <1325124315-3487-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41608 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1L2ChF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Dec 2011 21:37:05 -0500
In-Reply-To: <1325124315-3487-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@dreamhost.com>

From: Alex Elder <elder@dreamhost.com>

The ceph code duplicates __d_find_any_alias(), but it currently
does not take a reference to the returned dentry as it should.
Replace the ceph implementation with an exact copy of what's
found in "fs/dcache.c", and update the callers so they drop
their reference when they're done with it.

Unfortunately this requires the wholesale copy of the functions
that implement __dget().  It would be much nicer to just export
d_find_any_alias() from "fs/dcache.c" instead.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
 fs/ceph/dir.c |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index e58b0d1..caddb7d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1091,9 +1091,20 @@ static int ceph_snapdir_d_revalidate(struct dentry *dentry,
 	return 1;
 }
 
-/*
- * Set/clear/test dir complete flag on the dir's dentry.
- */
+/* The following code copied from "fs/dcache.c" */
+/* This must be called with d_lock held */
+static inline void __dget_dlock(struct dentry *dentry)
+{
+	dentry->d_count++;
+}
+
+static inline void __dget(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	__dget_dlock(dentry);
+	spin_unlock(&dentry->d_lock);
+}
+
 static struct dentry * __d_find_any_alias(struct inode *inode)
 {
 	struct dentry *alias;
@@ -1101,10 +1112,10 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 	if (list_empty(&inode->i_dentry))
 		return NULL;
 	alias = list_first_entry(&inode->i_dentry, struct dentry, d_alias);
+	__dget(alias);
 	return alias;
 }
 
-/* The following code copied from "fs/dcache.c" */
 static struct dentry * d_find_any_alias(struct inode *inode)
 {
 	struct dentry *de;
@@ -1116,6 +1127,9 @@ static struct dentry * d_find_any_alias(struct inode *inode)
 }
 /* End of code copied from "fs/dcache.c" */
 
+/*
+ * Set/clear/test dir complete flag on the dir's dentry.
+ */
 void ceph_dir_set_complete(struct inode *inode)
 {
 	struct dentry *dentry = d_find_any_alias(inode);
@@ -1124,6 +1138,7 @@ void ceph_dir_set_complete(struct inode *inode)
 		dout(" marking %p (%p) complete\n", inode, dentry);
 		set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
 	}
+	dput(dentry);
 }
 
 void ceph_dir_clear_complete(struct inode *inode)
@@ -1134,15 +1149,19 @@ void ceph_dir_clear_complete(struct inode *inode)
 		dout(" marking %p (%p) NOT complete\n", inode, dentry);
 		clear_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
 	}
+	dput(dentry);
 }
 
 bool ceph_dir_test_complete(struct inode *inode)
 {
 	struct dentry *dentry = d_find_any_alias(inode);
+	bool ret = false;
 
 	if (dentry && ceph_dentry(dentry))
-		return test_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
-	return false;
+		ret = test_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
+	dput(dentry);
+
+	return ret;
 }
 
 /*
-- 
1.7.2.5

