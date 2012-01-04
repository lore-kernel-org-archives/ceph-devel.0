From: Alex Elder <elder@dreamhost.com>
Subject: ceph: always initialize the dentry in open_root_dentry()
Date: Wed, 04 Jan 2012 16:30:15 -0600
Message-ID: <1325716215.3346.42.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37142 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757099Ab2ADWaR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jan 2012 17:30:17 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 80EACC064
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jan 2012 14:41:47 -0800 (PST)
Received: from [172.22.22.65] (c-71-193-71-178.hsd1.mn.comcast.net [71.193.71.178])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 3D79AC062
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jan 2012 14:41:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

When open_root_dentry() gets a dentry via d_obtain_alias() it does
not get initialized.  If the dentry obtained came from the cache,
this is OK.  But if not, the result is an improperly initialized
dentry.

To fix this, call ceph_init_dentry() regardless of which path
produced the dentry.  That function returns immediately for a dentry
that is already initialized, it is safe to use either way.

(Credit to Sage, who suggested this fix.)

Signed-off-by: Alex Elder <aelder@sgi.com>

---
 fs/ceph/super.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: b/fs/ceph/super.c
===================================================================
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -638,12 +638,11 @@ static struct dentry *open_root_dentry(s
 	if (err == 0) {
 		dout("open_root_inode success\n");
 		if (ceph_ino(req->r_target_inode) == CEPH_INO_ROOT &&
-		    fsc->sb->s_root == NULL) {
+		    fsc->sb->s_root == NULL)
 			root = d_alloc_root(req->r_target_inode);
-			ceph_init_dentry(root);
-		} else {
+		else
 			root = d_obtain_alias(req->r_target_inode);
-		}
+		ceph_init_dentry(root);
 		req->r_target_inode = NULL;
 		dout("open_root_inode success, root dentry is %p\n", root);
 	} else {


