From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] libceph: use osd_req_op_extent_init()
Date: Fri, 29 Mar 2013 16:32:38 -0500
Message-ID: <51560876.8090408@inktank.com>
References: <5156080E.9040603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49356 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678Ab3C2Vck (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 17:32:40 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so935520iec.5
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 14:32:40 -0700 (PDT)
In-Reply-To: <5156080E.9040603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Use osd_req_op_extent_init() in ceph_osdc_new_request() to
initialize the one or two ops built in that function.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7136060..55f7c9a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -581,17 +581,10 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 			truncate_size = object_size;
 	}

-	memset(&ops, 0, sizeof ops);
-	ops[0].op = opcode;
-	ops[0].extent.offset = objoff;
-	ops[0].extent.length = objlen;
-	ops[0].extent.truncate_size = truncate_size;
-	ops[0].extent.truncate_seq = truncate_seq;
-	if (ops[0].op == CEPH_OSD_OP_WRITE)
-		ops[0].payload_len = *plen;
-
+	osd_req_op_extent_init(&ops[0], opcode, objoff, objlen,
+				truncate_size, truncate_seq);
 	if (do_sync)
-		ops[1].op = CEPH_OSD_OP_STARTSYNC;
+		osd_req_op_init(&ops[1], CEPH_OSD_OP_STARTSYNC);

 	req->r_file_layout = *layout;  /* keep a copy */

-- 
1.7.9.5

