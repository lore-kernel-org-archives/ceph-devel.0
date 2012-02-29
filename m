From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 5/5] rbd: don't allocate mon_addrs buffer in rbd_add()
Date: Tue, 28 Feb 2012 19:59:20 -0800
Message-ID: <4F4DA298.7000400@dreamhost.com>
References: <4F4DA1EA.3080705@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40149 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964833Ab2B2D7V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:59:21 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3090324322
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:21 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 1BD7A24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:21 -0800 (PST)
In-Reply-To: <4F4DA1EA.3080705@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The mon_addrs buffer in rbd_add is used to hold a copy of the
monitor IP addresses supplied via /sys/bus/rbd/add.  That is
passed to rbd_get_client(), which never modifies it (nor do
any of the functions it gets passed to thereafter)--the mon_addr
parameter to rbd_get_client() is a pointer to constant data, so it
can't be modifed.  Furthermore, rbd_get_client() has the length of
the mon_addrs buffer and that is used to ensure nothing goes beyond
its end.

Based on all this, there is no reason that a buffer needs to
be used to hold a copy of the mon_addrs provided via
/sys/bus/rbd/add.   Instead, the location within that passed-in
buffer can be provided, along with the length of the "token"
therein which represents the monitor IP's.

A small change to rbd_add_parse_args() allows the address within the
buffer to be passed back, and the length is already returned.  This
now means that, at least from the perspective of this interface,
there is no such thing as a list of monitor addresses that is too
long.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   21 +++++++++------------
  1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1cc7614..bc539cd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2283,7 +2283,7 @@ static inline size_t copy_token(const char **buf,
   */
  static int rbd_add_parse_args(struct rbd_device *rbd_dev,
  			      const char *buf,
-			      char *mon_addrs,
+			      const char **mon_addrs,
  			      size_t *mon_addrs_size,
  			      char *options,
  			      size_t options_size)
@@ -2292,10 +2292,13 @@ static int rbd_add_parse_args(struct rbd_device 
*rbd_dev,

  	/* The first four tokens are required */

-	len = copy_token(&buf, mon_addrs, *mon_addrs_size);
-	if (!len || len >= *mon_addrs_size)
+	len = next_token(&buf);
+	if (!len)
  		return -EINVAL;
  	*mon_addrs_size = len + 1;
+	*mon_addrs = buf;
+
+	buf += len;

  	len = copy_token(&buf, options, options_size);
  	if (!len || len >= options_size)
@@ -2336,8 +2339,8 @@ static ssize_t rbd_add(struct bus_type *bus,
  		       size_t count)
  {
  	struct rbd_device *rbd_dev;
-	char *mon_addrs = NULL;
-	size_t mon_addrs_size;
+	const char *mon_addrs = NULL;
+	size_t mon_addrs_size = 0;
  	char *options = NULL;
  	struct ceph_osd_client *osdc;
  	int rc = -ENOMEM;
@@ -2348,9 +2351,6 @@ static ssize_t rbd_add(struct bus_type *bus,
  	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
  	if (!rbd_dev)
  		goto err_nomem;
-	mon_addrs = kmalloc(count, GFP_KERNEL);
-	if (!mon_addrs)
-		goto err_nomem;
  	options = kmalloc(count, GFP_KERNEL);
  	if (!options)
  		goto err_nomem;
@@ -2368,8 +2368,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->id);

  	/* parse add command */
-	mon_addrs_size = count;
-	rc = rbd_add_parse_args(rbd_dev, buf, mon_addrs, &mon_addrs_size,
+	rc = rbd_add_parse_args(rbd_dev, buf, &mon_addrs, &mon_addrs_size,
  				options, count);
  	if (rc)
  		goto err_put_id;
@@ -2416,7 +2415,6 @@ err_out_bus:

  	rbd_bus_del_dev(rbd_dev);
  	kfree(options);
-	kfree(mon_addrs);
  	return rc;

  err_out_blkdev:
@@ -2427,7 +2425,6 @@ err_put_id:
  	rbd_id_put(rbd_dev);
  err_nomem:
  	kfree(options);
-	kfree(mon_addrs);
  	kfree(rbd_dev);

  	dout("Error adding device %s\n", buf);
-- 
1.7.5.4

