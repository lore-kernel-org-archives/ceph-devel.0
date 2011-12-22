From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/3] ceph: check for null dentry in ceph_dir_set_complete()
Date: Thu, 22 Dec 2011 11:50:55 -0600
Message-ID: <1324576255.3957.106.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35764 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab1LVRu4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 12:50:56 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 53600C065
	for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 10:01:35 -0800 (PST)
Received: from [172.22.22.65] (c-71-193-71-178.hsd1.mn.comcast.net [71.193.71.178])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 0A94DC064
	for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 10:01:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In ceph_dir_set_complete(), the return value of __d_find_any_alias()
is blindly dereferenced.  That function can return a null pointer,
so the dereference needs to be protected by a check for that.

Signed-off-by: Alex Elder <elder@dreamhost.com>

---
 fs/ceph/dir.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Index: b/fs/ceph/dir.c
===================================================================
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1115,12 +1115,14 @@ static struct dentry * __d_find_any_alia
 void ceph_dir_set_complete(struct inode *inode)
 {
 	struct dentry *dentry = __d_find_any_alias(inode);
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
 	
-	if (dentry && ceph_dentry(dentry) &&
-	    ceph_test_mount_opt(fsc, USEDCACHE)) {
-		dout(" marking %p (%p) complete\n", inode, dentry);
-		set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
+	if (dentry && ceph_dentry(dentry)) {
+		struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
+
+		if (ceph_test_mount_opt(fsc, USEDCACHE)) {
+			dout(" marking %p (%p) complete\n", inode, dentry);
+			set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
+		}
 	}
 }
 


