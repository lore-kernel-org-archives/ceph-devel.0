From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/9] libceph: fix truncate size calculation
Date: Tue,  4 Jun 2013 11:19:52 +0800
Message-ID: <1370315998-10418-4-git-send-email-zheng.z.yan@intel.com>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11730 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757966Ab3FDDVL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 23:21:11 -0400
In-Reply-To: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

check the "not truncated yet" case

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 net/ceph/osd_client.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6972d17..93efdfb 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -733,12 +733,14 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 
 	object_size = le32_to_cpu(layout->fl_object_size);
 	object_base = off - objoff;
-	if (truncate_size <= object_base) {
-		truncate_size = 0;
-	} else {
-		truncate_size -= object_base;
-		if (truncate_size > object_size)
-			truncate_size = object_size;
+	if (!(truncate_seq == 1 && truncate_size == -1ULL)) {
+		if (truncate_size <= object_base) {
+			truncate_size = 0;
+		} else {
+			truncate_size -= object_base;
+			if (truncate_size > object_size)
+				truncate_size = object_size;
+		}
 	}
 
 	osd_req_op_extent_init(req, 0, opcode, objoff, objlen,
-- 
1.8.1.4

