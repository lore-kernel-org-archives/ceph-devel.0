From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] rbd: don't release write request until necessary
Date: Sat, 11 May 2013 12:44:02 -0500
Message-ID: <518E8362.30906@inktank.com>
References: <518E831E.6000206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:60879 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab3EKRoD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:44:03 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so10176342iea.3
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:44:03 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ve9sm6126444igb.3.2013.05.11.10.44.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:44:02 -0700 (PDT)
In-Reply-To: <518E831E.6000206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Previously when a layered write was going to involve a copyup
request, the original osd request was released before submitting the
parent full-object read.  The osd request for the copyup would then
be allocated in rbd_img_obj_parent_read_full_callback().

Shortly we will be handling the event of mapped layered images
getting flattened, and when that occurs we need to resubmit the
original request.  We therefore don't want to release the osd
request until we really konw we're going to replace it--in the
callback function.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 06d49b5..ac3f4e7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2187,13 +2187,17 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)
 	if (result)
 		goto out_err;

-	/* Allocate the new copyup osd request for the original request */
-
+	/*
+	 * The original osd request is of no use to use any more.
+	 * We need a new one that can hold the two ops in a copyup
+	 * request.  Allocate the new copyup osd request for the
+	 * original request, and release the old one.
+	 */
 	result = -ENOMEM;
-	rbd_assert(!orig_request->osd_req);
 	osd_req = rbd_osd_req_create_copyup(orig_request);
 	if (!osd_req)
 		goto out_err;
+	rbd_osd_req_destroy(orig_request->osd_req);
 	orig_request->osd_req = osd_req;
 	orig_request->copyup_pages = pages;

@@ -2269,15 +2273,6 @@ static int rbd_img_obj_parent_read_full(struct
rbd_obj_request *obj_request)
 	rbd_assert(rbd_dev->parent != NULL);

 	/*
-	 * First things first.  The original osd request is of no
-	 * use to use any more, we'll need a new one that can hold
-	 * the two ops in a copyup request.  We'll get that later,
-	 * but for now we can release the old one.
-	 */
-	rbd_osd_req_destroy(obj_request->osd_req);
-	obj_request->osd_req = NULL;
-
-	/*
 	 * Determine the byte range covered by the object in the
 	 * child image to which the original request was to be sent.
 	 */
-- 
1.7.9.5

