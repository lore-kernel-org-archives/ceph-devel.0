From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] libceph: remove dead code in osd_req_encode_op()
Date: Sat, 16 Feb 2013 11:01:07 -0600
Message-ID: <511FBB53.80401@inktank.com>
References: <511FBB12.6050207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:34673 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab3BPRBJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 12:01:09 -0500
Received: by mail-qc0-f179.google.com with SMTP id b40so1563233qcq.24
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 09:01:09 -0800 (PST)
In-Reply-To: <511FBB12.6050207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In osd_req_encode_op() there are a few cases that handle osd
opcodes that are never used in the kernel.  The presence of
this code gives the impression it's correct (which really can't
be assumed), and may impose some unnecessary restrictions on
some upcoming refactoring of this code.

So delete this effectively dead code, and report uses of the
previously handled cases as unsupported.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ac7bcbf..bbd1575 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -231,19 +231,6 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 		dst->extent.truncate_seq =
 			cpu_to_le32(src->extent.truncate_seq);
 		break;
-
-	case CEPH_OSD_OP_GETXATTR:
-	case CEPH_OSD_OP_SETXATTR:
-	case CEPH_OSD_OP_CMPXATTR:
-		dst->xattr.name_len = cpu_to_le32(src->xattr.name_len);
-		dst->xattr.value_len = cpu_to_le32(src->xattr.value_len);
-		dst->xattr.cmp_op = src->xattr.cmp_op;
-		dst->xattr.cmp_mode = src->xattr.cmp_mode;
-		ceph_pagelist_append(&req->r_trail, src->xattr.name,
-				     src->xattr.name_len);
-		ceph_pagelist_append(&req->r_trail, src->xattr.val,
-				     src->xattr.value_len);
-		break;
 	case CEPH_OSD_OP_CALL:
 		dst->cls.class_len = src->cls.class_len;
 		dst->cls.method_len = src->cls.method_len;
@@ -256,21 +243,8 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 		ceph_pagelist_append(&req->r_trail, src->cls.indata,
 				     src->cls.indata_len);
 		break;
-	case CEPH_OSD_OP_ROLLBACK:
-		dst->snap.snapid = cpu_to_le64(src->snap.snapid);
-		break;
 	case CEPH_OSD_OP_STARTSYNC:
 		break;
-	case CEPH_OSD_OP_NOTIFY:
-		{
-			__le32 prot_ver = cpu_to_le32(src->watch.prot_ver);
-			__le32 timeout = cpu_to_le32(src->watch.timeout);
-
-			ceph_pagelist_append(&req->r_trail,
-						&prot_ver, sizeof(prot_ver));
-			ceph_pagelist_append(&req->r_trail,
-						&timeout, sizeof(timeout));
-		}
 	case CEPH_OSD_OP_NOTIFY_ACK:
 	case CEPH_OSD_OP_WATCH:
 		dst->watch.cookie = cpu_to_le64(src->watch.cookie);
@@ -285,6 +259,7 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 	case CEPH_OSD_OP_MAPEXT:
 	case CEPH_OSD_OP_MASKTRUNC:
 	case CEPH_OSD_OP_SPARSE_READ:
+	case CEPH_OSD_OP_NOTIFY:
 	case CEPH_OSD_OP_ASSERT_VER:
 	case CEPH_OSD_OP_WRITEFULL:
 	case CEPH_OSD_OP_TRUNCATE:
@@ -297,6 +272,7 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 	case CEPH_OSD_OP_TMAPPUT:
 	case CEPH_OSD_OP_TMAPGET:
 	case CEPH_OSD_OP_CREATE:
+	case CEPH_OSD_OP_ROLLBACK:
 	case CEPH_OSD_OP_OMAPGETKEYS:
 	case CEPH_OSD_OP_OMAPGETVALS:
 	case CEPH_OSD_OP_OMAPGETHEADER:
@@ -310,7 +286,10 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 	case CEPH_OSD_OP_CLONERANGE:
 	case CEPH_OSD_OP_ASSERT_SRC_VERSION:
 	case CEPH_OSD_OP_SRC_CMPXATTR:
+	case CEPH_OSD_OP_GETXATTR:
 	case CEPH_OSD_OP_GETXATTRS:
+	case CEPH_OSD_OP_CMPXATTR:
+	case CEPH_OSD_OP_SETXATTR:
 	case CEPH_OSD_OP_SETXATTRS:
 	case CEPH_OSD_OP_RESETXATTRS:
 	case CEPH_OSD_OP_RMXATTR:
-- 
1.7.9.5

