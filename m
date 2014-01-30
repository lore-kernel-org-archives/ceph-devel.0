From: peda@lysator.liu.se
Subject: [PATCH] ceph: remove duplicate declaration of ceph_setattr
Date: Thu, 30 Jan 2014 11:33:19 +0100
Message-ID: <1391077999-22200-1-git-send-email-peda@lysator.liu.se>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:54398 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaA3KlP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jan 2014 05:41:15 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id DC41840025
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jan 2014 11:33:55 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, Peter Rosin <peda@lysator.liu.se>

From: Peter Rosin <peda@lysator.liu.se>

Signed-off-by: Peter Rosin <peda@lysator.liu.se>
---
 fs/ceph/super.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index aa26059..19793b5 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -718,7 +718,6 @@ extern void ceph_queue_writeback(struct inode *inode);
 extern int ceph_do_getattr(struct inode *inode, int mask);
 extern int ceph_permission(struct inode *inode, int mask);
 extern int ceph_setattr(struct dentry *dentry, struct iattr *attr);
-extern int ceph_setattr(struct dentry *dentry, struct iattr *attr);
 extern int ceph_getattr(struct vfsmount *mnt, struct dentry *dentry,
 			struct kstat *stat);
 
-- 
1.7.9

