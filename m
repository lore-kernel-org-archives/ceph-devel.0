From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: fix a bug in resizing a mapping
Date: Sat, 27 Apr 2013 07:18:39 -0500
Message-ID: <517BC21F.4030002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:60696 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab3D0MSl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:18:41 -0400
Received: by mail-ia0-f173.google.com with SMTP id 21so1036074iay.32
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:18:41 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id c2sm7717611igv.1.2013.04.27.05.18.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:18:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a snapshot context update occurs, rbd_update_mapping_size() is
called to set the capacity of the disk to record the updated
size of the image in case it has changed.

There's a bug though.  The mapping size is in units of *bytes*.  The
code that updates the mapping size field is assigning a value that
has been scaled down to *sectors*.

Fix that.  Also, check to see if the size has actually changed, and
don't bother updating things (specifically, calling set_capacity())
if it has not.

This resolves:
    http://tracker.ceph.com/issues/4833

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5918e0b..37d9349 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3034,15 +3034,17 @@ static void rbd_remove_all_snaps(struct
rbd_device *rbd_dev)

 static void rbd_update_mapping_size(struct rbd_device *rbd_dev)
 {
-	sector_t size;
-
 	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
 		return;

-	size = (sector_t) rbd_dev->header.image_size / SECTOR_SIZE;
-	dout("setting size to %llu sectors", (unsigned long long) size);
-	rbd_dev->mapping.size = (u64) size;
-	set_capacity(rbd_dev->disk, size);
+	if (rbd_dev->mapping.size != rbd_dev->header.image_size) {
+		sector_t size;
+
+		rbd_dev->mapping.size = rbd_dev->header.image_size;
+		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
+		dout("setting size to %llu sectors", (unsigned long long)size);
+		set_capacity(rbd_dev->disk, size);
+	}
 }

 /*
-- 
1.7.9.5

