From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] ceph: don't null-terminate xattr values
Date: Tue, 28 Feb 2012 19:12:50 -0800
Message-ID: <4F4D97B2.1060201@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44158 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030703Ab2B2DMv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:12:51 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 03EA724318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:51 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E6CDD24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For some reason, ceph_setxattr() allocates an extra byte in which a
'\0' is stored past the end of an extended attribute value.  This is
not needed, and is potentially misleading, so get rid of it.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/xattr.c |    4 +---
  1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 9e6734e..b98b91d 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -730,11 +730,9 @@ int ceph_setxattr(struct dentry *dentry, const char 
*name,
  		goto out;

  	if (val_len) {
-		newval = kmalloc(val_len + 1, GFP_NOFS);
+		newval = kmemdup(value, val_len, GFP_NOFS);
  		if (!newval)
  			goto out;
-		memcpy(newval, value, val_len);
-		newval[val_len] = '\0';
  	}

  	xattr = kmalloc(sizeof(struct ceph_inode_xattr), GFP_NOFS);
-- 
1.7.5.4

