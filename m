From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: set snapc->seq only when refreshing header
Date: Thu, 19 Jul 2012 12:11:45 -0500
Message-ID: <50083FD1.2000007@inktank.com>
References: <50083F65.5030104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58130 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab2GSRLs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 13:11:48 -0400
Received: by yhmm54 with SMTP id m54so3002648yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 10:11:47 -0700 (PDT)
In-Reply-To: <50083F65.5030104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In rbd_header_add_snap() there is code to set snapc->seq to the
just-added snapshot id.  This is the only remnant left of the
use of that field for recording which snapshot an rbd_dev was
associated with.  That functionality is no longer supported,
so get rid of that final bit of code.

Doing so means we never actually set snapc->seq any more.  On the
server, the snapshot context's sequence value represents the highest
snapshot id ever issued for a particular rbd image.  So we'll make
it have that meaning here as well.  To do so, set this value
whenever the rbd header is (re-)read.  That way it will always be
consistent with the rest of the snapshot context we maintain.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ac8a83f..c299a55 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -537,6 +537,7 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,

 	atomic_set(&header->snapc->nref, 1);
 	header->snap_seq = le64_to_cpu(ondisk->snap_seq);
+	header->snapc->seq = le64_to_cpu(ondisk->snap_seq);
 	header->snapc->num_snaps = snap_count;
 	header->total_snaps = snap_count;

@@ -1685,14 +1686,7 @@ static int rbd_header_add_snap(struct rbd_device
*rbd_dev,

 	kfree(data);

-	if (ret < 0)
-		return ret;
-
-	down_write(&rbd_dev->header_rwsem);
-	rbd_dev->header.snapc->seq = new_snapid;
-	up_write(&rbd_dev->header_rwsem);
-
-	return 0;
+	return ret < 0 ? ret : 0;
 bad:
 	return -ERANGE;
 }
-- 
1.7.5.4

