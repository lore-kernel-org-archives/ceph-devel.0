From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] rbd: support reading parent page data
Date: Wed, 08 May 2013 17:08:02 -0500
Message-ID: <518ACCC2.5020707@inktank.com>
References: <518ACC55.7090100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:61580 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3EHWIE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 18:08:04 -0400
Received: by mail-ob0-f181.google.com with SMTP id ta14so2282092obb.12
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 15:08:03 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id jw8sm244304obb.14.2013.05.08.15.08.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 May 2013 15:08:02 -0700 (PDT)
In-Reply-To: <518ACC55.7090100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently, rbd_img_parent_read() assumes the incoming object request
contains bio data.  But if a layered image is part of a multi-layer
stack of images will result in read requests of page data to parent
images.

Fortunately, it's not hard to add support for page data.

This resolves:
    http://tracker.ceph.com/issues/4939

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 15ac2a5..2a0e9b8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2574,7 +2574,7 @@ static void rbd_img_parent_read(struct
rbd_obj_request *obj_request)
 	rbd_assert(obj_request_img_data_test(obj_request));
 	rbd_assert(obj_request->img_request != NULL);
 	rbd_assert(obj_request->result == (s32) -ENOENT);
-	rbd_assert(obj_request->type == OBJ_REQUEST_BIO);
+	rbd_assert(obj_request_type_valid(obj_request->type));

 	rbd_dev = obj_request->img_request->rbd_dev;
 	rbd_assert(rbd_dev->parent != NULL);
@@ -2590,8 +2590,12 @@ static void rbd_img_parent_read(struct
rbd_obj_request *obj_request)
 	rbd_obj_request_get(obj_request);
 	img_request->obj_request = obj_request;

-	result = rbd_img_request_fill(img_request, OBJ_REQUEST_BIO,
-					obj_request->bio_list);
+	if (obj_request->type == OBJ_REQUEST_BIO)
+		result = rbd_img_request_fill(img_request, OBJ_REQUEST_BIO,
+						obj_request->bio_list);
+	else
+		result = rbd_img_request_fill(img_request, OBJ_REQUEST_PAGES,
+						obj_request->pages);
 	if (result)
 		goto out_err;

-- 
1.7.9.5

