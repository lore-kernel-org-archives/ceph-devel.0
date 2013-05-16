From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: don't destroy ceph_opts in rbd_add()
Date: Thu, 16 May 2013 16:29:12 -0500
Message-ID: <51954FA8.6030306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:38373 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab3EPV3O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 17:29:14 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so4422815oag.11
        for <ceph-devel@vger.kernel.org>; Thu, 16 May 2013 14:29:13 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id nt17sm8793829obb.13.2013.05.16.14.29.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 16 May 2013 14:29:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(Note: this patch and the two I'm about to re-post are available
in the "review/wip-4559" branch of the ceph-client git repository.)



Whether rbd_client_create() successfully creates a new client or
not, it takes responsibility for getting the ceph_opts structure
it's passed destroyed.  If successful, the structure becomes
associated with the created client; if not, rbd_client_create()
will destroy it.

Previously, rbd_get_client() would call ceph_destroy_options()
if rbd_get_client() failed, and that meant it got called twice.
That led freeing various pointers more than once, which is never a
good idea.

This resolves:
    http://tracker.ceph.com/issues/4559

Reported-by: Dan van der Ster <dan@vanderster.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e8d4693..ade30dd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -521,8 +521,8 @@ static const struct block_device_operations
rbd_bd_ops = {
 };

 /*
- * Initialize an rbd client instance.
- * We own *ceph_opts.
+ * Initialize an rbd client instance.  Success or not, this function
+ * consumes ceph_opts.
  */
 static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts)
 {
@@ -677,7 +677,8 @@ static int parse_rbd_opts_token(char *c, void *private)

 /*
  * Get a ceph client with specific addr and configuration, if one does
- * not exist create it.
+ * not exist create it.  Either way, ceph_opts is consumed by this
+ * function.
  */
 static struct rbd_client *rbd_get_client(struct ceph_options *ceph_opts)
 {
@@ -4994,7 +4995,6 @@ static ssize_t rbd_add(struct bus_type *bus,
 		rc = PTR_ERR(rbdc);
 		goto err_out_args;
 	}
-	ceph_opts = NULL;	/* rbd_dev client now owns this */

 	/* pick the pool */
 	osdc = &rbdc->client->osdc;
@@ -5038,8 +5038,6 @@ err_out_rbd_dev:
 err_out_client:
 	rbd_put_client(rbdc);
 err_out_args:
-	if (ceph_opts)
-		ceph_destroy_options(ceph_opts);
 	kfree(rbd_opts);
 	rbd_spec_put(spec);
 err_out_module:
-- 
1.7.9.5

