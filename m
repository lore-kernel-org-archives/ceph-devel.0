From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/7] ceph: fix LSSNAP regression
Date: Fri,  1 Mar 2013 14:46:18 +0800
Message-ID: <1362120384-5188-2-git-send-email-zheng.z.yan@intel.com>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58983 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870Ab3CAGq3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Mar 2013 01:46:29 -0500
In-Reply-To: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
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

