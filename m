From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] ceph: fix use-after-free bug
Date: Sat, 28 Sep 2013 20:34:45 +0800
Message-ID: <1380371685-11577-2-git-send-email-zheng.z.yan@intel.com>
References: <1380371685-11577-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53954 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535Ab3I1MfQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 28 Sep 2013 08:35:16 -0400
In-Reply-To: <1380371685-11577-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, dan.carpenter@oracle.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 6f0a35c..2ae1381 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -779,6 +779,7 @@ no_change:
 			rb_node = rb_next(rb_node);
 			rb_erase(&frag->node, &ci->i_fragtree);
 			kfree(frag);
+			frag = NULL;
 		}
 		if (!frag) {
 			frag = __get_or_create_frag(ci, id);
-- 
1.8.1.4

