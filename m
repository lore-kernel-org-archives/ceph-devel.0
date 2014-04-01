From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/3] ceph: don't grabs open file reference for aborted request
Date: Tue,  1 Apr 2014 20:43:03 +0800
Message-ID: <1396356184-4317-2-git-send-email-zheng.z.yan@intel.com>
References: <1396356184-4317-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19264 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbaDAMnJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Apr 2014 08:43:09 -0400
In-Reply-To: <1396356184-4317-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c9f2567..0b0728e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1112,7 +1112,7 @@ retry_lookup:
 
 		err = fill_inode(in, &rinfo->targeti, NULL,
 				session, req->r_request_started,
-				(le32_to_cpu(rinfo->head->result) == 0) ?
+				(!req->r_aborted && rinfo->head->result == 0) ?
 				req->r_fmode : -1,
 				&req->r_caps_reservation);
 		if (err < 0) {
-- 
1.8.5.3

