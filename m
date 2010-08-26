From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ceph: ceph_mdsc_build_path() returns an ERR_PTR
Date: Thu, 26 Aug 2010 11:07:24 +0200
Message-ID: <20100826090724.GA20072@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37306 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab0HZJJX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Aug 2010 05:09:23 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

ceph_mdsc_build_path() returns an ERR_PTR but this code is set up to
handle NULL returns.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 360c4f2..6fd8b20 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -171,6 +171,8 @@ static int mdsc_show(struct seq_file *s, void *p)
 		} else if (req->r_dentry) {
 			path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
 						    &pathbase, 0);
+			if (IS_ERR(path))
+				path = NULL;
 			spin_lock(&req->r_dentry->d_lock);
 			seq_printf(s, " #%llx/%.*s (%s)",
 				   ceph_ino(req->r_dentry->d_parent->d_inode),
@@ -187,6 +189,8 @@ static int mdsc_show(struct seq_file *s, void *p)
 		if (req->r_old_dentry) {
 			path = ceph_mdsc_build_path(req->r_old_dentry, &pathlen,
 						    &pathbase, 0);
+			if (IS_ERR(path))
+				path = NULL;
 			spin_lock(&req->r_old_dentry->d_lock);
 			seq_printf(s, " #%llx/%.*s (%s)",
 			   ceph_ino(req->r_old_dentry->d_parent->d_inode),
