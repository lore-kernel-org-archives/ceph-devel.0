From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/7] rbd: simplify snap_by_name() interface
Date: Fri, 07 Sep 2012 08:45:57 -0500
Message-ID: <5049FA95.3040505@inktank.com>
References: <5049F951.2030706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49099 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2IGNp7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 09:45:59 -0400
Received: by iahk25 with SMTP id k25so3208671iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 06:45:58 -0700 (PDT)
In-Reply-To: <5049F951.2030706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is only one caller of snap_by_name(), and it passes two values
to be assigned, both of which are found within an rbd device
structure.

Change the interface so it just passes the address of the rbd_dev,
and make the assignments to its fields directly.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 23fa962..46b8f8e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -621,10 +621,10 @@ out_err:
 	return -ENOMEM;
 }

-static int snap_by_name(struct rbd_image_header *header, const char
*snap_name,
-			u64 *seq, u64 *size)
+static int snap_by_name(struct rbd_device *rbd_dev, const char *snap_name)
 {
 	int i;
+	struct rbd_image_header *header = &rbd_dev->header;
 	char *p = header->snap_names;

 	rbd_assert(header->snapc != NULL);
@@ -633,10 +633,9 @@ static int snap_by_name(struct rbd_image_header
*header, const char *snap_name,

 			/* Found it.  Pass back its id and/or size */

-			if (seq)
-				*seq = header->snapc->snaps[i];
-			if (size)
-				*size = header->snap_sizes[i];
+			rbd_dev->mapping.snap_id = header->snapc->snaps[i];
+			rbd_dev->mapping.size = header->snap_sizes[i];
+
 			return i;
 		}
 		p += strlen(p) + 1;	/* Skip ahead to the next name */
@@ -657,9 +656,7 @@ static int rbd_header_set_snap(struct rbd_device
*rbd_dev, char *snap_name)
 		rbd_dev->mapping.snap_exists = false;
 		rbd_dev->mapping.read_only = rbd_dev->rbd_opts.read_only;
 	} else {
-		ret = snap_by_name(&rbd_dev->header, snap_name,
-					&rbd_dev->mapping.snap_id,
-					&rbd_dev->mapping.size);
+		ret = snap_by_name(rbd_dev, snap_name);
 		if (ret < 0)
 			goto done;
 		rbd_dev->mapping.snap_exists = true;
-- 
1.7.9.5

