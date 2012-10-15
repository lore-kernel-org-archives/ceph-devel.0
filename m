From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: kill rbd_device->rbd_opts
Date: Mon, 15 Oct 2012 09:18:27 -0500
Message-ID: <507C1B33.5080006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52676 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab2JOOSa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 10:18:30 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so7842200iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 07:18:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The rbd_device structure has an embedded rbd_options structure.
Such a structure is needed to work with the generic ceph argument
parsing code, but there's no need to keep it around once argument
parsing is done.

Use a local variable to hold the rbd options used in parsing in
rbd_get_client(), and just transfer its content (it's just a
read_only flag) into the field in the rbd_mapping sub-structure
that requires that information.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -181,7 +181,6 @@ struct rbd_device {
 	struct gendisk		*disk;		/* blkdev's gendisk and rq */

 	u32			image_format;	/* Either 1 or 2 */
-	struct rbd_options	rbd_opts;
 	struct rbd_client	*rbd_client;

 	char			name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
@@ -453,18 +452,24 @@ static int parse_rbd_opts_token(char *c,
 static int rbd_get_client(struct rbd_device *rbd_dev, const char *mon_addr,
 				size_t mon_addr_len, char *options)
 {
-	struct rbd_options *rbd_opts = &rbd_dev->rbd_opts;
+	struct rbd_options rbd_opts;
 	struct ceph_options *ceph_opts;
 	struct rbd_client *rbdc;

-	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
+	/* Initialize all rbd options to the defaults */
+
+	rbd_opts.read_only = RBD_READ_ONLY_DEFAULT;

 	ceph_opts = ceph_parse_options(options, mon_addr,
 					mon_addr + mon_addr_len,
-					parse_rbd_opts_token, rbd_opts);
+					parse_rbd_opts_token, &rbd_opts);
 	if (IS_ERR(ceph_opts))
 		return PTR_ERR(ceph_opts);

+	/* Record the parsed rbd options */
+
+	rbd_dev->mapping.read_only = rbd_opts.read_only;
+
 	rbdc = rbd_client_find(ceph_opts);
 	if (rbdc) {
 		/* using an existing client */
@@ -672,7 +677,6 @@ static int rbd_dev_set_mapping(struct rb
 		rbd_dev->mapping.size = rbd_dev->header.image_size;
 		rbd_dev->mapping.features = rbd_dev->header.features;
 		rbd_dev->mapping.snap_exists = false;
-		rbd_dev->mapping.read_only = rbd_dev->rbd_opts.read_only;
 		ret = 0;
 	} else {
 		ret = snap_by_name(rbd_dev, snap_name);
