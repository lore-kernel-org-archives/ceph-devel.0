From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/3] ceph: take inode lock when finding an inode alias
Date: Thu, 22 Dec 2011 11:51:00 -0600
Message-ID: <1324576260.3957.107.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35773 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab1LVRvB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 12:51:01 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 4E675C065
	for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 10:01:40 -0800 (PST)
Received: from [172.22.22.65] (c-71-193-71-178.hsd1.mn.comcast.net [71.193.71.178])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 08D33C064
	for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 10:01:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

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
 1 file changed, 15 insertions(+), 3 deletions(-)

Index: b/fs/ceph/dir.c
===================================================================
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1112,9 +1112,21 @@ static struct dentry * __d_find_any_alia
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
 		struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
@@ -1128,7 +1140,7 @@ void ceph_dir_set_complete(struct inode
 
 void ceph_dir_clear_complete(struct inode *inode)
 {
-	struct dentry *dentry = __d_find_any_alias(inode);
+	struct dentry *dentry = d_find_any_alias(inode);
 
 	if (dentry && ceph_dentry(dentry)) {
 		dout(" marking %p (%p) NOT complete\n", inode, dentry);
@@ -1138,7 +1150,7 @@ void ceph_dir_clear_complete(struct inod
 
 bool ceph_dir_test_complete(struct inode *inode)
 {
-	struct dentry *dentry = __d_find_any_alias(inode);
+	struct dentry *dentry = d_find_any_alias(inode);
 
 	if (dentry && ceph_dentry(dentry))
 		return test_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);


