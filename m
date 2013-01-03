From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 2/2] libceph: kill op_needs_trail()
Date: Thu, 03 Jan 2013 17:35:33 -0600
Message-ID: <50E615C5.6010301@inktank.com>
References: <50E61589.6080900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:64996 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab3ACXff (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 18:35:35 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so18976256iea.22
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 15:35:35 -0800 (PST)
In-Reply-To: <50E61589.6080900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Since every osd message is now prepared to include trailing data,
there's no need to check ahead of time whether any operations will
make use of the trail portion of the message.

We can drop the second argument to get_num_ops(), and as a result we
can also get rid of op_needs_trail() which is no longer used.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 58a63c0..2adbfcc 100644
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

