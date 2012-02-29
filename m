From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/4] rbd: a few small cleanups
Date: Tue, 28 Feb 2012 19:35:07 -0800
Message-ID: <4F4D9CEB.7020700@dreamhost.com>
References: <4F4D9BF6.5070102@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51005 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965021Ab2B2DfH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:35:07 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id C896624318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:35:07 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id AE42124314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:35:07 -0800 (PST)
In-Reply-To: <4F4D9BF6.5070102@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Some minor cleanups in "drivers/block/rbd.c:
     - Use the more meaningful "RBD_MAX_OBJ_NAME_LEN" in place if "96"
       in the definition of RBD_MAX_MD_NAME_LEN.
     - Use DEFINE_SPINLOCK() to define and initialize node_lock.
     - Drop a needless (char *) cast in parse_rbd_opts_token().
     - Make a few minor formatting changes.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   21 +++++++++------------
  1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7f40cb4..7c8c07a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -46,7 +46,7 @@

  #define RBD_MINORS_PER_MAJOR	256		/* max minors per blkdev */

-#define RBD_MAX_MD_NAME_LEN	(96 + sizeof(RBD_SUFFIX))
+#define RBD_MAX_MD_NAME_LEN	(RBD_MAX_OBJ_NAME_LEN + sizeof(RBD_SUFFIX))
  #define RBD_MAX_POOL_NAME_LEN	64
  #define RBD_MAX_SNAP_NAME_LEN	32
  #define RBD_MAX_OPT_LEN		1024
@@ -175,7 +175,7 @@ static struct bus_type rbd_bus_type = {
  	.name		= "rbd",
  };

-static spinlock_t node_lock;      /* protects client get/put */
+static DEFINE_SPINLOCK(node_lock);      /* protects client get/put */

  static DEFINE_MUTEX(ctl_mutex);	  /* Serialize 
open/close/setup/teardown */
  static LIST_HEAD(rbd_dev_list);    /* devices */
@@ -324,7 +324,7 @@ static int parse_rbd_opts_token(char *c, void *private)
  	substring_t argstr[MAX_OPT_ARGS];
  	int token, intval, ret;

-	token = match_token((char *)c, rbdopt_tokens, argstr);
+	token = match_token(c, rbdopt_tokens, argstr);
  	if (token < 0)
  		return -EINVAL;

@@ -372,7 +372,8 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,
  	rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;

  	ret = ceph_parse_options(&opt, options, mon_addr,
-				 mon_addr + strlen(mon_addr), parse_rbd_opts_token, rbd_opts);
+				mon_addr + strlen(mon_addr),
+				parse_rbd_opts_token, rbd_opts);
  	if (ret < 0)
  		goto done_err;

@@ -460,15 +461,13 @@ static int rbd_header_from_disk(struct 
rbd_image_header *header,
  	u32 snap_count = le32_to_cpu(ondisk->snap_count);
  	int ret = -ENOMEM;

-	if (memcmp(ondisk, RBD_HEADER_TEXT, sizeof(RBD_HEADER_TEXT))) {
+	if (memcmp(ondisk, RBD_HEADER_TEXT, sizeof(RBD_HEADER_TEXT)))
  		return -ENXIO;
-	}

  	init_rwsem(&header->snap_rwsem);
  	header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
  	header->snapc = kmalloc(sizeof(struct ceph_snap_context) +
-				snap_count *
-				 sizeof(struct rbd_image_snap_ondisk),
+				snap_count * sizeof *ondisk,
  				gfp_flags);
  	if (!header->snapc)
  		return -ENOMEM;
@@ -498,8 +497,7 @@ static int rbd_header_from_disk(struct 
rbd_image_header *header,
  	header->snapc->num_snaps = snap_count;
  	header->total_snaps = snap_count;

-	if (snap_count &&
-	    allocated_snaps == snap_count) {
+	if (snap_count && allocated_snaps == snap_count) {
  		for (i = 0; i < snap_count; i++) {
  			header->snapc->snaps[i] =
  				le64_to_cpu(ondisk->snaps[i].id);
@@ -2421,7 +2419,7 @@ static int rbd_sysfs_init(void)
  	rbd_bus_type.bus_attrs = rbd_bus_attrs;

  	ret = bus_register(&rbd_bus_type);
-	 if (ret < 0)
+	if (ret < 0)
  		return ret;

  	ret = device_register(&rbd_root_dev);
@@ -2442,7 +2440,6 @@ int __init rbd_init(void)
  	rc = rbd_sysfs_init();
  	if (rc)
  		return rc;
-	spin_lock_init(&node_lock);
  	pr_info("loaded " DRV_NAME_LONG "\n");
  	return 0;
  }
-- 
1.7.5.4

