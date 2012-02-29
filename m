From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/4] rbd: use a single value of snap_name to mean no snap
Date: Tue, 28 Feb 2012 19:35:13 -0800
Message-ID: <4F4D9CF1.1020101@dreamhost.com>
References: <4F4D9BF6.5070102@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51016 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030688Ab2B2DfO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:35:14 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D15952431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:35:13 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A555324318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:35:13 -0800 (PST)
In-Reply-To: <4F4D9BF6.5070102@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

 From Josh Durgin <josh.durgin@dreamhost.com>

There's already a constant for this anyway.

(I changed Josh's code to use memcmp() and memcpy() instead. -Alex)

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |    8 +++-----
  1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3d0f8cf..25ed3c0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -563,10 +563,7 @@ static int rbd_header_set_snap(struct rbd_device *dev,

  	down_write(&header->snap_rwsem);

-	if (!snap_name ||
-	    !*snap_name ||
-	    strcmp(snap_name, "-") == 0 ||
-	    strcmp(snap_name, RBD_SNAP_HEAD_NAME) == 0) {
+	if (!memcmp(snap_name, RBD_SNAP_HEAD_NAME, sizeof RBD_SNAP_HEAD_NAME)) {
  		if (header->total_snaps)
  			snapc->seq = header->snap_seq;
  		else
@@ -2213,7 +2210,8 @@ static ssize_t rbd_add(struct bus_type *bus,
  	}

  	if (rbd_dev->snap_name[0] == 0)
-		rbd_dev->snap_name[0] = '-';
+		memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
+			sizeof RBD_SNAP_HEAD_NAME);

  	rbd_dev->obj_len = strlen(rbd_dev->obj);
  	snprintf(rbd_dev->obj_md_name, sizeof(rbd_dev->obj_md_name), "%s%s",
-- 
1.7.5.4

