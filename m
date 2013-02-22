From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/3] ceph: fix LSSNAP regression
Date: Fri, 22 Feb 2013 10:08:17 +0800
Message-ID: <1361498899-15831-2-git-send-email-zheng.z.yan@intel.com>
References: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37776 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649Ab3BVCI0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Feb 2013 21:08:26 -0500
In-Reply-To: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

commit 6e8575faa8 makes parse_reply_info_extra() return -EIO for LSSNAP

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d958420..608ffcf 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -265,7 +265,8 @@ static int parse_reply_info_extra(void **p, void *end,
 {
 	if (info->head->op == CEPH_MDS_OP_GETFILELOCK)
 		return parse_reply_info_filelock(p, end, info, features);
-	else if (info->head->op == CEPH_MDS_OP_READDIR)
+	else if (info->head->op == CEPH_MDS_OP_READDIR ||
+		 info->head->op == CEPH_MDS_OP_LSSNAP)
 		return parse_reply_info_dir(p, end, info, features);
 	else if (info->head->op == CEPH_MDS_OP_CREATE)
 		return parse_reply_info_create(p, end, info, features);
-- 
1.7.11.7

