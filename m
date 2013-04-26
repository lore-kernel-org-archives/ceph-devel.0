From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/7] rbd: make rbd_dev_destroy() match rbd_dev_create()
Date: Fri, 26 Apr 2013 13:00:48 -0500
Message-ID: <517AC0D0.30708@inktank.com>
References: <517AC047.6060000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36703 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab3DZSAu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 14:00:50 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so5258247ieb.13
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 11:00:50 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id in10sm4404248igc.1.2013.04.26.11.00.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 11:00:49 -0700 (PDT)
In-Reply-To: <517AC047.6060000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently, rbd_dev_destroy() does more than just the inverse of what
rbd_dev_create() does.  Stop doing that, and move the two extra
things it does into the three call sites.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 63040fd..0356bba 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3425,8 +3425,6 @@ static struct rbd_device *rbd_dev_create(struct
rbd_client *rbdc,

 static void rbd_dev_destroy(struct rbd_device *rbd_dev)
 {
-	rbd_spec_put(rbd_dev->parent_spec);
-	kfree(rbd_dev->header_name);
 	rbd_put_client(rbd_dev->rbd_client);
 	rbd_spec_put(rbd_dev->spec);
 	kfree(rbd_dev);
@@ -4784,6 +4782,8 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	return ret;

 err_out_parent:
+	rbd_spec_put(rbd_dev->parent_spec);
+	kfree(rbd_dev->header_name);
 	rbd_dev_destroy(parent);
 err_out_spec:
 	rbd_spec_put(parent_spec);
@@ -4905,6 +4905,8 @@ static ssize_t rbd_add(struct bus_type *bus,

 	return count;
 err_out_rbd_dev:
+	rbd_spec_put(rbd_dev->parent_spec);
+	kfree(rbd_dev->header_name);
 	rbd_dev_destroy(rbd_dev);
 err_out_client:
 	rbd_put_client(rbdc);
@@ -4955,6 +4957,8 @@ static void rbd_dev_release(struct device *dev)
 	/* done with the id, and with the rbd_dev */
 	rbd_dev_id_put(rbd_dev);
 	rbd_assert(rbd_dev->rbd_client != NULL);
+	rbd_spec_put(rbd_dev->parent_spec);
+	kfree(rbd_dev->header_name);
 	rbd_dev_destroy(rbd_dev);

 	/* release module ref */
-- 
1.7.9.5

