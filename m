From: mchristi@redhat.com
Subject: [PATCH 2/2] osd: add write same op
Date: Wed, 29 Jul 2015 04:25:46 -0500
Message-ID: <1438161946-28473-3-git-send-email-mchristi@redhat.com>
References: <1438161946-28473-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161946-28473-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This goes with kernel patches:
    libceph: add support for write same requests
    rbd: add support for writesame requests

This adds a new ceph request writesame. Write a buffer of length
writesame.data_length bytes at writesame.offset over writesame.length
bytes.

On the kernel rbd client side, we map this command to the SCSI
WRITE_SAME request.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 src/include/rados.h     |  6 ++++++
 src/osd/ReplicatedPG.cc | 38 ++++++++++++++++++++++++++++++++++++++
 src/osd/ReplicatedPG.h  |  1 +
 3 files changed, 45 insertions(+)

diff --git a/src/include/rados.h b/src/include/rados.h
index 025dd3a..998b7fe 100644
--- a/src/include/rados.h
+++ b/src/include/rados.h
@@ -210,6 +210,7 @@ extern const char *ceph_osd_state_name(int s);
 	f(TRUNCATE,	__CEPH_OSD_OP(WR, DATA, 3),	"truncate")	    \
 	f(ZERO,		__CEPH_OSD_OP(WR, DATA, 4),	"zero")		    \
 	f(DELETE,	__CEPH_OSD_OP(WR, DATA, 5),	"delete")	    \
+	f(WRITESAME,	__CEPH_OSD_OP(WR, DATA, 36),	"write-same")	    \
 									    \
 	/* fancy write */						    \
 	f(APPEND,	__CEPH_OSD_OP(WR, DATA, 6),	"append")	    \
@@ -544,6 +545,11 @@ struct ceph_osd_op {
 			__le64 expected_object_size;
 			__le64 expected_write_size;
 		} __attribute__ ((packed)) alloc_hint;
+		struct {
+			__le64 offset;
+			__le64 length;
+			__le64 data_length;
+		} __attribute__ ((packed)) writesame;
 	};
 	__le32 payload_len;
 } __attribute__ ((packed));
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 2eedcca..bc19d6b 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -3039,6 +3039,38 @@ fail:
   return -EILSEQ;
 }
 
+int ReplicatedPG::do_writesame(OpContext *ctx, OSDOp& osd_op)
+{
+  ceph_osd_op& op = osd_op.op;
+  vector<OSDOp> write_ops(1);
+  OSDOp& write_op = write_ops[0];
+  int result = 0;
+  uint64_t write_length = op.writesame.length;
+
+  if (write_length % op.writesame.data_length)
+    return -EINVAL;
+
+  if (op.writesame.data_length != osd_op.indata.length()) {
+    derr << "invalid length ws data length " << op.writesame.data_length << " actual len " << osd_op.indata.length() << dendl;
+    return -EINVAL;
+  }
+
+  while (write_length) {
+    write_op.indata.append(osd_op.indata.c_str(), op.writesame.data_length);
+    write_length -= op.writesame.data_length;
+  }
+
+  write_op.op.op = CEPH_OSD_OP_WRITE; 
+  write_op.op.extent.offset = op.writesame.offset;
+  write_op.op.extent.length = op.writesame.length;
+
+  result = do_osd_ops(ctx, write_ops);
+  if (result < 0)
+    derr << "do_writesame do_osd_ops failed " << result << dendl;
+
+  return result;
+}
+
 // ========================================================================
 // low level osd ops
 
@@ -4329,6 +4361,12 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
       }
       break;
 
+    case CEPH_OSD_OP_WRITESAME:
+      ++ctx->num_write;
+      tracepoint(osd, do_osd_op_pre_writesame, soid.oid.name.c_str(), soid.snap.val, oi.size, op.writesame.offset, op.writesame.length, op.writesame.data_length);
+     result = do_writesame(ctx, osd_op);
+     break;
+
     case CEPH_OSD_OP_ROLLBACK :
       ++ctx->num_write;
       tracepoint(osd, do_osd_op_pre_rollback, soid.oid.name.c_str(), soid.snap.val);
diff --git a/src/osd/ReplicatedPG.h b/src/osd/ReplicatedPG.h
index f5d61c8..12a413e 100644
--- a/src/osd/ReplicatedPG.h
+++ b/src/osd/ReplicatedPG.h
@@ -1383,6 +1383,7 @@ protected:
   int do_xattr_cmp_str(int op, string& v1s, bufferlist& xattr);
 
   int do_extent_cmp(OpContext *ctx, OSDOp& osd_op);
+  int do_writesame(OpContext *ctx, OSDOp& osd_op);
 
   bool pgls_filter(PGLSFilter *filter, hobject_t& sobj, bufferlist& outdata);
   int get_pgls_filter(bufferlist::iterator& iter, PGLSFilter **pfilter);
-- 
1.8.3.1
