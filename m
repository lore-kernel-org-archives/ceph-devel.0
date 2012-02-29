From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/5] rbd: have rbd_parse_args() report found mon_addrs size
Date: Tue, 28 Feb 2012 19:59:18 -0800
Message-ID: <4F4DA296.8010909@dreamhost.com>
References: <4F4DA1EA.3080705@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40141 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964833Ab2B2D7T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:59:19 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 43BB224322
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:19 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 3506324318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:19 -0800 (PST)
In-Reply-To: <4F4DA1EA.3080705@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The argument parsing routine already computes the size of the
mon_addrs buffer it extracts from the "command."  Pass it to the
caller so it can use it to provide the length to rbd_get_client().

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   20 +++++++++++++-------
  1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0602ed9..1cc7614 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -391,7 +391,9 @@ static int parse_rbd_opts_token(char *c, void *private)
   * Get a ceph client with specific addr and configuration, if one does
   * not exist create it.
   */
-static struct rbd_client *rbd_get_client(const char *mon_addr, char 
*options)
+static struct rbd_client *rbd_get_client(const char *mon_addr,
+					 size_t mon_addr_len,
+					 char *options)
  {
  	struct rbd_client *rbdc;
  	struct ceph_options *opt;
@@ -404,7 +406,7 @@ static struct rbd_client *rbd_get_client(const char 
*mon_addr, char *options)
  	rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;

  	opt = ceph_parse_options(options, mon_addr,
-				mon_addr + strlen(mon_addr),
+				mon_addr + mon_addr_len,
  				parse_rbd_opts_token, rbd_opts);
  	if (IS_ERR(opt)) {
  		kfree(rbd_opts);
@@ -2282,7 +2284,7 @@ static inline size_t copy_token(const char **buf,
  static int rbd_add_parse_args(struct rbd_device *rbd_dev,
  			      const char *buf,
  			      char *mon_addrs,
-			      size_t mon_addrs_size,
+			      size_t *mon_addrs_size,
  			      char *options,
  			      size_t options_size)
  {
@@ -2290,9 +2292,10 @@ static int rbd_add_parse_args(struct rbd_device 
*rbd_dev,

  	/* The first four tokens are required */

-	len = copy_token(&buf, mon_addrs, mon_addrs_size);
-	if (!len || len >= mon_addrs_size)
+	len = copy_token(&buf, mon_addrs, *mon_addrs_size);
+	if (!len || len >= *mon_addrs_size)
  		return -EINVAL;
+	*mon_addrs_size = len + 1;

  	len = copy_token(&buf, options, options_size);
  	if (!len || len >= options_size)
@@ -2334,6 +2337,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  {
  	struct rbd_device *rbd_dev;
  	char *mon_addrs = NULL;
+	size_t mon_addrs_size;
  	char *options = NULL;
  	struct ceph_osd_client *osdc;
  	int rc = -ENOMEM;
@@ -2364,12 +2368,14 @@ static ssize_t rbd_add(struct bus_type *bus,
  	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->id);

  	/* parse add command */
-	rc = rbd_add_parse_args(rbd_dev, buf, mon_addrs, count,
+	mon_addrs_size = count;
+	rc = rbd_add_parse_args(rbd_dev, buf, mon_addrs, &mon_addrs_size,
  				options, count);
  	if (rc)
  		goto err_put_id;

-	rbd_dev->rbd_client = rbd_get_client(mon_addrs, options);
+	rbd_dev->rbd_client = rbd_get_client(mon_addrs, mon_addrs_size - 1,
+						options);
  	if (IS_ERR(rbd_dev->rbd_client)) {
  		rc = PTR_ERR(rbd_dev->rbd_client);
  		goto err_put_id;
-- 
1.7.5.4

