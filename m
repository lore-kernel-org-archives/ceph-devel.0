From: Sage Weil <sage@newdream.net>
Subject: Final bits for 3.2, take 2
Date: Thu, 29 Dec 2011 08:23:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112290820190.18657@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35434 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab1L2QXB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2011 11:23:01 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 55EE9BC8A5
	for <ceph-devel@vger.kernel.org>; Thu, 29 Dec 2011 08:23:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 15DE8BC8A5
	for <ceph-devel@vger.kernel.org>; Thu, 29 Dec 2011 08:23:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On second thought, I think it'll be cleaner to just disable the dcache 
trickery for now until we've flushed out all the bugs, and wait to fix up 
the d_find_any_alias() export and add new mount options until the next 
release...

sage


From a4d46363ce96c8fd7534c6f79051c78b52464132 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Thu, 29 Dec 2011 08:05:14 -0800
Subject: [PATCH] ceph: disable use of dcache for readdir etc.

Ceph attempts to use the dcache to satisfy negative lookups and readdir
when the entire directory contents are in cache.  Disable this behavior
until lingering bugs in this code are shaken out; we'll re-enable these
hooks once things are fully stable.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c |   29 +++--------------------------
 1 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 3eeb976..9895400 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1094,42 +1094,19 @@ static int ceph_snapdir_d_revalidate(struct dentry *dentry,
 /*
  * Set/clear/test dir complete flag on the dir's dentry.
  */
-static struct dentry * __d_find_any_alias(struct inode *inode)
-{
-	struct dentry *alias;
-
-	if (list_empty(&inode->i_dentry))
-		return NULL;
-	alias = list_first_entry(&inode->i_dentry, struct dentry, d_alias);
-	return alias;
-}
-
 void ceph_dir_set_complete(struct inode *inode)
 {
-	struct dentry *dentry = __d_find_any_alias(inode);
-	
-	if (dentry && ceph_dentry(dentry)) {
-		dout(" marking %p (%p) complete\n", inode, dentry);
-		set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
-	}
+	/* not yet implemented */
 }
 
 void ceph_dir_clear_complete(struct inode *inode)
 {
-	struct dentry *dentry = __d_find_any_alias(inode);
-
-	if (dentry && ceph_dentry(dentry)) {
-		dout(" marking %p (%p) NOT complete\n", inode, dentry);
-		clear_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
-	}
+	/* not yet implemented */
 }
 
 bool ceph_dir_test_complete(struct inode *inode)
 {
-	struct dentry *dentry = __d_find_any_alias(inode);
-
-	if (dentry && ceph_dentry(dentry))
-		return test_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
+	/* not yet implemented */
 	return false;
 }
 
-- 
1.7.0

