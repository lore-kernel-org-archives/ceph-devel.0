From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] osd/ReplicatedPG: set truncate_seq when handling CEPH_OSD_OP_APPEND
Date: Tue, 11 Sep 2012 11:15:26 +0800
Message-ID: <1347333326-6392-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63028 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754884Ab2IKDP3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Sep 2012 23:15:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We need set truncate_seq when redirect the newop to CEPH_OSD_OP_WRITE,
otherwise the code handles CEPH_OSD_OP_WRITE may quietly drop the data.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/osd/ReplicatedPG.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index f353090..fcd8be7 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -2310,6 +2310,7 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
 	newop.op.op = CEPH_OSD_OP_WRITE;
 	newop.op.extent.offset = oi.size;
 	newop.op.extent.length = op.extent.length;
+	newop.op.extent.truncate_seq = oi.truncate_seq;
         newop.indata = osd_op.indata;
 	do_osd_ops(ctx, nops);
 	osd_op.outdata.claim(newop.outdata);
-- 
1.7.11.4

