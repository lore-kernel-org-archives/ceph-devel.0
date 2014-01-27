From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 03/11] libceph: rename MAX_OBJ_NAME_SIZE to CEPH_MAX_OID_NAME_LEN
Date: Mon, 27 Jan 2014 17:58:45 +0200
Message-ID: <1390838333-32266-4-git-send-email-ilya.dryomov@inktank.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:39170 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaA0QAA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 11:00:00 -0500
Received: by mail-lb0-f178.google.com with SMTP id u14so4667856lbd.9
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 07:59:58 -0800 (PST)
In-Reply-To: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

In preparation for adding oid abstraction, rename MAX_OBJ_NAME_SIZE to
CEPH_MAX_OID_NAME_LEN.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c             |    6 +++---
 include/linux/ceph/osd_client.h |    4 ++--
 net/ceph/osd_client.c           |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6614e8d95525..98792b2a7f65 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1088,9 +1088,9 @@ static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
 	name_format = "%s.%012llx";
 	if (rbd_dev->image_format == 2)
 		name_format = "%s.%016llx";
-	ret = snprintf(name, MAX_OBJ_NAME_SIZE + 1, name_format,
+	ret = snprintf(name, CEPH_MAX_OID_NAME_LEN + 1, name_format,
 			rbd_dev->header.object_prefix, segment);
-	if (ret < 0 || ret > MAX_OBJ_NAME_SIZE) {
+	if (ret < 0 || ret > CEPH_MAX_OID_NAME_LEN) {
 		pr_err("error formatting segment name for #%llu (%d)\n",
 			segment, ret);
 		kfree(name);
@@ -5350,7 +5350,7 @@ static int rbd_slab_init(void)
 
 	rbd_assert(!rbd_segment_name_cache);
 	rbd_segment_name_cache = kmem_cache_create("rbd_segment_name",
-					MAX_OBJ_NAME_SIZE + 1, 1, 0, NULL);
+					CEPH_MAX_OID_NAME_LEN + 1, 1, 0, NULL);
 	if (rbd_segment_name_cache)
 		return 0;
 out_err:
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 5b8555109789..b42f15848cae 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -16,7 +16,7 @@
  * Maximum object name size 
  * (must be at least as big as RBD_MAX_MD_NAME_LEN -- currently 100) 
  */
-#define MAX_OBJ_NAME_SIZE 100
+#define CEPH_MAX_OID_NAME_LEN 100
 
 struct ceph_msg;
 struct ceph_snap_context;
@@ -161,7 +161,7 @@ struct ceph_osd_request {
 
 	struct ceph_object_locator r_oloc;
 
-	char              r_oid[MAX_OBJ_NAME_SIZE];          /* object name */
+	char              r_oid[CEPH_MAX_OID_NAME_LEN];      /* object name */
 	int               r_oid_len;
 	u64               r_snapid;
 	unsigned long     r_stamp;            /* send OR check time */
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7130c5c83d79..a053e7e4a780 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -338,7 +338,7 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	msg_size = 4 + 4 + 8 + 8 + 4+8;
 	msg_size += 2 + 4 + 8 + 4 + 4; /* oloc */
 	msg_size += 1 + 8 + 4 + 4;     /* pg_t */
-	msg_size += 4 + MAX_OBJ_NAME_SIZE;
+	msg_size += 4 + CEPH_MAX_OID_NAME_LEN; /* oid */
 	msg_size += 2 + num_ops*sizeof(struct ceph_osd_op);
 	msg_size += 8;  /* snapid */
 	msg_size += 8;  /* snap_seq */
-- 
1.7.10.4

