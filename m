From: Alex Elder <elder@inktank.com>
Subject: [PATCH 10/16] rbd: dynamically allocate image name
Date: Wed, 11 Jul 2012 09:02:17 -0500
Message-ID: <4FFD8769.90501@inktank.com>
References: <4FFD847C.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48415 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605Ab2GKOCU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 10:02:20 -0400
Received: by yenl2 with SMTP id l2so1226905yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 07:02:20 -0700 (PDT)
In-Reply-To: <4FFD847C.7070205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is no need to impose a small limit the length of the rbd image
name recorded in a struct rbd_dev.  Remove the limitation by
allocating space for the image name dynamically.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c       |   34 ++++++++++++++++++----------------
 drivers/block/rbd_types.h |    1 -
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4d11337..28afff9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -161,8 +161,8 @@ struct rbd_device {
 	spinlock_t		lock;		/* queue lock */

 	struct rbd_image_header	header;
-	char			obj[RBD_MAX_OBJ_NAME_LEN]; /* rbd image name */
-	int			obj_len;
+	char			*obj; /* rbd image name */
+	size_t			obj_len;
 	char			*obj_md_name; /* hdr nm. */
 	int			pool_id;

@@ -2333,6 +2333,8 @@ static inline char *dup_token(const char **buf,
size_t *lenp)
  * Returns a pointer to a dynamically-allocated buffer containing
  * the pool name provided, or a pointer-coded errno if an error
  * occurs.
+ *
+ * Note: rbd_dev is assumed to have been initially zero-filled.
  */
 static char *rbd_add_parse_args(struct rbd_device *rbd_dev,
 			      const char *buf,
@@ -2360,27 +2362,22 @@ static char *rbd_add_parse_args(struct
rbd_device *rbd_dev,
 	if (!len || len >= options_size)
 		goto out_err;

+	ret = -ENOMEM;
 	pool_name = dup_token(&buf, NULL);
-	if (!pool_name) {
-		ret = -ENOMEM;
+	if (!pool_name)
 		goto out_err;
-	}

-	len = copy_token(&buf, rbd_dev->obj, sizeof (rbd_dev->obj));
-	if (!len || len >= sizeof (rbd_dev->obj))
+	rbd_dev->obj = dup_token(&buf, &rbd_dev->obj_len);
+	if (!rbd_dev->obj)
 		goto out_err;

-	/* We have the object length in hand, save it. */
-
-	rbd_dev->obj_len = len;
-
 	/* Create the name of the header object */

-	rbd_dev->obj_md_name = kmalloc(len + sizeof (RBD_SUFFIX), GFP_KERNEL);
-	if (!rbd_dev->obj_md_name) {
-		ret = -ENOMEM;
+	rbd_dev->obj_md_name = kmalloc(rbd_dev->obj_len
+						+ sizeof (RBD_SUFFIX),
+					GFP_KERNEL);
+	if (!rbd_dev->obj_md_name)
 		goto out_err;
-	}
 	sprintf(rbd_dev->obj_md_name, "%s%s", rbd_dev->obj, RBD_SUFFIX);

 	/*
@@ -2391,13 +2388,16 @@ static char *rbd_add_parse_args(struct
rbd_device *rbd_dev,
 	if (!len)
 		memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
 			sizeof (RBD_SNAP_HEAD_NAME));
-	else if (len >= sizeof (rbd_dev->snap_name))
+	else if (len >= sizeof (rbd_dev->snap_name)) {
+		ret = -EINVAL;
 		goto out_err;
+	}

 	return pool_name;

 out_err:
 	kfree(rbd_dev->obj_md_name);
+	kfree(rbd_dev->obj);
 	kfree(pool_name);

 	return ERR_PTR(ret);
@@ -2506,6 +2506,7 @@ err_out_client:
 err_put_id:
 	if (pool_name) {
 		kfree(rbd_dev->obj_md_name);
+		kfree(rbd_dev->obj);
 		kfree(pool_name);
 	}
 	rbd_id_put(rbd_dev);
@@ -2557,6 +2558,7 @@ static void rbd_dev_release(struct device *dev)

 	/* done with the id, and with the rbd_dev */
 	kfree(rbd_dev->obj_md_name);
+	kfree(rbd_dev->obj);
 	rbd_id_put(rbd_dev);
 	kfree(rbd_dev);

diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
index 9507086..0924e9e 100644
--- a/drivers/block/rbd_types.h
+++ b/drivers/block/rbd_types.h
@@ -31,7 +31,6 @@
 #define RBD_MIN_OBJ_ORDER       16
 #define RBD_MAX_OBJ_ORDER       30

-#define RBD_MAX_OBJ_NAME_LEN	96
 #define RBD_MAX_SEG_NAME_LEN	128

 #define RBD_COMP_NONE		0
-- 
1.7.5.4

