From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: re-calculate truncate_size for strip object
Date: Fri, 30 Nov 2012 13:54:05 +0800
Message-ID: <1354254845-24621-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60510 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab2K3FyI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Nov 2012 00:54:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Otherwise osd may truncate the object to larger size.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 net/ceph/osd_client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ccbdfbb..f8b0e56 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -76,8 +76,16 @@ int ceph_calc_raw_layout(struct ceph_osd_client *osdc,
 		     orig_len - *plen, off, *plen);
 
 	if (op_has_extent(op->op)) {
+		u32 osize = le32_to_cpu(layout->fl_object_size);
 		op->extent.offset = objoff;
 		op->extent.length = objlen;
+		if (op->extent.truncate_size <= off - objoff) {
+			op->extent.truncate_size = 0;
+		} else {
+			op->extent.truncate_size -= off - objoff;
+			if (op->extent.truncate_size > osize)
+				op->extent.truncate_size = osize;
+		}
 	}
 	req->r_num_pages = calc_pages_for(off, *plen);
 	req->r_page_alignment = off & ~PAGE_MASK;
-- 
1.7.11.7

