From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/6] rbd: encapsulate header validity test
Date: Thu, 26 Jul 2012 13:45:14 -0500
Message-ID: <5011903A.2030104@inktank.com>
References: <50118F33.7080502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43395 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab2GZSpQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:45:16 -0400
Received: by yenl2 with SMTP id l2so2317882yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:45:16 -0700 (PDT)
In-Reply-To: <50118F33.7080502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If an rbd image header is read and it doesn't begin with the
expected magic information, a warning is displayed.  This is
a fairly simple test, but it could be extended at some point.
Fix the comparison so it actually looks at the "text" field
rather than the front of the structure.

In any case, encapsulate the validity test in its own function.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 93b2447..d95d563 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -481,6 +481,12 @@ static void rbd_coll_release(struct kref *kref)
 	kfree(coll);
 }

+static bool rbd_dev_ondisk_valid(struct rbd_image_header_ondisk *ondisk)
+{
+	return !memcmp(&ondisk->text,
+			RBD_HEADER_TEXT, sizeof (RBD_HEADER_TEXT));
+}
+
 /*
  * Create a new header structure, translate header format from the on-disk
  * header.
@@ -492,7 +498,7 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 {
 	u32 i, snap_count;

-	if (memcmp(ondisk, RBD_HEADER_TEXT, sizeof(RBD_HEADER_TEXT)))
+	if (!rbd_dev_ondisk_valid(ondisk))
 		return -ENXIO;

 	snap_count = le32_to_cpu(ondisk->snap_count);
-- 
1.7.9.5

