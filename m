From: Alex Elder <elder@inktank.com>
Subject: [PATCH 14/16] rbd: more symbol renames
Date: Wed, 11 Jul 2012 09:02:55 -0500
Message-ID: <4FFD878F.5030905@inktank.com>
References: <4FFD847C.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f52.google.com ([209.85.213.52]:50862 "EHLO
	mail-yw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932521Ab2GKOC5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 10:02:57 -0400
Received: by mail-yw0-f52.google.com with SMTP id p61so1430101yhp.11
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 07:02:57 -0700 (PDT)
In-Reply-To: <4FFD847C.7070205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Rename variables named "obj" which represent object names so they're
consistenly named "object_name".

Rename the "cls" and "method" parameters in rbd_req_sync_exec()
to be "class_name" and "method_name", and make similar changes
to the names of local variables in that function representing
the lengths of those names.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   53
++++++++++++++++++++++++++-------------------------
 1 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 14e675c..d29c864 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -857,7 +857,7 @@ static int rbd_do_request(struct request *rq,
 			  struct rbd_device *rbd_dev,
 			  struct ceph_snap_context *snapc,
 			  u64 snapid,
-			  const char *obj, u64 ofs, u64 len,
+			  const char *object_name, u64 ofs, u64 len,
 			  struct bio *bio,
 			  struct page **pages,
 			  int num_pages,
@@ -893,7 +893,8 @@ static int rbd_do_request(struct request *rq,
 		req_data->coll_index = coll_index;
 	}

-	dout("rbd_do_request obj=%s ofs=%lld len=%lld\n", obj, len, ofs);
+	dout("rbd_do_request object_name=%s ofs=%lld len=%lld\n",
+		object_name, len, ofs);

 	down_read(&rbd_dev->header_rwsem);

@@ -918,7 +919,7 @@ static int rbd_do_request(struct request *rq,
 	reqhead = req->r_request->front.iov_base;
 	reqhead->snapid = cpu_to_le64(CEPH_NOSNAP);

-	strncpy(req->r_oid, obj, sizeof(req->r_oid));
+	strncpy(req->r_oid, object_name, sizeof(req->r_oid));
 	req->r_oid_len = strlen(req->r_oid);

 	layout = &req->r_file_layout;
@@ -1019,7 +1020,7 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 			   int flags,
 			   struct ceph_osd_req_op *orig_ops,
 			   int num_reply,
-			   const char *obj,
+			   const char *object_name,
 			   u64 ofs, u64 len,
 			   char *buf,
 			   struct ceph_osd_request **linger_req,
@@ -1050,7 +1051,7 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 	}

 	ret = rbd_do_request(NULL, rbd_dev, snapc, snapid,
-			  obj, ofs, len, NULL,
+			  object_name, ofs, len, NULL,
 			  pages, num_pages,
 			  flags,
 			  ops,
@@ -1171,7 +1172,7 @@ static int rbd_req_read(struct request *rq,
 static int rbd_req_sync_read(struct rbd_device *rbd_dev,
 			  struct ceph_snap_context *snapc,
 			  u64 snapid,
-			  const char *obj,
+			  const char *object_name,
 			  u64 ofs, u64 len,
 			  char *buf,
 			  u64 *ver)
@@ -1181,7 +1182,7 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 			       CEPH_OSD_OP_READ,
 			       CEPH_OSD_FLAG_READ,
 			       NULL,
-			       1, obj, ofs, len, buf, NULL, ver);
+			       1, object_name, ofs, len, buf, NULL, ver);
 }

 /*
@@ -1190,7 +1191,7 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 static int rbd_req_sync_notify_ack(struct rbd_device *rbd_dev,
 				   u64 ver,
 				   u64 notify_id,
-				   const char *obj)
+				   const char *object_name)
 {
 	struct ceph_osd_req_op *ops;
 	int ret;
@@ -1204,7 +1205,7 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 	ops[0].watch.flag = 0;

 	ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
-			  obj, 0, 0, NULL,
+			  object_name, 0, 0, NULL,
 			  NULL, 0,
 			  CEPH_OSD_FLAG_READ,
 			  ops,
@@ -1240,7 +1241,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
  * Request sync osd watch
  */
 static int rbd_req_sync_watch(struct rbd_device *rbd_dev,
-			      const char *obj,
+			      const char *object_name,
 			      u64 ver)
 {
 	struct ceph_osd_req_op *ops;
@@ -1264,7 +1265,7 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev,
 			      0,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			      ops,
-			      1, obj, 0, 0, NULL,
+			      1, object_name, 0, 0, NULL,
 			      &rbd_dev->watch_request, NULL);

 	if (ret < 0)
@@ -1285,7 +1286,7 @@ fail:
  * Request sync osd unwatch
  */
 static int rbd_req_sync_unwatch(struct rbd_device *rbd_dev,
-				const char *obj)
+				const char *object_name)
 {
 	struct ceph_osd_req_op *ops;

@@ -1302,7 +1303,7 @@ static int rbd_req_sync_unwatch(struct rbd_device
*rbd_dev,
 			      0,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			      ops,
-			      1, obj, 0, 0, NULL, NULL, NULL);
+			      1, object_name, 0, 0, NULL, NULL, NULL);

 	rbd_destroy_ops(ops);
 	ceph_osdc_cancel_event(rbd_dev->watch_event);
@@ -1329,7 +1330,7 @@ static void rbd_notify_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
  * Request sync osd notify
  */
 static int rbd_req_sync_notify(struct rbd_device *rbd_dev,
-		          const char *obj)
+		          const char *object_name)
 {
 	struct ceph_osd_req_op *ops;
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
@@ -1360,7 +1361,7 @@ static int rbd_req_sync_notify(struct rbd_device
*rbd_dev,
 			       0,
 			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			       ops,
-			       1, obj, 0, 0, NULL, NULL, NULL);
+			       1, object_name, 0, 0, NULL, NULL, NULL);
 	if (ret < 0)
 		goto fail_event;

@@ -1380,25 +1381,25 @@ fail:
  * Request sync osd read
  */
 static int rbd_req_sync_exec(struct rbd_device *rbd_dev,
-			     const char *obj,
-			     const char *cls,
-			     const char *method,
+			     const char *object_name,
+			     const char *class_name,
+			     const char *method_name,
 			     const char *data,
 			     int len,
 			     u64 *ver)
 {
 	struct ceph_osd_req_op *ops;
-	int cls_len = strlen(cls);
-	int method_len = strlen(method);
+	int class_name_len = strlen(class_name);
+	int method_name_len = strlen(method_name);
 	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_CALL,
-				    cls_len + method_len + len);
+				    class_name_len + method_name_len + len);
 	if (ret < 0)
 		return ret;

-	ops[0].cls.class_name = cls;
-	ops[0].cls.class_len = (__u8)cls_len;
-	ops[0].cls.method_name = method;
-	ops[0].cls.method_len = (__u8)method_len;
+	ops[0].cls.class_name = class_name;
+	ops[0].cls.class_len = (__u8) class_name_len;
+	ops[0].cls.method_name = method_name;
+	ops[0].cls.method_len = (__u8) method_name_len;
 	ops[0].cls.argc = 0;
 	ops[0].cls.indata = data;
 	ops[0].cls.indata_len = len;
@@ -1408,7 +1409,7 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 			       0,
 			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			       ops,
-			       1, obj, 0, 0, NULL, NULL, ver);
+			       1, object_name, 0, 0, NULL, NULL, ver);

 	rbd_destroy_ops(ops);

-- 
1.7.5.4

