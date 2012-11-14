From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] libceph: kill op_needs_trail()
Date: Wed, 14 Nov 2012 10:10:01 -0600
Message-ID: <50A3C259.6010405@inktank.com>
References: <50A3C1F7.6070107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51136 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422730Ab2KNQKD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:10:03 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so375206iay.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:10:03 -0800 (PST)
In-Reply-To: <50A3C1F7.6070107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Since every osd message is now prepared to include trailing data,
there's no need to check ahead of time whether any operations will
make use of the trail portion of the message.

We can drop the second argument ot get_num_ops(), and as a result we
can also get rid of op_needs_trail() which is no longer used.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 15984d2..20b7921 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -32,20 +32,6 @@ static void __unregister_linger_request(struct
ceph_osd_client *osdc,
 static void __send_request(struct ceph_osd_client *osdc,
 			   struct ceph_osd_request *req);

-static int op_needs_trail(int op)
-{
-	switch (op) {
-	case CEPH_OSD_OP_GETXATTR:
-	case CEPH_OSD_OP_SETXATTR:
-	case CEPH_OSD_OP_CMPXATTR:
-	case CEPH_OSD_OP_CALL:
-	case CEPH_OSD_OP_NOTIFY:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
 static int op_has_extent(int op)
 {
 	return (op == CEPH_OSD_OP_READ ||
@@ -171,17 +157,12 @@ void ceph_osdc_release_request(struct kref *kref)
 }
 EXPORT_SYMBOL(ceph_osdc_release_request);

-static int get_num_ops(struct ceph_osd_req_op *ops, int *needs_trail)
+static int get_num_ops(struct ceph_osd_req_op *ops)
 {
 	int i = 0;

-	if (needs_trail)
-		*needs_trail = 0;
-	while (ops[i].op) {
-		if (needs_trail && op_needs_trail(ops[i].op))
-			*needs_trail = 1;
+	while (ops[i].op)
 		i++;
-	}

 	return i;
 }
@@ -197,7 +178,7 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 {
 	struct ceph_osd_request *req;
 	struct ceph_msg *msg;
-	int num_op = get_num_ops(ops, NULL);
+	int num_op = get_num_ops(ops);
 	size_t msg_size = sizeof(struct ceph_osd_request_head);

 	msg_size += num_op*sizeof(struct ceph_osd_op);
@@ -357,7 +338,7 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 	struct ceph_osd_req_op *src_op;
 	struct ceph_osd_op *op;
 	void *p;
-	int num_op = get_num_ops(src_ops, NULL);
+	int num_op = get_num_ops(src_ops);
 	size_t msg_size = sizeof(*head) + num_op*sizeof(*op);
 	int flags = req->r_flags;
 	u64 data_len = 0;
-- 
1.7.9.5

