From: Guangliang Zhao <lucienchao@gmail.com>
Subject: [PATCH 3/3] ceph: make ceph ACL for symlink inheritable
Date: Fri, 14 Feb 2014 13:29:44 +0800
Message-ID: <1392355784-10422-4-git-send-email-lucienchao@gmail.com>
References: <1392355784-10422-1-git-send-email-lucienchao@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56078 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaBNFaH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 00:30:07 -0500
Received: by mail-pd0-f172.google.com with SMTP id p10so11478952pdj.17
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2014 21:30:07 -0800 (PST)
In-Reply-To: <1392355784-10422-1-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com

Default ACL couldn't be inherited by the symlink in the
parent directory. This resolve it.

Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
---
 fs/ceph/dir.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 619616d..2650570 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -735,6 +735,10 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	if (!err && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
 	ceph_mdsc_put_request(req);
+
+	if (!err)
+		err = ceph_init_acl(dentry, dentry->d_inode, dir);
+
 	if (err)
 		d_drop(dentry);
 	return err;
-- 
1.7.9.5

