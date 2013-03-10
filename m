From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] libceph: kill osd request r_trail
Date: Sun, 10 Mar 2013 15:36:32 -0500
Message-ID: <513CEED0.9040107@inktank.com>
References: <513CEE83.4040900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:35897 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab3CJUgg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 16:36:36 -0400
Received: by mail-qe0-f52.google.com with SMTP id s14so1923895qeb.39
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 13:36:35 -0700 (PDT)
In-Reply-To: <513CEE83.4040900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The osd trail is a pagelist, used only for a CALL osd operation
to hold the class and method names, along with any input data for
the call.

It is only currently used by the rbd client, and when it's used it
is the only bit of outbound data in the osd request.  Since we
already support (non-trail) pagelist data in a message, we can
just save this outbound CALL data in the "normal" pagelist rather
than the trail, and get rid of the trail entirely.

The existing pagelist support depends on the pagelist being
dynamically allocated, and ownership of it is passed to the
messenger once it's been attached to a message.  (That is to say,
the messenger releases and frees the pagelist when it's done with
it).  That means we need to dynamically allocate the pagelist also.

Note that we simply assert that the allocation of a pagelist
structure succeeds.  Appending to a pagelist might require a dynamic
allocation, so we're already assuming we won't run into trouble
doing so (we're just ignore any failures--and that should be fixed
at some point).

This resolves:
    http://tracker.ceph.com/issues/4407

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    1 -
 net/ceph/osd_client.c           |   23 ++++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index cf0ba93..1dab291 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -134,7 +134,6 @@ struct ceph_osd_request {

 	struct ceph_osd_data r_data_in;
 	struct ceph_osd_data r_data_out;
-	struct ceph_pagelist r_trail;	      /* trailing part of data out */
 };

 struct ceph_osd_event {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 8fa3300..d0a9fc4 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -138,7 +138,6 @@ void ceph_osdc_release_request(struct kref *kref)
 	}

 	ceph_put_snap_context(req->r_snapc);
-	ceph_pagelist_release(&req->r_trail);
 	if (req->r_mempool)
 		mempool_free(req, req->r_osdc->req_mempool);
 	else
@@ -202,7 +201,6 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,

 	req->r_data_in.type = CEPH_OSD_DATA_TYPE_NONE;
 	req->r_data_out.type = CEPH_OSD_DATA_TYPE_NONE;
-	ceph_pagelist_init(&req->r_trail);

 	/* create request message; allow space for oid */
 	if (use_mempool)
@@ -227,7 +225,7 @@ static u64 osd_req_encode_op(struct ceph_osd_request
*req,
 			      struct ceph_osd_req_op *src)
 {
 	u64 out_data_len = 0;
-	u64 tmp;
+	struct ceph_pagelist *pagelist;

 	dst->op = cpu_to_le16(src->op);

@@ -246,18 +244,23 @@ static u64 osd_req_encode_op(struct
ceph_osd_request *req,
 			cpu_to_le32(src->extent.truncate_seq);
 		break;
 	case CEPH_OSD_OP_CALL:
+		pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
+		BUG_ON(!pagelist);
+		ceph_pagelist_init(pagelist);
+
 		dst->cls.class_len = src->cls.class_len;
 		dst->cls.method_len = src->cls.method_len;
 		dst->cls.indata_len = cpu_to_le32(src->cls.indata_len);
-
-		tmp = req->r_trail.length;
-		ceph_pagelist_append(&req->r_trail, src->cls.class_name,
+		ceph_pagelist_append(pagelist, src->cls.class_name,
 				     src->cls.class_len);
-		ceph_pagelist_append(&req->r_trail, src->cls.method_name,
+		ceph_pagelist_append(pagelist, src->cls.method_name,
 				     src->cls.method_len);
-		ceph_pagelist_append(&req->r_trail, src->cls.indata,
+		ceph_pagelist_append(pagelist, src->cls.indata,
 				     src->cls.indata_len);
-		out_data_len = req->r_trail.length - tmp;
+
+		req->r_data_out.type = CEPH_OSD_DATA_TYPE_PAGELIST;
+		req->r_data_out.pagelist = pagelist;
+		out_data_len = pagelist->length;
 		break;
 	case CEPH_OSD_OP_STARTSYNC:
 		break;
@@ -1782,8 +1785,6 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,

 	ceph_osdc_msg_data_set(req->r_reply, &req->r_data_in);
 	ceph_osdc_msg_data_set(req->r_request, &req->r_data_out);
-	if (req->r_trail.length)
-		ceph_msg_data_set_trail(req->r_request, &req->r_trail);

 	register_request(osdc, req);

-- 
1.7.9.5

