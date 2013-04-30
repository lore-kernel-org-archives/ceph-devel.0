From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] rbd: stop tracking header object version
Date: Tue, 30 Apr 2013 07:30:05 -0500
Message-ID: <517FB94D.7040002@inktank.com>
References: <517FB909.40309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41469 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760543Ab3D3MaH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:30:07 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so500052iec.29
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:30:07 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id o10sm24417208igh.2.2013.04.30.05.30.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:30:06 -0700 (PDT)
In-Reply-To: <517FB909.40309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The rbd code takes care to maintain the version of the header
object.  This was done in hopes of using it to detect a change in
the object between reading it and setting up a watch request to
be notified of changes.

The mechanism was never fully implemented, however.  And we now
avoid the original problem by setting up the watch request before
ever reading the content of the header.

The osd doesn't interpret the object version supplied with a WATCH
osd op, nor does it use the version supplied with a NOTIFY_ACK op
(we can just supply 0 for both).  There is therefore no need to
maintain the header's object version any more, so stop doing so.

We'll be able to simplify some more rbd code in the next few patches
as a result of this.

This resolves:
    http://tracker.ceph.com/issues/3952

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ab5c901..c4707dc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -110,8 +110,6 @@ struct rbd_image_header {

 	u64 stripe_unit;
 	u64 stripe_count;
-
-	u64 obj_version;
 };

 /*
@@ -2554,8 +2552,7 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 					rbd_dev->watch_request->osd_req);

 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
-				rbd_dev->watch_event->cookie,
-				rbd_dev->header.obj_version, start);
+				rbd_dev->watch_event->cookie, 0, start);
 	rbd_osd_req_format_write(obj_request);

 	ret = rbd_obj_request_submit(osdc, obj_request);
@@ -2987,8 +2984,6 @@ static int rbd_read_header(struct rbd_device *rbd_dev,
 	if (IS_ERR(ondisk))
 		return PTR_ERR(ondisk);
 	ret = rbd_header_from_disk(header, ondisk);
-	if (ret >= 0)
-		header->obj_version = ver;
 	kfree(ondisk);

 	return ret;
@@ -3044,9 +3039,6 @@ static int rbd_dev_v1_refresh(struct rbd_device
*rbd_dev, u64 *hver)
 	/* osd requests may still refer to snapc */
 	ceph_put_snap_context(rbd_dev->header.snapc);

-	if (hver)
-		*hver = h.obj_version;
-	rbd_dev->header.obj_version = h.obj_version;
 	rbd_dev->header.image_size = h.image_size;
 	rbd_dev->header.snapc = h.snapc;
 	rbd_dev->header.snap_names = h.snap_names;
@@ -4656,7 +4648,6 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 	ret = rbd_dev_v2_snap_context(rbd_dev, &ver);
 	if (ret)
 		goto out_err;
-	rbd_dev->header.obj_version = ver;

 	dout("discovered version 2 image, header name is %s\n",
 		rbd_dev->header_name);
-- 
1.7.9.5

