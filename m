From: Sage Weil <sage@newdream.net>
Subject: [PATCH 10/23] ceph: only link open operations to directory unsafe list if O_CREAT|O_TRUNC
Date: Fri, 22 Jul 2011 17:02:49 -0700
Message-ID: <1311379382-9218-11-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44311 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab1GWAFy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:54 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

We only need to put these on the directory unsafe list if they have
side effects that fsync(2) should flush out.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 9b667e9..e0115eb 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -194,7 +194,8 @@ int ceph_open(struct inode *inode, struct file *file)
 	req->r_inode = inode;
 	ihold(inode);
 	req->r_num_caps = 1;
-	err = ceph_mdsc_do_request(mdsc, parent_inode, req);
+	err = ceph_mdsc_do_request(mdsc, (flags & (O_CREAT|O_TRUNC)) ?
+				   parent_inode : NULL, req);
 	if (!err)
 		err = ceph_init_file(inode, file, req->r_fmode);
 	ceph_mdsc_put_request(req);
-- 
1.7.0

