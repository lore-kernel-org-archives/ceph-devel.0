From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH v2 5/5] ceph: print inode number for LOOKUPINO request
Date: Fri,  7 Mar 2014 17:04:37 +0800
Message-ID: <1394183077-399-6-git-send-email-zheng.z.yan@intel.com>
References: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10125 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbaCGJEy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Mar 2014 04:04:54 -0500
In-Reply-To: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 8c6f313..16b54aa 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -93,6 +93,8 @@ static int mdsc_show(struct seq_file *s, void *p)
 		} else if (req->r_path1) {
 			seq_printf(s, " #%llx/%s", req->r_ino1.ino,
 				   req->r_path1);
+		} else {
+			seq_printf(s, " #%llx", req->r_ino1.ino);
 		}
 
 		if (req->r_old_dentry) {
-- 
1.8.5.3

