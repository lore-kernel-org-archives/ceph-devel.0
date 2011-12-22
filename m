From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/3] ceph: take a reference to the dentry in
 d_find_any_alias()
Date: Thu, 22 Dec 2011 11:51:04 -0600
Message-ID: <1324576264.3957.108.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35788 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab1LVRvG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 12:51:06 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id AEF3AC065
	for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 10:01:44 -0800 (PST)
Received: from [172.22.22.65] (c-71-193-71-178.hsd1.mn.comcast.net [71.193.71.178])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 65577C064
	for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 10:01:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

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
 1 file changed, 25 insertions(+), 6 deletions(-)

Index: b/fs/ceph/dir.c
===================================================================
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1099,9 +1099,20 @@ static int ceph_snapdir_d_revalidate(str
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
@@ -1109,10 +1120,10 @@ static struct dentry * __d_find_any_alia
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
@@ -1124,6 +1135,9 @@ static struct dentry * d_find_any_alias(
 }
 /* End of code copied from "fs/dcache.c" */
 
+/*
+ * Set/clear/test dir complete flag on the dir's dentry.
+ */
 void ceph_dir_set_complete(struct inode *inode)
 {
 	struct dentry *dentry = d_find_any_alias(inode);
@@ -1136,6 +1150,7 @@ void ceph_dir_set_complete(struct inode
 			set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
 		}
 	}
+	dput(dentry);
 }
 
 void ceph_dir_clear_complete(struct inode *inode)
@@ -1146,15 +1161,19 @@ void ceph_dir_clear_complete(struct inod
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


