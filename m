From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: zero return code in rbd_dev_image_id()
Date: Mon, 15 Oct 2012 08:44:08 -0500
Message-ID: <507C1328.2010107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36454 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375Ab2JONoK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 09:44:10 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so7773979iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 06:44:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is a call in rbd_dev_image_id() to rbd_req_sync_exec()
to get the image id for an image.  Despite the "get_id" class
method only returning 0 on success, I am getting back a positive
value (I think the number of bytes returned with the call).

That may or may not be how rbd_req_sync_exec() is supposed to
behave, but zeroing the return value if successful makes it moot
and makes this path through the code work as desired.

Do the same in rbd_dev_v2_object_prefix().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2207,6 +2207,7 @@ static int rbd_dev_v2_object_prefix(stru
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
+	ret = 0;    /* rbd_req_sync_exec() can return positive */

 	p = reply_buf;
 	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
@@ -2900,6 +2901,7 @@ static int rbd_dev_image_id(struct rbd_d
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
+	ret = 0;    /* rbd_req_sync_exec() can return positive */

 	p = response;
 	rbd_dev->image_id = ceph_extract_encoded_string(&p,
