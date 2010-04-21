From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ceph: d_obtain_alias() returns ERR_PTR()
Date: Wed, 21 Apr 2010 12:31:13 +0200
Message-ID: <20100421103113.GC29647@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38375 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab0DUKbi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Apr 2010 06:31:38 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

d_obtain_alias() doesn't return NULL, it returns an ERR_PTR().

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 9d67572..192ec40 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -93,11 +93,11 @@ static struct dentry *__fh_to_dentry(struct super_block *sb,
 		return ERR_PTR(-ESTALE);
 
 	dentry = d_obtain_alias(inode);
-	if (!dentry) {
+	if (IS_ERR(dentry)) {
 		pr_err("fh_to_dentry %llx -- inode %p but ENOMEM\n",
 		       fh->ino, inode);
 		iput(inode);
-		return ERR_PTR(-ENOMEM);
+		return dentry;
 	}
 	err = ceph_init_dentry(dentry);
 
@@ -149,11 +149,11 @@ static struct dentry *__cfh_to_dentry(struct super_block *sb,
 	}
 
 	dentry = d_obtain_alias(inode);
-	if (!dentry) {
+	if (IS_ERR(dentry)) {
 		pr_err("cfh_to_dentry %llx -- inode %p but ENOMEM\n",
 		       cfh->ino, inode);
 		iput(inode);
-		return ERR_PTR(-ENOMEM);
+		return dentry;
 	}
 	err = ceph_init_dentry(dentry);
 	if (err < 0) {
@@ -202,11 +202,11 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 		return ERR_PTR(-ESTALE);
 
 	dentry = d_obtain_alias(inode);
-	if (!dentry) {
+	if (IS_ERR(dentry)) {
 		pr_err("fh_to_parent %llx -- inode %p but ENOMEM\n",
 		       cfh->ino, inode);
 		iput(inode);
-		return ERR_PTR(-ENOMEM);
+		return dentry;
 	}
 	err = ceph_init_dentry(dentry);
 	if (err < 0) {
