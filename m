From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/7] rbd: drop rbd_header_from_disk() gfp_flags parameter
Date: Thu, 26 Jul 2012 13:57:23 -0500
Message-ID: <50119313.1010508@inktank.com>
References: <50119076.1030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53985 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab2GZS5Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:57:25 -0400
Received: by ghrr11 with SMTP id r11so2351940ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:57:25 -0700 (PDT)
In-Reply-To: <50119076.1030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The function rbd_header_from_disk() is only called in one spot, and
it passes GFP_KERNEL as its value for the gfp_flags parameter.

Just drop that parameter and substitute GFP_KERNEL everywhere within
that function it had been used.  (If we find we need the parameter
again in the future it's easy enough to add back again.)

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 64d3dbd..597ebaa 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -493,8 +493,7 @@ static bool rbd_dev_ondisk_valid(struct
rbd_image_header_ondisk *ondisk)
  */
 static int rbd_header_from_disk(struct rbd_image_header *header,
 				 struct rbd_image_header_ondisk *ondisk,
-				 u32 allocated_snaps,
-				 gfp_t gfp_flags)
+				 u32 allocated_snaps)
 {
 	u32 i, snap_count;

@@ -507,18 +506,18 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 		return -EINVAL;
 	header->snapc = kmalloc(sizeof(struct ceph_snap_context) +
 				snap_count * sizeof(u64),
-				gfp_flags);
+				GFP_KERNEL);
 	if (!header->snapc)
 		return -ENOMEM;

 	header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
 	if (snap_count) {
 		header->snap_names = kmalloc(header->snap_names_len,
-					     gfp_flags);
+					     GFP_KERNEL);
 		if (!header->snap_names)
 			goto err_snapc;
 		header->snap_sizes = kmalloc(snap_count * sizeof(u64),
-					     gfp_flags);
+					     GFP_KERNEL);
 		if (!header->snap_sizes)
 			goto err_names;
 	} else {
@@ -527,7 +526,7 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 	}

 	header->object_prefix = kmalloc(sizeof (ondisk->block_name) + 1,
-					gfp_flags);
+					GFP_KERNEL);
 	if (!header->object_prefix)
 		goto err_sizes;

@@ -1621,7 +1620,7 @@ static int rbd_read_header(struct rbd_device *rbd_dev,
 		if (rc < 0)
 			goto out_dh;

-		rc = rbd_header_from_disk(header, dh, snap_count, GFP_KERNEL);
+		rc = rbd_header_from_disk(header, dh, snap_count);
 		if (rc < 0) {
 			if (rc == -ENXIO)
 				pr_warning("unrecognized header format"
-- 
1.7.9.5

