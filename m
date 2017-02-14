From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 01/15] rbd: use kstrndup() in rbd_header_from_disk()
Date: Tue, 14 Feb 2017 21:11:50 +0100
Message-ID: <1487103124-2974-2-git-send-email-idryomov@gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36129 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754915AbdBNUMb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 15:12:31 -0500
Received: by mail-qk0-f193.google.com with SMTP id p22so12928956qka.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 12:12:30 -0800 (PST)
In-Reply-To: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@ieee.org>

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 40a15ae354ce..76e538c3378e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -992,15 +992,11 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	/* Allocate this now to avoid having to handle failure below */
 
 	if (first_time) {
-		size_t len;
-
-		len = strnlen(ondisk->object_prefix,
-				sizeof (ondisk->object_prefix));
-		object_prefix = kmalloc(len + 1, GFP_KERNEL);
+		object_prefix = kstrndup(ondisk->object_prefix,
+					 sizeof(ondisk->object_prefix),
+					 GFP_KERNEL);
 		if (!object_prefix)
 			return -ENOMEM;
-		memcpy(object_prefix, ondisk->object_prefix, len);
-		object_prefix[len] = '\0';
 	}
 
 	/* Allocate the snapshot context and fill it in */
-- 
2.4.3

