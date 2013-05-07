From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/6] rbd: don't print warning if not mapping a parent
Date: Mon, 06 May 2013 20:37:53 -0500
Message-ID: <51885AF1.5080609@inktank.com>
References: <51885A97.9070005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:38427 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759433Ab3EGBhz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:37:55 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so56032iec.15
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:37:55 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id 9sm5170877igy.7.2013.05.06.18.37.54
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:37:54 -0700 (PDT)
In-Reply-To: <51885A97.9070005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The presence of the LAYERING bit in an rbd image's feature mask does
not guarantee the image actually has a parent image.  Currently that
bit is set only when a clone (i.e., image with a parent) is created,
but it is (currently) not cleared if that clone gets flattened back
into a "normal" image.  A "parent_id" query will leave the
parent_spec for the image being mapped a null pointer, but will not
return an error.

Currently, whenever an image with the LAYERED feature gets mapped, a
warning about the use of layered images gets printed.  But we don't
want to do this for a flattened image, so print the warning only
if we find there is a parent spec after the probe.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0a24cdf..7d93dbd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4567,13 +4567,14 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 		ret = rbd_dev_v2_parent_info(rbd_dev);
 		if (ret)
 			goto out_err;
-
 		/*
-		 * Don't print a warning for parent images.  We can
-		 * tell this point because we won't know its pool
-		 * name yet (just its pool id).
+		 * Print a warning if this image has a parent.
+		 * Don't print it if the image now being probed
+		 * is itself a parent.  We can tell at this point
+		 * because we won't know its pool name yet (just its
+		 * pool id).
 		 */
-		if (rbd_dev->spec->pool_name)
+		if (rbd_dev->parent_spec && rbd_dev->spec->pool_name)
 			rbd_warn(rbd_dev, "WARNING: kernel layering "
 					"is EXPERIMENTAL!");
 	}
-- 
1.7.9.5

