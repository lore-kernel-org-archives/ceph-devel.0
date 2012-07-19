From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: preserve snapc->seq in rbd_header_set_snap()
Date: Thu, 19 Jul 2012 12:11:37 -0500
Message-ID: <50083FC9.1030300@inktank.com>
References: <50083F65.5030104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:50845 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab2GSRLj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 13:11:39 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so3010257ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 10:11:39 -0700 (PDT)
In-Reply-To: <50083F65.5030104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In rbd_header_set_snap(), there is logic to make the snap context's
seq field get set to a particular snapshot id, or 0 if there is no
snapshot for the rbd image.

This seems to be an artifact of how the current snapshot id for an
rbd_dev was recorded before the rbd_dev->snap_id field began to be
used for that purpose.

There's no need to update the value of snapc->seq here any more, so
stop doing it.  Tidy up a few local variables in that function
while we're at it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8a46599..ac8a83f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -588,29 +588,25 @@ static int snap_by_name(struct rbd_image_header
*header, const char *snap_name,

 static int rbd_header_set_snap(struct rbd_device *rbd_dev, u64 *size)
 {
-	struct rbd_image_header *header = &rbd_dev->header;
-	struct ceph_snap_context *snapc = header->snapc;
-	int ret = -ENOENT;
+	int ret;

 	down_write(&rbd_dev->header_rwsem);

 	if (!memcmp(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
 		    sizeof (RBD_SNAP_HEAD_NAME))) {
-		if (header->total_snaps)
-			snapc->seq = header->snap_seq;
-		else
-			snapc->seq = 0;
 		rbd_dev->snap_id = CEPH_NOSNAP;
 		rbd_dev->snap_exists = false;
 		rbd_dev->read_only = 0;
 		if (size)
-			*size = header->image_size;
+			*size = rbd_dev->header.image_size;
 	} else {
-		ret = snap_by_name(header, rbd_dev->snap_name,
-					&snapc->seq, size);
+		u64 snap_id = 0;
+
+		ret = snap_by_name(&rbd_dev->header, rbd_dev->snap_name,
+					&snap_id, size);
 		if (ret < 0)
 			goto done;
-		rbd_dev->snap_id = snapc->seq;
+		rbd_dev->snap_id = snap_id;
 		rbd_dev->snap_exists = true;
 		rbd_dev->read_only = 1;
 	}
-- 
1.7.5.4

