From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/8] rbd: remove options args from rbd_add_parse_args()
Date: Fri, 26 Oct 2012 18:00:58 -0500
Message-ID: <508B162A.6020008@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41745 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934127Ab2JZXBI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 19:01:08 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4483910iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 16:01:07 -0700 (PDT)
In-Reply-To: <508B1505.20209@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

They "options" argument to rbd_add_parse_args() (and it's partner
options_size) is now only needed within the function, so there's no
need to have the caller allocate and pass the options buffer.  Just
allocate the options buffer within the function using dup_token().

Also distinguish between failures due to failed memory allocation
and failing because a required argument was missing.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   58
+++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cae7423..f900f3b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2844,54 +2844,58 @@ static inline char *dup_token(const char **buf,
size_t *lenp)
  */
 static struct ceph_options *rbd_add_parse_args(struct rbd_device *rbd_dev,
 						const char *buf,
-						char *options,
-						size_t options_size,
 						char **snap_name)
 {
 	size_t len;
 	const char *mon_addrs;
 	size_t mon_addrs_size;
+	char *options;
+	struct ceph_options *err_ptr = ERR_PTR(-EINVAL);
 	struct rbd_options rbd_opts;
 	struct ceph_options *ceph_opts;
-	struct ceph_options *err_ptr = ERR_PTR(-EINVAL);

 	/* The first four tokens are required */

 	len = next_token(&buf);
 	if (!len)
-		return err_ptr;
-	mon_addrs_size = len + 1;
+		return err_ptr;	/* Missing monitor address(es) */
 	mon_addrs = buf;
-
+	mon_addrs_size = len + 1;
 	buf += len;

-	len = copy_token(&buf, options, options_size);
-	if (!len || len >= options_size)
-		return err_ptr;
+	options = dup_token(&buf, NULL);
+	if (!options)
+		goto out_mem;
+	if (!*options)
+		goto out_err;	/* Missing options */

-	err_ptr = ERR_PTR(-ENOMEM);
 	rbd_dev->pool_name = dup_token(&buf, NULL);
 	if (!rbd_dev->pool_name)
-		goto out_err;
+		goto out_mem;
+	if (!*rbd_dev->pool_name)
+		goto out_err;	/* Missing pool name */

 	rbd_dev->image_name = dup_token(&buf, &rbd_dev->image_name_len);
 	if (!rbd_dev->image_name)
-		goto out_err;
-
-	/* Snapshot name is optional; default is to use "head" */
+		goto out_mem;
+	if (!*rbd_dev->image_name)
+		goto out_err;	/* Missing image name */

+	/*
+	 * Snapshot name is optional; default is to use "-"
+	 * (indicating the head/no snapshot).
+	 */
 	len = next_token(&buf);
-	if (len > RBD_MAX_SNAP_NAME_LEN) {
-		err_ptr = ERR_PTR(-ENAMETOOLONG);
-		goto out_err;
-	}
 	if (!len) {
 		buf = RBD_SNAP_HEAD_NAME; /* No snapshot supplied */
 		len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
+	} else if (len > RBD_MAX_SNAP_NAME_LEN) {
+		err_ptr = ERR_PTR(-ENAMETOOLONG);
+		goto out_err;
 	}
 	*snap_name = kmalloc(len + 1, GFP_KERNEL);
 	if (!*snap_name)
-		goto out_err;
+		goto out_mem;
 	memcpy(*snap_name, buf, len);
 	*(*snap_name + len) = '\0';

@@ -2902,20 +2906,23 @@ static struct ceph_options
*rbd_add_parse_args(struct rbd_device *rbd_dev,
 	ceph_opts = ceph_parse_options(options, mon_addrs,
 					mon_addrs + mon_addrs_size - 1,
 					parse_rbd_opts_token, &rbd_opts);
+	kfree(options);

 	/* Record the parsed rbd options */

-	if (!IS_ERR(ceph_opts)) {
+	if (!IS_ERR(ceph_opts))
 		rbd_dev->mapping.read_only = rbd_opts.read_only;
-	}

 	return ceph_opts;
+out_mem:
+	err_ptr = ERR_PTR(-ENOMEM);
 out_err:
 	kfree(rbd_dev->image_name);
 	rbd_dev->image_name = NULL;
 	rbd_dev->image_name_len = 0;
 	kfree(rbd_dev->pool_name);
 	rbd_dev->pool_name = NULL;
+	kfree(options);

 	return err_ptr;
 }
@@ -3124,7 +3131,6 @@ static ssize_t rbd_add(struct bus_type *bus,
 		       const char *buf,
 		       size_t count)
 {
-	char *options;
 	struct rbd_device *rbd_dev = NULL;
 	char *snap_name;
 	struct ceph_options *ceph_opts;
@@ -3134,9 +3140,6 @@ static ssize_t rbd_add(struct bus_type *bus,
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;

-	options = kmalloc(count, GFP_KERNEL);
-	if (!options)
-		goto err_out_mem;
 	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
 	if (!rbd_dev)
 		goto err_out_mem;
@@ -3148,8 +3151,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 	init_rwsem(&rbd_dev->header_rwsem);

 	/* parse add command */
-	ceph_opts = rbd_add_parse_args(rbd_dev, buf, options, count,
-				&snap_name);
+	ceph_opts = rbd_add_parse_args(rbd_dev, buf, &snap_name);
 	if (IS_ERR(ceph_opts)) {
 		rc = PTR_ERR(ceph_opts);
 		goto err_out_mem;
@@ -3233,7 +3235,6 @@ err_out_bus:
 	/* this will also clean up rest of rbd_dev stuff */

 	rbd_bus_del_dev(rbd_dev);
-	kfree(options);
 	return rc;

 err_out_disk:
@@ -3258,7 +3259,6 @@ err_out_args:
 	kfree(rbd_dev->pool_name);
 err_out_mem:
 	kfree(rbd_dev);
-	kfree(options);

 	dout("Error adding device %s\n", buf);
 	module_put(THIS_MODULE);
-- 
1.7.9.5

