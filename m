From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] rbd: do all argument parsing in one place
Date: Fri, 26 Oct 2012 17:55:52 -0500
Message-ID: <508B14F8.6080905@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B142D.7080907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49629 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934127Ab2JZWz7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:55:59 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4479692iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:55:59 -0700 (PDT)
In-Reply-To: <508B142D.7080907@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch makes rbd_add_parse_args() be the single place all
argument parsing occurs for an image map request:
    - Move the ceph_parse_options() call into that function
    - Use local variables rather than parameters to hold the list
      of monitor addresses supplied
    - Rather than returning it, pass the snapshot name (and its
      length) back via parameters
    - Have the function return a ceph_options structure pointer

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   77
+++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6e36c63..4fe14ff 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2845,24 +2845,27 @@ static inline char *dup_token(const char **buf,
size_t *lenp)
  *
  * Note: rbd_dev is assumed to have been initially zero-filled.
  */
-static char *rbd_add_parse_args(struct rbd_device *rbd_dev,
-				const char *buf,
-				const char **mon_addrs,
-				size_t *mon_addrs_size,
-				char *options,
-				size_t options_size)
+static struct ceph_options *rbd_add_parse_args(struct rbd_device *rbd_dev,
+						const char *buf,
+						char *options,
+						size_t options_size,
+						char **snap_name,
+						size_t *snap_name_len)
 {
 	size_t len;
-	char *err_ptr = ERR_PTR(-EINVAL);
-	char *snap_name;
+	const char *mon_addrs;
+	size_t mon_addrs_size;
+	struct rbd_options rbd_opts;
+	struct ceph_options *ceph_opts;
+	struct ceph_options *err_ptr = ERR_PTR(-EINVAL);

 	/* The first four tokens are required */

 	len = next_token(&buf);
 	if (!len)
 		return err_ptr;
-	*mon_addrs_size = len + 1;
-	*mon_addrs = buf;
+	mon_addrs_size = len + 1;
+	mon_addrs = buf;

 	buf += len;

@@ -2890,14 +2893,27 @@ static char *rbd_add_parse_args(struct
rbd_device *rbd_dev,
 		buf = RBD_SNAP_HEAD_NAME; /* No snapshot supplied */
 		len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
 	}
-	snap_name = kmalloc(len + 1, GFP_KERNEL);
-	if (!snap_name)
+	*snap_name = kmalloc(len + 1, GFP_KERNEL);
+	if (!*snap_name)
 		goto out_err;
-	memcpy(snap_name, buf, len);
-	*(snap_name + len) = '\0';
+	memcpy(*snap_name, buf, len);
+	*(*snap_name + len) = '\0';
+	*snap_name_len = len;
+	/* Initialize all rbd options to the defaults */

-	return snap_name;
+	rbd_opts.read_only = RBD_READ_ONLY_DEFAULT;

+	ceph_opts = ceph_parse_options(options, mon_addrs,
+					mon_addrs + mon_addrs_size - 1,
+					parse_rbd_opts_token, &rbd_opts);
+
+	/* Record the parsed rbd options */
+
+	if (!IS_ERR(ceph_opts)) {
+		rbd_dev->mapping.read_only = rbd_opts.read_only;
+	}
+
+	return ceph_opts;
 out_err:
 	kfree(rbd_dev->image_name);
 	rbd_dev->image_name = NULL;
@@ -3114,10 +3130,8 @@ static ssize_t rbd_add(struct bus_type *bus,
 {
 	char *options;
 	struct rbd_device *rbd_dev = NULL;
-	const char *mon_addrs = NULL;
-	size_t mon_addrs_size = 0;
 	char *snap_name;
-	struct rbd_options rbd_opts;
+	size_t snap_name_len = 0;
 	struct ceph_options *ceph_opts;
 	struct ceph_osd_client *osdc;
 	int rc = -ENOMEM;
@@ -3139,32 +3153,16 @@ static ssize_t rbd_add(struct bus_type *bus,
 	init_rwsem(&rbd_dev->header_rwsem);

 	/* parse add command */
-	snap_name = rbd_add_parse_args(rbd_dev, buf,
-				&mon_addrs, &mon_addrs_size, options, count);
-	if (IS_ERR(snap_name)) {
-		rc = PTR_ERR(snap_name);
-		goto err_out_mem;
-	}
-
-	/* Initialize all rbd options to the defaults */
-
-	rbd_opts.read_only = RBD_READ_ONLY_DEFAULT;
-
-	ceph_opts = ceph_parse_options(options, mon_addrs,
-					mon_addrs + mon_addrs_size - 1,
-					parse_rbd_opts_token, &rbd_opts);
+	ceph_opts = rbd_add_parse_args(rbd_dev, buf, options, count,
+				&snap_name, &snap_name_len);
 	if (IS_ERR(ceph_opts)) {
 		rc = PTR_ERR(ceph_opts);
-		goto err_out_args;
+		goto err_out_mem;
 	}

-	/* Record the parsed rbd options */
-
-	rbd_dev->mapping.read_only = rbd_opts.read_only;
-
 	rc = rbd_get_client(rbd_dev, ceph_opts);
 	if (rc < 0)
-		goto err_out_opts;
+		goto err_out_args;
 	ceph_opts = NULL;	/* ceph_opts now owned by rbd_dev client */

 	/* pick the pool */
@@ -3257,10 +3255,9 @@ err_out_client:
 	kfree(rbd_dev->header_name);
 	rbd_put_client(rbd_dev);
 	kfree(rbd_dev->image_id);
-err_out_opts:
+err_out_args:
 	if (ceph_opts)
 		ceph_destroy_options(ceph_opts);
-err_out_args:
 	kfree(rbd_dev->snap_name);
 	kfree(rbd_dev->image_name);
 	kfree(rbd_dev->pool_name);
-- 
1.7.9.5

