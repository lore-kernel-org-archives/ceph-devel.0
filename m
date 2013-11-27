From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 06/18] osdc: Add write method with truncate parameters
Date: Wed, 27 Nov 2013 21:40:45 +0800
Message-ID: <8f0805f87113723a8cca08b0817a1fc3b9c727d2.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48452 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab3K0NlX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:23 -0500
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/osdc/Objecter.h |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/osdc/Objecter.h b/src/osdc/Objecter.h
index 41973dd..40f03de 100644
--- a/src/osdc/Objecter.h
+++ b/src/osdc/Objecter.h
@@ -279,8 +279,16 @@ struct ObjectOperation {
     out_handler[p] = h;
     out_rval[p] = prval;
   }
-  void write(uint64_t off, bufferlist& bl) {
+  void write(uint64_t off, bufferlist& bl,
+             uint64_t truncate_size,
+             uint32_t truncate_seq) {
     add_data(CEPH_OSD_OP_WRITE, off, bl.length(), bl);
+    OSDOp& o = *ops.rbegin();
+    o.op.extent.truncate_size = truncate_size;
+    o.op.extent.truncate_seq = truncate_seq;
+  }
+  void write(uint64_t off, bufferlist& bl) {
+    write(off, bl, 0, 0);
   }
   void write_full(bufferlist& bl) {
     add_data(CEPH_OSD_OP_WRITEFULL, 0, bl.length(), bl);
-- 
1.7.9.5

