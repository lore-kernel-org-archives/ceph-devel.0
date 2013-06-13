From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 1/2] rbd: fetch object order before using it
Date: Wed, 12 Jun 2013 20:10:45 -0700
Message-ID: <1371093046-5814-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43450 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758254Ab3FMDkj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jun 2013 23:40:39 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6C1682609B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Jun 2013 20:41:35 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 667212608C
	for <ceph-devel@vger.kernel.org>; Wed, 12 Jun 2013 20:41:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_dev_v2_header_onetime() fetches striping information, and
checks whether the image can be read by compariing the stripe unit
to the object size. It determines the object size by shifting
the object order, which is 0 at this point since it has not been
read yet. Move the call to get the image size and object order
before rbd_dev_v2_header_onetime() so it is set before use.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cecf5c6..9f72125 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4286,6 +4286,10 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 	bool first_time = rbd_dev->header.object_prefix == NULL;
 	int ret;
 
+	ret = rbd_dev_v2_image_size(rbd_dev);
+	if (ret)
+		return ret;
+
 	if (first_time) {
 		ret = rbd_dev_v2_header_onetime(rbd_dev);
 		if (ret)
@@ -4319,10 +4323,6 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 					"is EXPERIMENTAL!");
 	}
 
-	ret = rbd_dev_v2_image_size(rbd_dev);
-	if (ret)
-		return ret;
-
 	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
 		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
 			rbd_dev->mapping.size = rbd_dev->header.image_size;
-- 
1.7.2.5

