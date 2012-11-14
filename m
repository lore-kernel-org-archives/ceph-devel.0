From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] libceph: always allow trail in osd request
Date: Wed, 14 Nov 2012 10:09:46 -0600
Message-ID: <50A3C24A.6050302@inktank.com>
References: <50A3C1F7.6070107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51136 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161112Ab2KNQJv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:09:51 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so375206iay.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:09:51 -0800 (PST)
In-Reply-To: <50A3C1F7.6070107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

An osd request structure contains an optional trail portion, which
if present will contain data to be passed in the payload portion of
the message containing the request.  The trail field is a
ceph_pagelist pointer, and if null it indicates there is no trail.

A ceph_pagelist structure contains a length field, and it can
legitimately hold value 0.  Make use of this to change the
interpretation of the "trail" of an osd request so that every osd
request has trailing data, it just might have length 0.

This means we change the r_trail field in a ceph_osd_request
structure from a pointer to a structure that is always initialized.

Note that in ceph_osdc_start_request(), the trail pointer (or now
address of that structure) is assigned to a ceph message's trail
field.  Here's why that's still OK (looking at net/ceph/messenger.c):
    - What would have resulted in a null pointer previously will now
      refer to a 0-length page list.  That message trail pointer
      is used in two functions, write_partial_msg_pages() and
      out_msg_pos_next().
    - In write_partial_msg_pages(), a null page list pointer is
      handled the same as a message with 0-length trail, and both
      result in a "in_trail" variable set to false.  The trail
      pointer is only used if in_trail is true.
    - The only other place the message trail pointer is used is
      out_msg_pos_next().  That function is only called by
      write_partial_msg_pages() and only touches the trail pointer
      if the in_trail value it is passed is true.
Therefore a null ceph_msg->trail pointer is equivalent to a non-null
pointer referring to a 0-length page list structure.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    4 ++--
 net/ceph/osd_client.c           |   43
+++++++++++----------------------------
 2 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index f2e5d2c..61562c7 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -10,6 +10,7 @@
 #include <linux/ceph/osdmap.h>
 #include <linux/ceph/messenger.h>
 #include <linux/ceph/auth.h>
+#include <linux/ceph/pagelist.h>

 /*
  * Maximum object name size
@@ -22,7 +23,6 @@ struct ceph_snap_context;
 struct ceph_osd_request;
 struct ceph_osd_client;
 struct ceph_authorizer;
-struct ceph_pagelist;

 /*
  * completion callback for async writepages
@@ -95,7 +95,7 @@ struct ceph_osd_request {
 	struct bio       *r_bio;	      /* instead of pages */
 #endif

-	struct ceph_pagelist *r_trail;	      /* trailing part of the data */
+	struct ceph_pagelist r_trail;	      /* trailing part of the data */
 };

 struct ceph_osd_event {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 540276e..15984d2 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -163,10 +163,7 @@ void ceph_osdc_release_request(struct kref *kref)
 		bio_put(req->r_bio);
 #endif
 	ceph_put_snap_context(req->r_snapc);
-	if (req->r_trail) {
-		ceph_pagelist_release(req->r_trail);
-		kfree(req->r_trail);
-	}
+	ceph_pagelist_release(&req->r_trail);
 	if (req->r_mempool)
 		mempool_free(req, req->r_osdc->req_mempool);
 	else
@@ -200,8 +197,7 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 {
 	struct ceph_osd_request *req;
 	struct ceph_msg *msg;
-	int needs_trail;
-	int num_op = get_num_ops(ops, &needs_trail);
+	int num_op = get_num_ops(ops, NULL);
 	size_t msg_size = sizeof(struct ceph_osd_request_head);

 	msg_size += num_op*sizeof(struct ceph_osd_op);
@@ -244,15 +240,7 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	}
 	req->r_reply = msg;

-	/* allocate space for the trailing data */
-	if (needs_trail) {
-		req->r_trail = kmalloc(sizeof(struct ceph_pagelist), gfp_flags);
-		if (!req->r_trail) {
-			ceph_osdc_put_request(req);
-			return NULL;
-		}
-		ceph_pagelist_init(req->r_trail);
-	}
+	ceph_pagelist_init(&req->r_trail);

 	/* create request message; allow space for oid */
 	msg_size += MAX_OBJ_NAME_SIZE;
@@ -304,29 +292,25 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 	case CEPH_OSD_OP_GETXATTR:
 	case CEPH_OSD_OP_SETXATTR:
 	case CEPH_OSD_OP_CMPXATTR:
-		BUG_ON(!req->r_trail);
-
 		dst->xattr.name_len = cpu_to_le32(src->xattr.name_len);
 		dst->xattr.value_len = cpu_to_le32(src->xattr.value_len);
 		dst->xattr.cmp_op = src->xattr.cmp_op;
 		dst->xattr.cmp_mode = src->xattr.cmp_mode;
-		ceph_pagelist_append(req->r_trail, src->xattr.name,
+		ceph_pagelist_append(&req->r_trail, src->xattr.name,
 				     src->xattr.name_len);
-		ceph_pagelist_append(req->r_trail, src->xattr.val,
+		ceph_pagelist_append(&req->r_trail, src->xattr.val,
 				     src->xattr.value_len);
 		break;
 	case CEPH_OSD_OP_CALL:
-		BUG_ON(!req->r_trail);
-
 		dst->cls.class_len = src->cls.class_len;
 		dst->cls.method_len = src->cls.method_len;
 		dst->cls.indata_len = cpu_to_le32(src->cls.indata_len);

-		ceph_pagelist_append(req->r_trail, src->cls.class_name,
+		ceph_pagelist_append(&req->r_trail, src->cls.class_name,
 				     src->cls.class_len);
-		ceph_pagelist_append(req->r_trail, src->cls.method_name,
+		ceph_pagelist_append(&req->r_trail, src->cls.method_name,
 				     src->cls.method_len);
-		ceph_pagelist_append(req->r_trail, src->cls.indata,
+		ceph_pagelist_append(&req->r_trail, src->cls.indata,
 				     src->cls.indata_len);
 		break;
 	case CEPH_OSD_OP_ROLLBACK:
@@ -339,11 +323,9 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 			__le32 prot_ver = cpu_to_le32(src->watch.prot_ver);
 			__le32 timeout = cpu_to_le32(src->watch.timeout);

-			BUG_ON(!req->r_trail);
-
-			ceph_pagelist_append(req->r_trail,
+			ceph_pagelist_append(&req->r_trail,
 						&prot_ver, sizeof(prot_ver));
-			ceph_pagelist_append(req->r_trail,
+			ceph_pagelist_append(&req->r_trail,
 						&timeout, sizeof(timeout));
 		}
 	case CEPH_OSD_OP_NOTIFY_ACK:
@@ -406,8 +388,7 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 		op++;
 	}

-	if (req->r_trail)
-		data_len += req->r_trail->length;
+	data_len += req->r_trail.length;

 	if (snapc) {
 		head->snap_seq = cpu_to_le64(snapc->seq);
@@ -1731,7 +1712,7 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,
 #ifdef CONFIG_BLOCK
 	req->r_request->bio = req->r_bio;
 #endif
-	req->r_request->trail = req->r_trail;
+	req->r_request->trail = &req->r_trail;

 	register_request(osdc, req);

-- 
1.7.9.5

