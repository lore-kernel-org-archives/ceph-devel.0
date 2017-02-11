From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] rbd: constify device_type structure
Date: Sat, 11 Feb 2017 12:14:38 +0530
Message-ID: <1486795478-16655-1-git-send-email-bhumirks@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35794 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdBKGwo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Feb 2017 01:52:44 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: julia.lawall@lip6.fr, idryomov@gmail.com, sage@redhat.com, elder@kernel.org, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Declare device_type structure as const as it is only stored in the
type field of a device structure. This field is of type const, so add
const to the declaration of device_type structure.

File size before:
   text	   data	    bss	    dec	    hex	filename
  61546	  11610	    208	  73364	  11e94	drivers/block/rbd.o

File size after:
   text	   data	    bss	    dec	    hex	filename
  61610	  11578	    208	  73396	  11eb4	drivers/block/rbd.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 36d2b9f..dfc708b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4779,7 +4779,7 @@ static ssize_t rbd_image_refresh(struct device *dev,
 
 static void rbd_dev_release(struct device *dev);
 
-static struct device_type rbd_device_type = {
+static const struct device_type rbd_device_type = {
 	.name		= "rbd",
 	.groups		= rbd_attr_groups,
 	.release	= rbd_dev_release,
-- 
1.9.1

