From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4, v2] rbd: define rbd_update_mapping_size()
Date: Tue, 09 Oct 2012 18:14:56 -0700
Message-ID: <5074CC10.2010103@inktank.com>
References: <50748FA5.4030508@inktank.com> <50749074.5030603@inktank.com> <5074B2F0.50008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36106 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757295Ab2JJBO7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 21:14:59 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5828384pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 18:14:59 -0700 (PDT)
In-Reply-To: <5074B2F0.50008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Encapsulate the code that handles updating the size of a mapping
after an rbd image has been refreshed.  This is done in anticipation
of the next patch, which will make this common code for format 1 and
2 images.

Signed-off-by: Alex Elder <elder@inktank.com>
---
Changed since v1:
- renamed renamed the function to include "mapping"
- now call the function unconditionally--whether or not
   the size has changed, and only update the mapping if
   the mapping is to the base image.

  drivers/block/rbd.c |   27 ++++++++++++++++-----------
  1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bb3d9be..b64125d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1716,6 +1716,19 @@ static void __rbd_remove_all_snaps(struct 
rbd_device *rbd_dev)
  		__rbd_remove_snap_dev(snap);
  }

+static void rbd_update_mapping_size(struct rbd_device *rbd_dev)
+{
+	sector_t size;
+
+	if (rbd_dev->mapping.snap_id != CEPH_NOSNAP)
+		return;
+
+	size = (sector_t) rbd_dev->header.image_size / SECTOR_SIZE;
+	dout("setting size to %llu sectors", (unsigned long long) size);
+	rbd_dev->mapping.size = (u64) size;
+	set_capacity(rbd_dev->disk, size);
+}
+
  /*
   * only read the first part of the ondisk header, without the snaps info
   */
@@ -1730,17 +1743,9 @@ static int __rbd_refresh_header(struct rbd_device 
*rbd_dev, u64 *hver)

  	down_write(&rbd_dev->header_rwsem);

-	/* resized? */
-	if (rbd_dev->mapping.snap_id == CEPH_NOSNAP) {
-		sector_t size = (sector_t) h.image_size / SECTOR_SIZE;
-
-		if (size != (sector_t) rbd_dev->mapping.size) {
-			dout("setting size to %llu sectors",
-				(unsigned long long) size);
-			rbd_dev->mapping.size = (u64) size;
-			set_capacity(rbd_dev->disk, size);
-		}
-	}
+	/* Update image size, and check for resize of mapped image */
+	rbd_dev->header.image_size = h.image_size;
+	rbd_update_mapping_size(rbd_dev);

  	/* rbd_dev->header.object_prefix shouldn't change */
  	kfree(rbd_dev->header.snap_sizes);
-- 
1.7.9.5

