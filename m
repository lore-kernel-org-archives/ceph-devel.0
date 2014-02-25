From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v2 2/5] libceph: add support for CEPH_OSD_OP_SETALLOCHINT osd op
Date: Tue, 25 Feb 2014 17:36:44 +0200
Message-ID: <1393342607-23653-3-git-send-email-ilya.dryomov@inktank.com>
References: <1393342607-23653-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:59368 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbaBYPg4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 10:36:56 -0500
Received: by mail-la0-f54.google.com with SMTP id mc6so3869941lab.27
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 07:36:55 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id gb8sm22651006lbc.13.2014.02.25.07.36.53
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Feb 2014 07:36:54 -0800 (PST)
In-Reply-To: <1393342607-23653-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is primarily for rbd's benefit and is supposed to combat
fragmentation:

"... knowing that rbd images have a 4m size, librbd can pass a hint
that will let the osd do the xfs allocation size ioctl on new files so
that they are allocated in 1m or 4m chunks.  We've seen cases where
users with rbd workloads have very high levels of fragmentation in xfs
and this would mitigate that and probably have a pretty nice
performance benefit."

SETALLOCHINT is considered advisory, so our backwards compatibility
mechanism here is to set FAILOK flag for all SETALLOCHINT ops.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 include/linux/ceph/osd_client.h |   10 ++++++++++
 include/linux/ceph/rados.h      |    8 ++++++++
 net/ceph/osd_client.c           |   31 +++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index e94f5da251d6..627d663d22b7 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -103,6 +103,11 @@ struct ceph_osd_req_op {
 			u32 timeout;
 			__u8 flag;
 		} watch;
+		struct {
+			u64 expected_object_size;
+			u64 expected_write_size;
+			__u8 expected_size_probability;
+		} alloc_hint;
 	};
 };
 
@@ -294,6 +299,11 @@ extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
 extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
 					u64 cookie, u64 version, int flag);
+extern void osd_req_op_alloc_hint_init(struct ceph_osd_request *osd_req,
+				       unsigned int which,
+				       u64 expected_object_size,
+				       u64 expected_write_size,
+				       u8 expected_size_probability);
 
 extern struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 8f9bf4570215..26e20aacf83b 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -227,6 +227,9 @@ enum {
 	CEPH_OSD_OP_OMAPRMKEYS    = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 24,
 	CEPH_OSD_OP_OMAP_CMP      = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 25,
 
+	/* hints */
+	CEPH_OSD_OP_SETALLOCHINT = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 35,
+
 	/** multi **/
 	CEPH_OSD_OP_CLONERANGE = CEPH_OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_MULTI | 1,
 	CEPH_OSD_OP_ASSERT_SRC_VERSION = CEPH_OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_MULTI | 2,
@@ -416,6 +419,11 @@ struct ceph_osd_op {
 			__le64 offset, length;
 			__le64 src_offset;
 		} __attribute__ ((packed)) clonerange;
+		struct {
+			__le64 expected_object_size;
+			__le64 expected_write_size;
+			__u8 expected_size_probability;
+		} __attribute__ ((packed)) alloc_hint;
 	};
 	__le32 payload_len;
 } __attribute__ ((packed));
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5d7fd0b8c1c8..36be43ab3030 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -436,6 +436,7 @@ static bool osd_req_opcode_valid(u16 opcode)
 	case CEPH_OSD_OP_OMAPCLEAR:
 	case CEPH_OSD_OP_OMAPRMKEYS:
 	case CEPH_OSD_OP_OMAP_CMP:
+	case CEPH_OSD_OP_SETALLOCHINT:
 	case CEPH_OSD_OP_CLONERANGE:
 	case CEPH_OSD_OP_ASSERT_SRC_VERSION:
 	case CEPH_OSD_OP_SRC_CMPXATTR:
@@ -591,6 +592,28 @@ void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_watch_init);
 
+void osd_req_op_alloc_hint_init(struct ceph_osd_request *osd_req,
+				unsigned int which,
+				u64 expected_object_size,
+				u64 expected_write_size,
+				u8 expected_size_probability)
+{
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which,
+						      CEPH_OSD_OP_SETALLOCHINT);
+
+	op->alloc_hint.expected_object_size = expected_object_size;
+	op->alloc_hint.expected_write_size = expected_write_size;
+	op->alloc_hint.expected_size_probability = expected_size_probability;
+
+	/*
+	 * CEPH_OSD_OP_SETALLOCHINT op is advisory and therefore deemed
+	 * not worth a feature bit.  Set FAILOK per-op flag to make
+	 * sure older osds don't trip over an unsupported opcode.
+	 */
+	op->flags |= CEPH_OSD_OP_FLAG_FAILOK;
+}
+EXPORT_SYMBOL(osd_req_op_alloc_hint_init);
+
 static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
 				struct ceph_osd_data *osd_data)
 {
@@ -681,6 +704,14 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 		dst->watch.ver = cpu_to_le64(src->watch.ver);
 		dst->watch.flag = src->watch.flag;
 		break;
+	case CEPH_OSD_OP_SETALLOCHINT:
+		dst->alloc_hint.expected_object_size =
+		    cpu_to_le64(src->alloc_hint.expected_object_size);
+		dst->alloc_hint.expected_write_size =
+		    cpu_to_le64(src->alloc_hint.expected_write_size);
+		dst->alloc_hint.expected_size_probability =
+		    src->alloc_hint.expected_size_probability;
+		break;
 	default:
 		pr_err("unsupported osd opcode %s\n",
 			ceph_osd_op_name(src->op));
-- 
1.7.10.4

