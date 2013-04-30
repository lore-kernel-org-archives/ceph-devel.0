From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] rbd: don't revalidate so much
Date: Tue, 30 Apr 2013 07:23:35 -0500
Message-ID: <517FB7C7.90900@inktank.com>
References: <517FB770.1070500@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:42899 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760543Ab3D3MXh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:23:37 -0400
Received: by mail-ia0-f181.google.com with SMTP id k38so372756iah.40
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:23:36 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id m4sm10515631igd.0.2013.04.30.05.23.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:23:35 -0700 (PDT)
In-Reply-To: <517FB770.1070500@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Whenever a header object event causes a mapped rbd image to refresh
its header information, revalidate_disk() is being called.  This was
done in rbd_dev_refresh() outside the control mutex in order to
avoid a lock inversion.  Although a an event like this *might*
indicate the image has changed size, most of the time it does not.

Record the image size before and after the refresh, and only
call revalidate_disk() if it changes.

This resolves:
    http://tracker.ceph.com/issues/4867

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 176a3d7..dbc61e3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3065,19 +3065,22 @@ static int rbd_dev_v1_refresh(struct rbd_device
*rbd_dev, u64 *hver)

 static int rbd_dev_refresh(struct rbd_device *rbd_dev, u64 *hver)
 {
+	u64 image_size;
 	int ret;

 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
+	image_size = rbd_dev->header.image_size;
 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 	if (rbd_dev->image_format == 1)
 		ret = rbd_dev_v1_refresh(rbd_dev, hver);
 	else
 		ret = rbd_dev_v2_refresh(rbd_dev, hver);
 	mutex_unlock(&ctl_mutex);
-	revalidate_disk(rbd_dev->disk);
 	if (ret)
 		rbd_warn(rbd_dev, "got notification but failed to "
 			   " update snaps: %d\n", ret);
+	if (image_size != rbd_dev->header.image_size)
+		revalidate_disk(rbd_dev->disk);

 	return ret;
 }
-- 
1.7.9.5

