From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: fix wrong opcode use in osd_req_encode_op()
Date: Sat, 02 Mar 2013 19:42:23 -0600
Message-ID: <5132AA7F.3000709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44198 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab3CCBmZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Mar 2013 20:42:25 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so4937738iec.4
        for <ceph-devel@vger.kernel.org>; Sat, 02 Mar 2013 17:42:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The new cases added to osd_req_encode_op() caused a new sparse
error, which highlighted an existing problem that had been
overlooked since it was originally checked in.  When an unsupported
opcode is found the destination rather than the source opcode was
being used in the error message.  The two differ in their byte
order, and we want to be using the one in the source.

Fix the problem in both spots.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/net/ceph/osd_client.c
===================================================================
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -258,7 +258,7 @@ static void osd_req_encode_op(struct cep
 		dst->watch.flag = src->watch.flag;
 		break;
 	default:
-		pr_err("unrecognized osd opcode %d\n", dst->op);
+		pr_err("unrecognized osd opcode %d\n", src->op);
 		WARN_ON(1);
 		break;
 	case CEPH_OSD_OP_MAPEXT:
@@ -316,7 +316,7 @@ static void osd_req_encode_op(struct cep
 	case CEPH_OSD_OP_PGLS:
 	case CEPH_OSD_OP_PGLS_FILTER:
 		pr_err("unsupported osd opcode %s\n",
-			ceph_osd_op_name(dst->op));
+			ceph_osd_op_name(src->op));
 		WARN_ON(1);
 		break;
 	}
