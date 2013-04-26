From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/7] rbd: rename rbd_dev_probe()
Date: Fri, 26 Apr 2013 13:01:01 -0500
Message-ID: <517AC0DD.5060602@inktank.com>
References: <517AC047.6060000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:63900 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab3DZSBD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 14:01:03 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so5151225ieb.40
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 11:01:03 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id wn10sm4049103igb.2.2013.04.26.11.01.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 11:01:02 -0700 (PDT)
In-Reply-To: <517AC047.6060000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Rename rbd_dev_probe() to be rbd_dev_probe_image().  Its purpose
will eventually be to probe for the existence of a valid rbd image
for the rbd device--focusing only on the ceph side and not the Linux
device side of initialization.

For now the two "sides" are not fully separated, and this function
is still the entry point for initializing the full rbd device.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0356bba..f65310c6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -365,7 +365,7 @@ static ssize_t rbd_add(struct bus_type *bus, const
char *buf,
 		       size_t count);
 static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
 			  size_t count);
-static int rbd_dev_probe(struct rbd_device *rbd_dev);
+static int rbd_dev_probe_image(struct rbd_device *rbd_dev);

 static struct bus_attribute rbd_bus_attrs[] = {
 	__ATTR(add, S_IWUSR, NULL, rbd_add),
@@ -4762,7 +4762,7 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 		}
 		rbdc = NULL;		/* parent now owns reference */
 		parent_spec = NULL;	/* parent now owns reference */
-		ret = rbd_dev_probe(parent);
+		ret = rbd_dev_probe_image(parent);
 		if (ret < 0)
 			goto err_out_parent;
 		rbd_dev->parent = parent;
@@ -4811,7 +4811,7 @@ err_out_snaps:
  * device.  For format 2 images this includes determining the image
  * id.
  */
-static int rbd_dev_probe(struct rbd_device *rbd_dev)
+static int rbd_dev_probe_image(struct rbd_device *rbd_dev)
 {
 	int ret;

@@ -4899,7 +4899,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 	kfree(rbd_opts);
 	rbd_opts = NULL;	/* done with this */

-	rc = rbd_dev_probe(rbd_dev);
+	rc = rbd_dev_probe_image(rbd_dev);
 	if (rc < 0)
 		goto err_out_rbd_dev;

-- 
1.7.9.5

