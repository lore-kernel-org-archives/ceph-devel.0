From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/8] rbd: have rbd_add_parse_args() return error
Date: Fri, 26 Oct 2012 18:02:45 -0500
Message-ID: <508B1695.50201@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58003 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934218Ab2JZXCv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 19:02:51 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4485297iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 16:02:50 -0700 (PDT)
In-Reply-To: <508B1505.20209@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change the interface to rbd_add_parse_args() so it returns an
error code rather than a pointer.  Return the ceph_options result
via a pointer whose address is passed as an argument.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 392dded..388dd47 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2841,30 +2841,31 @@ static inline char *dup_token(const char **buf,
size_t *lenp)
  *
  * Note: rbd_dev is assumed to have been initially zero-filled.
  */
-static struct ceph_options *rbd_add_parse_args(struct rbd_device *rbd_dev,
-						const char *buf,
-						struct rbd_options **opts)
+static int rbd_add_parse_args(struct rbd_device *rbd_dev,
+				const char *buf,
+				struct ceph_options **ceph_opts,
+				struct rbd_options **opts)
 {
 	size_t len;
 	const char *mon_addrs;
 	size_t mon_addrs_size;
 	char *options;
-	struct ceph_options *err_ptr = ERR_PTR(-EINVAL);
-	struct ceph_options *ceph_opts;
 	struct rbd_options *rbd_opts = NULL;
+	int ret;

 	/* The first four tokens are required */

 	len = next_token(&buf);
 	if (!len)
-		return err_ptr;	/* Missing monitor address(es) */
+		return -EINVAL;	/* Missing monitor address(es) */
 	mon_addrs = buf;
 	mon_addrs_size = len + 1;
 	buf += len;

+	ret = -EINVAL;
 	options = dup_token(&buf, NULL);
 	if (!options)
-		goto out_mem;
+		return -ENOMEM;
 	if (!*options)
 		goto out_err;	/* Missing options */

@@ -2889,7 +2890,7 @@ static struct ceph_options
*rbd_add_parse_args(struct rbd_device *rbd_dev,
 		buf = RBD_SNAP_HEAD_NAME; /* No snapshot supplied */
 		len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
 	} else if (len > RBD_MAX_SNAP_NAME_LEN) {
-		err_ptr = ERR_PTR(-ENAMETOOLONG);
+		ret = -ENAMETOOLONG;
 		goto out_err;
 	}
 	rbd_dev->snap_name = kmalloc(len + 1, GFP_KERNEL);
@@ -2906,15 +2907,19 @@ static struct ceph_options
*rbd_add_parse_args(struct rbd_device *rbd_dev,

 	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;

-	ceph_opts = ceph_parse_options(options, mon_addrs,
+	*ceph_opts = ceph_parse_options(options, mon_addrs,
 					mon_addrs + mon_addrs_size - 1,
 					parse_rbd_opts_token, rbd_opts);
 	kfree(options);
+	if (IS_ERR(*ceph_opts)) {
+		ret = PTR_ERR(*ceph_opts);
+		goto out_err;
+	}
 	*opts = rbd_opts;

-	return ceph_opts;
+	return 0;
 out_mem:
-	err_ptr = ERR_PTR(-ENOMEM);
+	ret = -ENOMEM;
 out_err:
 	kfree(rbd_dev->image_name);
 	rbd_dev->image_name = NULL;
@@ -2923,7 +2928,7 @@ out_err:
 	rbd_dev->pool_name = NULL;
 	kfree(options);

-	return err_ptr;
+	return ret;
 }

 /*
@@ -3131,7 +3136,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 		       size_t count)
 {
 	struct rbd_device *rbd_dev = NULL;
-	struct ceph_options *ceph_opts;
+	struct ceph_options *ceph_opts = NULL;
 	struct rbd_options *rbd_opts = NULL;
 	struct ceph_osd_client *osdc;
 	int rc = -ENOMEM;
@@ -3150,11 +3155,9 @@ static ssize_t rbd_add(struct bus_type *bus,
 	init_rwsem(&rbd_dev->header_rwsem);

 	/* parse add command */
-	ceph_opts = rbd_add_parse_args(rbd_dev, buf, &rbd_opts);
-	if (IS_ERR(ceph_opts)) {
-		rc = PTR_ERR(ceph_opts);
+	rc = rbd_add_parse_args(rbd_dev, buf, &ceph_opts, &rbd_opts);
+	if (rc < 0)
 		goto err_out_mem;
-	}
 	rbd_dev->mapping.read_only = rbd_opts->read_only;

 	rc = rbd_get_client(rbd_dev, ceph_opts);
-- 
1.7.9.5

