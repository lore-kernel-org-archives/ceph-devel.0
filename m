From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/3] ceph: drop extra open file reference in ceph_atomic_open()
Date: Tue,  1 Apr 2014 20:43:02 +0800
Message-ID: <1396356184-4317-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19264 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbaDAMnH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Apr 2014 08:43:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

ceph_atomic_open() calls ceph_open() after receiving the MDS reply.
ceph_open() grabs an extra open file reference. (The open request
already holds an open file reference)

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 2862a75..66075a4a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -291,8 +291,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		}
 		err = finish_open(file, dentry, ceph_open, opened);
 	}
-
 out_err:
+	if (!req->r_err && req->r_target_inode)
+		ceph_put_fmode(ceph_inode(req->r_target_inode), req->r_fmode);
 	ceph_mdsc_put_request(req);
 	dout("atomic_open result=%d\n", err);
 	return err;
-- 
1.8.5.3

