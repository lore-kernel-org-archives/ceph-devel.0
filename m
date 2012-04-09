From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] rbd: fix integer overflow in rbd_header_from_disk()
Date: Mon,  9 Apr 2012 17:52:15 -0400
Message-ID: <1334008335-8377-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:37552 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953Ab2DIVwY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Apr 2012 17:52:24 -0400
Received: by qadc11 with SMTP id c11so1738935qad.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Apr 2012 14:52:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@dreamhost.com>, Yehuda Sadeh <yehuda@hq.newdream.net>, Sage Weil <sage@newdream.net>, Xi Wang <xi.wang@gmail.com>

ondisk->snap_count is read from disk via rbd_req_sync_read() and thus
needs validation.  Otherwise, a bogus `snap_count' could overflow the
kmalloc() size, leading to memory corruption.

Also use `u32' consistently for `snap_count'.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 drivers/block/rbd.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 013c7a5..d47f7e6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -487,18 +487,20 @@ static void rbd_coll_release(struct kref *kref)
  */
 static int rbd_header_from_disk(struct rbd_image_header *header,
 				 struct rbd_image_header_ondisk *ondisk,
-				 int allocated_snaps,
+				 u32 allocated_snaps,
 				 gfp_t gfp_flags)
 {
-	int i;
-	u32 snap_count;
+	u32 i, snap_count;
 
 	if (memcmp(ondisk, RBD_HEADER_TEXT, sizeof(RBD_HEADER_TEXT)))
 		return -ENXIO;
 
 	snap_count = le32_to_cpu(ondisk->snap_count);
+	if (snap_count > (ULONG_MAX - sizeof(struct ceph_snap_context))
+			 / sizeof(*ondisk))
+		return -EINVAL;
 	header->snapc = kmalloc(sizeof(struct ceph_snap_context) +
-				snap_count * sizeof (*ondisk),
+				snap_count * sizeof(*ondisk),
 				gfp_flags);
 	if (!header->snapc)
 		return -ENOMEM;
@@ -1592,7 +1594,7 @@ static int rbd_read_header(struct rbd_device *rbd_dev,
 {
 	ssize_t rc;
 	struct rbd_image_header_ondisk *dh;
-	int snap_count = 0;
+	u32 snap_count = 0;
 	u64 ver;
 	size_t len;
 
-- 
1.7.5.4

