From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/4] ceph: print inode number for LOOKUPINO/LOOKUPPARENT request
Date: Sat,  1 Mar 2014 23:23:31 +0800
Message-ID: <1393687411-2457-4-git-send-email-zheng.z.yan@intel.com>
References: <1393687411-2457-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51314 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882AbaCAPYF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 1 Mar 2014 10:24:05 -0500
In-Reply-To: <1393687411-2457-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 6d59006..a9b5103 100644
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

