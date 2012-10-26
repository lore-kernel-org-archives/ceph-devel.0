From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/8] rbd: pass and populate rbd_options structure
Date: Fri, 26 Oct 2012 18:02:16 -0500
Message-ID: <508B1678.5030704@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:35335 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934218Ab2JZXCW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 19:02:22 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2578867iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 16:02:22 -0700 (PDT)
In-Reply-To: <508B1505.20209@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Have the caller pass the address of an rbd_options structure to
rbd_add_parse_args(), to be initialized with the information
gleaned as a result of the parse.

I know, this is another near-reversal of a recent change...

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 948a084..392dded 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2842,15 +2842,16 @@ static inline char *dup_token(const char **buf,
size_t *lenp)
  * Note: rbd_dev is assumed to have been initially zero-filled.
  */
 static struct ceph_options *rbd_add_parse_args(struct rbd_device *rbd_dev,
-						const char *buf)
+						const char *buf,
+						struct rbd_options **opts)
 {
 	size_t len;
 	const char *mon_addrs;
 	size_t mon_addrs_size;
 	char *options;
 	struct ceph_options *err_ptr = ERR_PTR(-EINVAL);
-	struct rbd_options rbd_opts;
 	struct ceph_options *ceph_opts;
+	struct rbd_options *rbd_opts = NULL;

 	/* The first four tokens are required */

@@ -2899,17 +2900,17 @@ static struct ceph_options
*rbd_add_parse_args(struct rbd_device *rbd_dev,

 	/* Initialize all rbd options to the defaults */

-	rbd_opts.read_only = RBD_READ_ONLY_DEFAULT;
+	rbd_opts = kzalloc(sizeof (*rbd_opts), GFP_KERNEL);
+	if (!rbd_opts)
+		goto out_mem;
+
+	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;

 	ceph_opts = ceph_parse_options(options, mon_addrs,
 					mon_addrs + mon_addrs_size - 1,
-					parse_rbd_opts_token, &rbd_opts);
+					parse_rbd_opts_token, rbd_opts);
 	kfree(options);
-
-	/* Record the parsed rbd options */
-
-	if (!IS_ERR(ceph_opts))
-		rbd_dev->mapping.read_only = rbd_opts.read_only;
+	*opts = rbd_opts;

 	return ceph_opts;
 out_mem:
@@ -3131,6 +3132,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 {
 	struct rbd_device *rbd_dev = NULL;
 	struct ceph_options *ceph_opts;
+	struct rbd_options *rbd_opts = NULL;
 	struct ceph_osd_client *osdc;
 	int rc = -ENOMEM;

@@ -3139,7 +3141,7 @@ static ssize_t rbd_add(struct bus_type *bus,

 	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
 	if (!rbd_dev)
-		goto err_out_mem;
+		return -ENOMEM;

 	/* static rbd_device initialization */
 	spin_lock_init(&rbd_dev->lock);
@@ -3148,11 +3150,12 @@ static ssize_t rbd_add(struct bus_type *bus,
 	init_rwsem(&rbd_dev->header_rwsem);

 	/* parse add command */
-	ceph_opts = rbd_add_parse_args(rbd_dev, buf);
+	ceph_opts = rbd_add_parse_args(rbd_dev, buf, &rbd_opts);
 	if (IS_ERR(ceph_opts)) {
 		rc = PTR_ERR(ceph_opts);
 		goto err_out_mem;
 	}
+	rbd_dev->mapping.read_only = rbd_opts->read_only;

 	rc = rbd_get_client(rbd_dev, ceph_opts);
 	if (rc < 0)
@@ -3219,6 +3222,8 @@ static ssize_t rbd_add(struct bus_type *bus,
 	if (rc)
 		goto err_out_bus;

+	kfree(rbd_opts);
+
 	/* Everything's ready.  Announce the disk to the world. */

 	add_disk(rbd_dev->disk);
@@ -3232,6 +3237,8 @@ err_out_bus:
 	/* this will also clean up rest of rbd_dev stuff */

 	rbd_bus_del_dev(rbd_dev);
+	kfree(rbd_opts);
+
 	return rc;

 err_out_disk:
@@ -3254,6 +3261,7 @@ err_out_args:
 	kfree(rbd_dev->snap_name);
 	kfree(rbd_dev->image_name);
 	kfree(rbd_dev->pool_name);
+	kfree(rbd_opts);
 err_out_mem:
 	kfree(rbd_dev);

-- 
1.7.9.5

