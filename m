From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 4/4] osd: fix extent_cmp tracepoint call
Date: Fri, 31 Jul 2015 18:32:53 +0200
Message-ID: <1438360373-14377-2-git-send-email-ddiss@suse.de>
References: <1438161946-28473-1-git-send-email-mchristi@redhat.com>
 <1438360373-14377-1-git-send-email-ddiss@suse.de>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438360373-14377-1-git-send-email-ddiss@suse.de>
Sender: target-devel-owner@vger.kernel.org
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org, David Disseldorp <ddiss@suse.de>
List-Id: ceph-devel.vger.kernel.org

The size and seq variables are out of scope.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 src/osd/ReplicatedPG.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 2890af3..aed609b 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -3501,7 +3501,7 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
       // --- READS ---
 
     case CEPH_OSD_OP_CMPEXT:
-	tracepoint(osd, do_osd_op_pre_extent_cmp, soid.oid.name.c_str(), soid.snap.val, size, seq, op.extent.offset, op.extent.length, op.extent.truncate_size, op.extent.truncate_seq);
+	tracepoint(osd, do_osd_op_pre_extent_cmp, soid.oid.name.c_str(), soid.snap.val, oi.size, oi.truncate_seq, op.extent.offset, op.extent.length, op.extent.truncate_size, op.extent.truncate_seq);
         // TODO: Locking - this op and the write are supposed to be atomic
 	result = do_extent_cmp(ctx, osd_op);
 	break;
-- 
2.1.4
