From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/6] ceph: re-calculate truncate_size for strip object
Date: Fri,  4 Jan 2013 19:34:16 +0800
Message-ID: <1357299261-20591-2-git-send-email-zheng.z.yan@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48663 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870Ab3ADLe1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 06:34:27 -0500
In-Reply-To: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
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
index eb9a444..267f183 100644
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

