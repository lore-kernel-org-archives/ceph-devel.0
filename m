From: Mike Christie <mchristi@redhat.com>
Subject: [PATCH 2/2] ceph osd: add support for new op cmpext
Date: Thu, 10 Mar 2016 00:34:32 -0600
Message-ID: <1457591672-17430-3-git-send-email-mchristi@redhat.com>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
 <1457591672-17430-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45321 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbcCJGeg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 01:34:36 -0500
In-Reply-To: <1457591672-17430-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ddiss@suse.de, Mike Christie <mchristi@redhat.com>

This adds support for a new op cmpext. The request will read
extent.length bytes and compare them to extent.length bytes at
extent.offset on disk. If there is a miscompare the osd will return
-EILSEQ, and the mismatched buffer that was read.

rbd will use this in a multi op request to implement the
SCSI COMPARE_AND_WRITE request which is used by VMware for
its atomic test and set request.

v2:
- Merge David's tracing fixes.
- Instead of returning the mismatch offset and buffer on matching
failure just return the buffer. The client can figure out the offset
if it needs it.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 src/include/rados.h     |  2 ++
 src/osd/ReplicatedPG.cc | 31 +++++++++++++++++++++++++++++++
 src/osd/ReplicatedPG.h  |  1 +
 src/tracing/osd.tp      | 22 ++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/src/include/rados.h b/src/include/rados.h
index 4d508c0..229d855 100644
--- a/src/include/rados.h
+++ b/src/include/rados.h
@@ -258,6 +258,7 @@ extern const char *ceph_osd_state_name(int s);
 									    \
 	/* ESX/SCSI */							    \
 	f(WRITESAME,	__CEPH_OSD_OP(WR, DATA, 38),	"write-same")	    \
+	f(CMPEXT,	__CEPH_OSD_OP(RD, DATA, 31),	"cmpext")	    \
 									    \
 	/** multi **/							    \
 	f(CLONERANGE,	__CEPH_OSD_OP(WR, MULTI, 1),	"clonerange")	    \
@@ -358,6 +359,7 @@ static inline int ceph_osd_op_uses_extent(int op)
 	case CEPH_OSD_OP_ZERO:
 	case CEPH_OSD_OP_APPEND:
 	case CEPH_OSD_OP_TRIMTRUNC:
+	case CEPH_OSD_OP_CMPEXT:
 		return true;
 	default:
 		return false;
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 6a6112e..4593929 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -3650,6 +3650,32 @@ int ReplicatedPG::do_xattr_cmp_str(int op, string& v1s, bufferlist& xattr)
   }
 }
 
+int ReplicatedPG::do_extent_cmp(OpContext *ctx, OSDOp& osd_op)
+{
+  ceph_osd_op& op = osd_op.op;
+  vector<OSDOp> read_ops(1);
+  OSDOp& read_op = read_ops[0];
+  int result = 0;
+
+  read_op.op.op = CEPH_OSD_OP_SYNC_READ;
+  read_op.op.extent.offset = op.extent.offset;
+  read_op.op.extent.length = op.extent.length;
+  read_op.op.extent.truncate_seq = op.extent.truncate_seq;
+  read_op.op.extent.truncate_size = op.extent.truncate_size;
+
+  result = do_osd_ops(ctx, read_ops);
+  if (result < 0) {
+    derr << "do_extent_cmp do_osd_ops failed " << result << dendl;
+    return result;
+  }
+
+  if (osd_op.indata.contents_equal(read_op.outdata))
+    return 0;
+
+  osd_op.outdata.claim_append(read_op.outdata);
+  return -EILSEQ;
+}
+
 int ReplicatedPG::do_writesame(OpContext *ctx, OSDOp& osd_op)
 {
   ceph_osd_op& op = osd_op.op;
@@ -4154,6 +4180,11 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
       
       // --- READS ---
 
+    case CEPH_OSD_OP_CMPEXT:
+      tracepoint(osd, do_osd_op_pre_extent_cmp, soid.oid.name.c_str(), soid.snap.val, oi.size, oi.truncate_seq, op.extent.offset, op.extent.length, op.extent.truncate_size, op.extent.truncate_seq);
+      result = do_extent_cmp(ctx, osd_op);
+      break;
+
     case CEPH_OSD_OP_SYNC_READ:
       if (pool.info.require_rollback()) {
 	result = -EOPNOTSUPP;
diff --git a/src/osd/ReplicatedPG.h b/src/osd/ReplicatedPG.h
index 8004d25..adaf8af 100644
--- a/src/osd/ReplicatedPG.h
+++ b/src/osd/ReplicatedPG.h
@@ -1430,6 +1430,7 @@ protected:
   int do_xattr_cmp_u64(int op, __u64 v1, bufferlist& xattr);
   int do_xattr_cmp_str(int op, string& v1s, bufferlist& xattr);
 
+  int do_extent_cmp(OpContext *ctx, OSDOp& osd_op);
   int do_writesame(OpContext *ctx, OSDOp& osd_op);
 
   bool pgls_filter(PGLSFilter *filter, hobject_t& sobj, bufferlist& outdata);
diff --git a/src/tracing/osd.tp b/src/tracing/osd.tp
index 36ffa7e..e132b61 100644
--- a/src/tracing/osd.tp
+++ b/src/tracing/osd.tp
@@ -91,6 +91,28 @@ TRACEPOINT_EVENT(osd, do_osd_op_pre,
     )
 )
 
+TRACEPOINT_EVENT(osd, do_osd_op_pre_extent_cmp,
+    TP_ARGS(
+        const char*, oid,
+        uint64_t, snap,
+        uint64_t, osize,
+        uint32_t, oseq,
+        uint64_t, offset,
+        uint64_t, length,
+        uint64_t, truncate_size,
+        uint32_t, truncate_seq),
+    TP_FIELDS(
+        ctf_string(oid, oid)
+        ctf_integer(uint64_t, snap, snap)
+        ctf_integer(uint64_t, osize, osize)
+        ctf_integer(uint32_t, oseq, oseq)
+        ctf_integer(uint64_t, offset, offset)
+        ctf_integer(uint64_t, length, length)
+        ctf_integer(uint64_t, truncate_size, truncate_size)
+        ctf_integer(uint32_t, truncate_seq, truncate_seq)
+    )
+)
+
 TRACEPOINT_EVENT(osd, do_osd_op_pre_read,
     TP_ARGS(
         const char*, oid,
-- 
2.7.2

