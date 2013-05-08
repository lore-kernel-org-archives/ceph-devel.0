From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] rbd: kill rbd_img_request_get()
Date: Wed, 08 May 2013 17:08:41 -0500
Message-ID: <518ACCE9.3010203@inktank.com>
References: <518ACC55.7090100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:47931 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab3EHWIm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 18:08:42 -0400
Received: by mail-ob0-f172.google.com with SMTP id fb19so1080402obc.31
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 15:08:42 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id n5sm292155obi.8.2013.05.08.15.08.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 May 2013 15:08:41 -0700 (PDT)
In-Reply-To: <518ACC55.7090100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Get rid of rbd_img_request_get(), because it isn't used, and maybe
won't ever be needed.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e417704..51c45e7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1357,13 +1357,6 @@ static void rbd_obj_request_put(struct
rbd_obj_request *obj_request)
 	kref_put(&obj_request->kref, rbd_obj_request_destroy);
 }

-static void rbd_img_request_get(struct rbd_img_request *img_request)
-{
-	dout("%s: img %p (was %d)\n", __func__, img_request,
-		atomic_read(&img_request->kref.refcount));
-	kref_get(&img_request->kref);
-}
-
 static void rbd_img_request_destroy(struct kref *kref);
 static void rbd_img_request_put(struct rbd_img_request *img_request)
 {
@@ -1888,9 +1881,6 @@ static struct rbd_img_request *rbd_img_request_create(
 	INIT_LIST_HEAD(&img_request->obj_requests);
 	kref_init(&img_request->kref);

-	rbd_img_request_get(img_request);	/* Avoid a warning */
-	rbd_img_request_put(img_request);	/* TEMPORARY */
-
 	dout("%s: rbd_dev %p %s %llu/%llu -> img %p\n", __func__, rbd_dev,
 		write_request ? "write" : "read", offset, length,
 		img_request);
-- 
1.7.9.5

