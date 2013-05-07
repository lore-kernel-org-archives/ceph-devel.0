From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/7] rbd: zero format 1 header structure earlier
Date: Mon, 06 May 2013 20:52:48 -0500
Message-ID: <51885E70.2070901@inktank.com>
References: <51885E06.8020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:54190 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759546Ab3EGBwu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:52:50 -0400
Received: by mail-qc0-f181.google.com with SMTP id s10so30327qcv.12
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:52:49 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id s10sm42556082qam.7.2013.05.06.18.52.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:52:49 -0700 (PDT)
In-Reply-To: <51885E06.8020201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The passed-in header structure is zeroed in rbd_header_from_disk().
Instead, have the caller do it.  Note that there are two callers,
rbd_dev_v1_refresh() and rbd_dev_v1_probe().  The latter already has
a zeroed header structure so zeroing it isn't necessary there.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 357a11f..cdba93b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -738,8 +738,6 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 	size_t size;
 	u32 i;

-	memset(header, 0, sizeof (*header));
-
 	snap_count = le32_to_cpu(ondisk->snap_count);

 	len = strnlen(ondisk->object_prefix, sizeof (ondisk->object_prefix));
@@ -3103,6 +3101,7 @@ static int rbd_dev_v1_refresh(struct rbd_device
*rbd_dev)
 	int ret;
 	struct rbd_image_header h;

+	memset(&h, 0, sizeof (h));
 	ret = rbd_read_header(rbd_dev, &h);
 	if (ret < 0)
 		return ret;
-- 
1.7.9.5

