From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 3/4] libceph: rename __ceph_osdc_alloc_messages to ceph_osdc_alloc_num_messages
Date: Wed,  1 Jul 2020 11:54:45 -0400
Message-ID: <20200701155446.41141-4-jlayton@kernel.org>
References: <20200701155446.41141-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbgGAPyt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:54:49 -0400
In-Reply-To: <20200701155446.41141-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

...and make it public and export it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ceph/osd_client.h |  3 +++
 net/ceph/osd_client.c           | 13 +++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 40a08c4e5d8d..71b7610c3a3c 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -481,6 +481,9 @@ extern struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *
 					       unsigned int num_ops,
 					       bool use_mempool,
 					       gfp_t gfp_flags);
+int ceph_osdc_alloc_num_messages(struct ceph_osd_request *req, gfp_t gfp,
+				 int num_request_data_items,
+				 int num_reply_data_items);
 int ceph_osdc_alloc_messages(struct ceph_osd_request *req, gfp_t gfp);
 
 extern struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 4ddf23120b1a..7be78fa6e2c3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -613,9 +613,9 @@ static int ceph_oloc_encoding_size(const struct ceph_object_locator *oloc)
 	return 8 + 4 + 4 + 4 + (oloc->pool_ns ? oloc->pool_ns->len : 0);
 }
 
-static int __ceph_osdc_alloc_messages(struct ceph_osd_request *req, gfp_t gfp,
-				      int num_request_data_items,
-				      int num_reply_data_items)
+int ceph_osdc_alloc_num_messages(struct ceph_osd_request *req, gfp_t gfp,
+				 int num_request_data_items,
+				 int num_reply_data_items)
 {
 	struct ceph_osd_client *osdc = req->r_osdc;
 	struct ceph_msg *msg;
@@ -672,6 +672,7 @@ static int __ceph_osdc_alloc_messages(struct ceph_osd_request *req, gfp_t gfp,
 
 	return 0;
 }
+EXPORT_SYMBOL(ceph_osdc_alloc_num_messages);
 
 static bool osd_req_opcode_valid(u16 opcode)
 {
@@ -738,8 +739,8 @@ int ceph_osdc_alloc_messages(struct ceph_osd_request *req, gfp_t gfp)
 	int num_request_data_items, num_reply_data_items;
 
 	get_num_data_items(req, &num_request_data_items, &num_reply_data_items);
-	return __ceph_osdc_alloc_messages(req, gfp, num_request_data_items,
-					  num_reply_data_items);
+	return ceph_osdc_alloc_num_messages(req, gfp, num_request_data_items,
+						  num_reply_data_items);
 }
 EXPORT_SYMBOL(ceph_osdc_alloc_messages);
 
@@ -1129,7 +1130,7 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 		 * also covers ceph_uninline_data().  If more multi-op request
 		 * use cases emerge, we will need a separate helper.
 		 */
-		r = __ceph_osdc_alloc_messages(req, GFP_NOFS, num_ops, 0);
+		r = ceph_osdc_alloc_num_messages(req, GFP_NOFS, num_ops, 0);
 	else
 		r = ceph_osdc_alloc_messages(req, GFP_NOFS);
 	if (r)
-- 
2.26.2
