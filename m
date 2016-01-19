From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH V2 3/6] libceph: allow reserving operations in OSD request
Date: Tue, 19 Jan 2016 16:08:08 +0800
Message-ID: <1453190891-40937-4-git-send-email-zyan@redhat.com>
References: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445AbcASIIo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 03:08:44 -0500
In-Reply-To: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

This allows us to reserve some operations for furture use. we do
not need to use all reserved operations.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 include/linux/ceph/osd_client.h | 1 +
 net/ceph/osd_client.c           | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index fda3a05..9802df1 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -139,6 +139,7 @@ struct ceph_osd_request {
 	u32               r_sent;      /* >0 if r_request is sending/sent */
 
 	/* request osd ops array  */
+	unsigned int		r_max_ops;
 	unsigned int		r_num_ops;
 	struct ceph_osd_req_op	*r_ops;
 	struct ceph_osd_req_op	r_inline_ops[CEPH_OSD_INITIAL_OP];
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 3852006..9c0cf2e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -385,7 +385,8 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 
 	req->r_osdc = osdc;
 	req->r_mempool = use_mempool;
-	req->r_num_ops = num_ops;
+	req->r_num_ops = 0;
+	req->r_max_ops = num_ops;
 
 	if (num_ops <= CEPH_OSD_INITIAL_OP) {
 		req->r_ops = req->r_inline_ops;
@@ -480,8 +481,10 @@ _osd_req_op_init(struct ceph_osd_request *osd_req, unsigned int which,
 {
 	struct ceph_osd_req_op *op;
 
-	BUG_ON(which >= osd_req->r_num_ops);
+	BUG_ON(which >= osd_req->r_max_ops);
 	BUG_ON(!osd_req_opcode_valid(opcode));
+	if (which >= osd_req->r_num_ops)
+		osd_req->r_num_ops = which + 1;
 
 	op = &osd_req->r_ops[which];
 	memset(op, 0, sizeof (*op));
-- 
2.5.0

