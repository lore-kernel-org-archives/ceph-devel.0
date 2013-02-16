From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] libceph: report defined but unsupported osd ops
Date: Sat, 16 Feb 2013 11:00:43 -0600
Message-ID: <511FBB3B.4040004@inktank.com>
References: <511FBB12.6050207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:56584 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab3BPRAq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 12:00:46 -0500
Received: by mail-qa0-f48.google.com with SMTP id j8so736571qah.14
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 09:00:45 -0800 (PST)
In-Reply-To: <511FBB12.6050207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If osd_req_encode_op() is given any opcode it doesn't recognize
it reports an error.

This patch fleshes out that routine to distinguish between
well-defined but unsupported values and values that are simply
bogus.

This and the next commit are related to:
    http://tracker.ceph.com/issues/4126

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   54
+++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ad6b8b3..ac7bcbf 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -281,6 +281,60 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 		pr_err("unrecognized osd opcode %d\n", dst->op);
 		WARN_ON(1);
 		break;
+	case CEPH_OSD_OP_STAT:
+	case CEPH_OSD_OP_MAPEXT:
+	case CEPH_OSD_OP_MASKTRUNC:
+	case CEPH_OSD_OP_SPARSE_READ:
+	case CEPH_OSD_OP_ASSERT_VER:
+	case CEPH_OSD_OP_WRITEFULL:
+	case CEPH_OSD_OP_TRUNCATE:
+	case CEPH_OSD_OP_ZERO:
+	case CEPH_OSD_OP_DELETE:
+	case CEPH_OSD_OP_APPEND:
+	case CEPH_OSD_OP_SETTRUNC:
+	case CEPH_OSD_OP_TRIMTRUNC:
+	case CEPH_OSD_OP_TMAPUP:
+	case CEPH_OSD_OP_TMAPPUT:
+	case CEPH_OSD_OP_TMAPGET:
+	case CEPH_OSD_OP_CREATE:
+	case CEPH_OSD_OP_OMAPGETKEYS:
+	case CEPH_OSD_OP_OMAPGETVALS:
+	case CEPH_OSD_OP_OMAPGETHEADER:
+	case CEPH_OSD_OP_OMAPGETVALSBYKEYS:
+	case CEPH_OSD_OP_MODE_RD:
+	case CEPH_OSD_OP_OMAPSETVALS:
+	case CEPH_OSD_OP_OMAPSETHEADER:
+	case CEPH_OSD_OP_OMAPCLEAR:
+	case CEPH_OSD_OP_OMAPRMKEYS:
+	case CEPH_OSD_OP_OMAP_CMP:
+	case CEPH_OSD_OP_CLONERANGE:
+	case CEPH_OSD_OP_ASSERT_SRC_VERSION:
+	case CEPH_OSD_OP_SRC_CMPXATTR:
+	case CEPH_OSD_OP_GETXATTRS:
+	case CEPH_OSD_OP_SETXATTRS:
+	case CEPH_OSD_OP_RESETXATTRS:
+	case CEPH_OSD_OP_RMXATTR:
+	case CEPH_OSD_OP_PULL:
+	case CEPH_OSD_OP_PUSH:
+	case CEPH_OSD_OP_BALANCEREADS:
+	case CEPH_OSD_OP_UNBALANCEREADS:
+	case CEPH_OSD_OP_SCRUB:
+	case CEPH_OSD_OP_SCRUB_RESERVE:
+	case CEPH_OSD_OP_SCRUB_UNRESERVE:
+	case CEPH_OSD_OP_SCRUB_STOP:
+	case CEPH_OSD_OP_SCRUB_MAP:
+	case CEPH_OSD_OP_WRLOCK:
+	case CEPH_OSD_OP_WRUNLOCK:
+	case CEPH_OSD_OP_RDLOCK:
+	case CEPH_OSD_OP_RDUNLOCK:
+	case CEPH_OSD_OP_UPLOCK:
+	case CEPH_OSD_OP_DNLOCK:
+	case CEPH_OSD_OP_PGLS:
+	case CEPH_OSD_OP_PGLS_FILTER:
+		pr_err("unsupported osd opcode %s\n",
+			ceph_osd_op_name(dst->op));
+		WARN_ON(1);
+		break;
 	}
 	dst->payload_len = cpu_to_le32(src->payload_len);
 }
-- 
1.7.9.5

