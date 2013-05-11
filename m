From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: ignore zero-overlap parent
Date: Sat, 11 May 2013 12:38:11 -0500
Message-ID: <518E8203.6050308@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:45846 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab3EKRiM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:38:12 -0400
Received: by mail-ia0-f176.google.com with SMTP id j38so5571928iad.7
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:38:12 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id d9sm5614097igr.4.2013.05.11.10.38.10
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:38:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

An rbd clone image that has an overlap with its parent of 0 is
effectively not a layered image at all.  Detect this case and treat
such an image as non-layered.  Issue a warning to be sure the user
knows what's going on.

This resolves:
    http://tracker.ceph.com/issues/5028

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b9221a0..3a8135f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3655,9 +3655,13 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	ceph_decode_64_safe(&p, end, parent_spec->snap_id, out_err);
 	ceph_decode_64_safe(&p, end, overlap, out_err);

-	rbd_dev->parent_overlap = overlap;
-	rbd_dev->parent_spec = parent_spec;
-	parent_spec = NULL;	/* rbd_dev now owns this */
+	if (overlap) {
+		rbd_dev->parent_spec = parent_spec;
+		parent_spec = NULL;	/* rbd_dev now owns this */
+		rbd_dev->parent_overlap = overlap;
+	} else {
+		rbd_warn(rbd_dev, "ignoring parent of clone with overlap 0\n");
+	}
 out:
 	ret = 0;
 out_err:
-- 
1.7.9.5

