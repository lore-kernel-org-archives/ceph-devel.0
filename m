From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/6] libceph: change how osd_op_reply message size is calculated
Date: Thu, 19 May 2016 16:06:40 +0200
Message-ID: <1463666802-25140-5-git-send-email-idryomov@gmail.com>
References: <1463666802-25140-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36459 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988AbcESOHL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 10:07:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so21258926wmw.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 07:07:10 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-165-81.net.upcbroadband.cz. [94.112.165.81])
        by smtp.gmail.com with ESMTPSA id b124sm3586833wmb.1.2016.05.19.07.07.08
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 07:07:09 -0700 (PDT)
In-Reply-To: <1463666802-25140-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For a message pool message, preallocate a page, just like we do for
osd_op.  For a normal message, take ceph_object_id into account and
don't bother subtracting CEPH_OSD_SLAB_OPS ceph_osd_ops.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d66dacc9d0d4..75e27bd3d372 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -19,7 +19,6 @@
 #include <linux/ceph/auth.h>
 #include <linux/ceph/pagelist.h>
 
-#define OSD_OP_FRONT_LEN	4096
 #define OSD_OPREPLY_FRONT_LEN	512
 
 static struct kmem_cache	*ceph_osd_request_cache;
@@ -440,11 +439,8 @@ int ceph_osdc_alloc_messages(struct ceph_osd_request *req, gfp_t gfp)
 
 	/* create reply message */
 	msg_size = OSD_OPREPLY_FRONT_LEN;
-	if (req->r_num_ops > CEPH_OSD_SLAB_OPS) {
-		/* ceph_osd_op and rval */
-		msg_size += (req->r_num_ops - CEPH_OSD_SLAB_OPS) *
-			    (sizeof(struct ceph_osd_op) + 4);
-	}
+	msg_size += req->r_base_oid.name_len;
+	msg_size += req->r_num_ops * sizeof(struct ceph_osd_op);
 
 	if (req->r_mempool)
 		msg = ceph_msgpool_get(&osdc->msgpool_op_reply, 0);
@@ -2702,13 +2698,11 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 		goto out;
 
 	err = ceph_msgpool_init(&osdc->msgpool_op, CEPH_MSG_OSD_OP,
-				OSD_OP_FRONT_LEN, 10, true,
-				"osd_op");
+				PAGE_SIZE, 10, true, "osd_op");
 	if (err < 0)
 		goto out_mempool;
 	err = ceph_msgpool_init(&osdc->msgpool_op_reply, CEPH_MSG_OSD_OPREPLY,
-				OSD_OPREPLY_FRONT_LEN, 10, true,
-				"osd_op_reply");
+				PAGE_SIZE, 10, true, "osd_op_reply");
 	if (err < 0)
 		goto out_msgpool;
 
-- 
2.4.3

