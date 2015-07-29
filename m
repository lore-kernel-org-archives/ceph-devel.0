From: mchristi@redhat.com
Subject: [PATCH 1/2] osd: add new extent comparison op
Date: Wed, 29 Jul 2015 04:25:45 -0500
Message-ID: <1438161946-28473-2-git-send-email-mchristi@redhat.com>
References: <1438161946-28473-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161946-28473-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This goes with kernel patch
    libceph: add support for CMPEXT compare extent requests
and
    rbd: add support for COMPARE_AND_WRITE/CMPEXT

This adds support for the CMPEXT request. The request will compare
extent.length bytes and compare them to extent.length bytes at
extent.offset on disk. If there is a miscompare the osd will return
-EILSEQ, the offset in the buffer where it occurred, and the buffer.

This op is going to be used for SCSI COMPARE_AND_WRITE support. For this
SCSI command, we are required to atomically do the CMPEXT operation and if
successful do a WRITE operation. The kernel rbd client is sending those
two ops in a multi op request.

Note: I am still working on the locking for this operation. Is there
a local lock I can take?

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 src/include/rados.h     |  3 +++
 src/osd/ReplicatedPG.cc | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/osd/ReplicatedPG.h  |  2 ++
 3 files changed, 51 insertions(+)

diff --git a/src/include/rados.h b/src/include/rados.h
index 424bef1..025dd3a 100644
--- a/src/include/rados.h
+++ b/src/include/rados.h
@@ -202,6 +202,8 @@ extern const char *ceph_osd_state_name(int s);
 	/* sync */							    \
 	f(SYNC_READ,	__CEPH_OSD_OP(RD, DATA, 11),	"sync_read")	    \
 									    \
+	f(CMPEXT,	__CEPH_OSD_OP(RD, DATA, 31),	"cmpext")	    \
+									    \
 	/* write */							    \
 	f(WRITE,	__CEPH_OSD_OP(WR, DATA, 1),	"write")	    \
 	f(WRITEFULL,	__CEPH_OSD_OP(WR, DATA, 2),	"writefull")	    \
@@ -361,6 +363,7 @@ static inline int ceph_osd_op_uses_extent(int op)
 	case CEPH_OSD_OP_ZERO:
 	case CEPH_OSD_OP_APPEND:
 	case CEPH_OSD_OP_TRIMTRUNC:
+	case CEPH_OSD_OP_CMPEXT:
 		return true;
 	default:
 		return false;
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index dcd11f5..2eedcca 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -2999,6 +2999,46 @@ int ReplicatedPG::do_xattr_cmp_str(int op, string& v1s, bufferlist& xattr)
   }
 }
 
+int ReplicatedPG::do_extent_cmp(OpContext *ctx, OSDOp& osd_op)
+{
+  ceph_osd_op& op = osd_op.op;
+  vector<OSDOp> read_ops(1);
+  OSDOp& read_op = read_ops[0];
+  int result = 0;
+  uint64_t mismatch_offset = 0;
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
+  if (read_op.outdata.length() != osd_op.indata.length())
+    goto fail;
+
+  for (uint64_t p = 0; p < osd_op.indata.length(); p++) {
+    if (read_op.outdata[p] != osd_op.indata[p]) {
+      mismatch_offset = p;
+      dout(20) << "mismatch at " << p << " read " << read_op.outdata << " sent " << osd_op.indata << dendl;
+      goto fail;
+    }
+  }
+
+  return 0;
+
+fail:
+  ::encode(mismatch_offset, osd_op.outdata);
+  // should this be ::encode(read_op.outdata, osd_op.outdata); 
+  osd_op.outdata.claim_append(read_op.outdata);
+  return -EILSEQ;
+}
+
 // ========================================================================
 // low level osd ops
 
@@ -3428,6 +3468,12 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
       
       // --- READS ---
 
+    case CEPH_OSD_OP_CMPEXT:
+	tracepoint(osd, do_osd_op_pre_extent_cmp, soid.oid.name.c_str(), soid.snap.val, size, seq, op.extent.offset, op.extent.length, op.extent.truncate_size, op.extent.truncate_seq);
+        // TODO: Locking - this op and the write are supposed to be atomic
+	result = do_extent_cmp(ctx, osd_op);
+	break;
+
     case CEPH_OSD_OP_SYNC_READ:
       if (pool.info.require_rollback()) {
 	result = -EOPNOTSUPP;
diff --git a/src/osd/ReplicatedPG.h b/src/osd/ReplicatedPG.h
index 9c28036..f5d61c8 100644
--- a/src/osd/ReplicatedPG.h
+++ b/src/osd/ReplicatedPG.h
@@ -1382,6 +1382,8 @@ protected:
   int do_xattr_cmp_u64(int op, __u64 v1, bufferlist& xattr);
   int do_xattr_cmp_str(int op, string& v1s, bufferlist& xattr);
 
+  int do_extent_cmp(OpContext *ctx, OSDOp& osd_op);
+
   bool pgls_filter(PGLSFilter *filter, hobject_t& sobj, bufferlist& outdata);
   int get_pgls_filter(bufferlist::iterator& iter, PGLSFilter **pfilter);
 
-- 
1.8.3.1
