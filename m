From: Mike Christie <mchristi@redhat.com>
Subject: [PATCH 1/2] ceph osd: add support for new op writesame
Date: Thu, 10 Mar 2016 00:34:31 -0600
Message-ID: <1457591672-17430-2-git-send-email-mchristi@redhat.com>
References: <[PATCH 0/2] ceph osd: initial VMware VAAI support>
 <1457591672-17430-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54117 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbcCJGef (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Mar 2016 01:34:35 -0500
In-Reply-To: <1457591672-17430-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ddiss@suse.de, Mike Christie <mchristi@redhat.com>

This adds a new ceph request writesame that writes a buffer of length
writesame.data_length bytes at writesame.offset over
writesame.length bytes.

This command maps to SCSI's WRITE SAME request, so users like LIO+rbd
can pass this to the OSD. Right now, it only saves having to transfer
writesame.length bytes over the network, but future versions will be
to fully offload it by passing it directly to the FS/devices if they
support it.

v2:
- Merge David's tracing fixes.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 src/include/rados.h     |  8 ++++++++
 src/osd/ReplicatedPG.cc | 38 ++++++++++++++++++++++++++++++++++++++
 src/osd/ReplicatedPG.h  |  2 ++
 src/tracing/osd.tp      | 18 ++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/src/include/rados.h b/src/include/rados.h
index f14d677..4d508c0 100644
--- a/src/include/rados.h
+++ b/src/include/rados.h
@@ -256,6 +256,9 @@ extern const char *ceph_osd_state_name(int s);
 	f(CACHE_PIN,	__CEPH_OSD_OP(WR, DATA, 36),	"cache-pin")        \
 	f(CACHE_UNPIN,	__CEPH_OSD_OP(WR, DATA, 37),	"cache-unpin")      \
 									    \
+	/* ESX/SCSI */							    \
+	f(WRITESAME,	__CEPH_OSD_OP(WR, DATA, 38),	"write-same")	    \
+									    \
 	/** multi **/							    \
 	f(CLONERANGE,	__CEPH_OSD_OP(WR, MULTI, 1),	"clonerange")	    \
 	f(ASSERT_SRC_VERSION, __CEPH_OSD_OP(RD, MULTI, 2), "assert-src-version") \
@@ -538,6 +541,11 @@ struct ceph_osd_op {
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
index 5231e49..6a6112e 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -3650,6 +3650,37 @@ int ReplicatedPG::do_xattr_cmp_str(int op, string& v1s, bufferlist& xattr)
   }
 }
 
+int ReplicatedPG::do_writesame(OpContext *ctx, OSDOp& osd_op)
+{
+  ceph_osd_op& op = osd_op.op;
+  vector<OSDOp> write_ops(1);
+  OSDOp& write_op = write_ops[0];
+  uint64_t write_length = op.writesame.length;
+  int result = 0;
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
+  result = do_osd_ops(ctx, write_ops);
+  if (result < 0)
+    derr << "do_writesame do_osd_ops failed " << result << dendl;
+
+  return result;
+}
+
 // ========================================================================
 // low level osd ops
 
@@ -5038,6 +5069,13 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
       }
       break;
 
+    case CEPH_OSD_OP_WRITESAME:
+      ++ctx->num_write;
+      tracepoint(osd, do_osd_op_pre_writesame, soid.oid.name.c_str(), soid.snap.val, oi.size, op.writesame.offset, op.writesame.length, op.writesame.data_length);
+
+     result = do_writesame(ctx, osd_op);
+     break;
+
     case CEPH_OSD_OP_ROLLBACK :
       ++ctx->num_write;
       tracepoint(osd, do_osd_op_pre_rollback, soid.oid.name.c_str(), soid.snap.val);
diff --git a/src/osd/ReplicatedPG.h b/src/osd/ReplicatedPG.h
index 3d24617..8004d25 100644
--- a/src/osd/ReplicatedPG.h
+++ b/src/osd/ReplicatedPG.h
@@ -1430,6 +1430,8 @@ protected:
   int do_xattr_cmp_u64(int op, __u64 v1, bufferlist& xattr);
   int do_xattr_cmp_str(int op, string& v1s, bufferlist& xattr);
 
+  int do_writesame(OpContext *ctx, OSDOp& osd_op);
+
   bool pgls_filter(PGLSFilter *filter, hobject_t& sobj, bufferlist& outdata);
   int get_pgls_filter(bufferlist::iterator& iter, PGLSFilter **pfilter);
 
diff --git a/src/tracing/osd.tp b/src/tracing/osd.tp
index 7a2ffd9..36ffa7e 100644
--- a/src/tracing/osd.tp
+++ b/src/tracing/osd.tp
@@ -381,6 +381,24 @@ TRACEPOINT_EVENT(osd, do_osd_op_pre_writefull,
     )
 )
 
+TRACEPOINT_EVENT(osd, do_osd_op_pre_writesame,
+    TP_ARGS(
+        const char*, oid,
+        uint64_t, snap,
+        uint64_t, osize,
+        uint64_t, offset,
+        uint64_t, length,
+        uint64_t, data_length),
+    TP_FIELDS(
+        ctf_string(oid, oid)
+        ctf_integer(uint64_t, snap, snap)
+        ctf_integer(uint64_t, osize, osize)
+        ctf_integer(uint64_t, offset, offset)
+        ctf_integer(uint64_t, length, length)
+        ctf_integer(uint64_t, data_length, data_length)
+    )
+)
+
 TRACEPOINT_EVENT(osd, do_osd_op_pre_rollback,
     TP_ARGS(
         const char*, oid,
-- 
2.7.2

