From: Sage Weil <sage@newdream.net>
Subject: [PATCH 3/5] ceph: fix null pointer dereference in ceph_init_dentry for nfs reexport
Date: Mon, 20 Dec 2010 11:15:29 -0800
Message-ID: <1292872531-18396-4-git-send-email-sage@newdream.net>
References: <1292872531-18396-1-git-send-email-sage@newdream.net>
 <1292872531-18396-2-git-send-email-sage@newdream.net>
 <1292872531-18396-3-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41945 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899Ab0LTTPe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Dec 2010 14:15:34 -0500
In-Reply-To: <1292872531-18396-3-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

The fh_to_dentry etc. methods use ceph_init_dentry(), which assumes that
d_parent is defined.  It isn't for those callers, so check!

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 158c700..d902948 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -40,7 +40,8 @@ int ceph_init_dentry(struct dentry *dentry)
 	if (dentry->d_fsdata)
 		return 0;
 
-	if (ceph_snap(dentry->d_parent->d_inode) == CEPH_NOSNAP)
+	if (dentry->d_parent == NULL ||   /* nfs fh_to_dentry */
+	    ceph_snap(dentry->d_parent->d_inode) == CEPH_NOSNAP)
 		dentry->d_op = &ceph_dentry_ops;
 	else if (ceph_snap(dentry->d_parent->d_inode) == CEPH_SNAPDIR)
 		dentry->d_op = &ceph_snapdir_dentry_ops;
-- 
1.6.6.1

