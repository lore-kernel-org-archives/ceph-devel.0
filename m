From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/2] rbd: tear down watch request if rbd_dev_device_setup() fails
Date: Mon, 16 Dec 2013 22:05:35 +0200
Message-ID: <1387224335-902-3-git-send-email-ilya.dryomov@inktank.com>
References: <1387224335-902-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:45613 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab3LPUG1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 15:06:27 -0500
Received: by mail-ee0-f54.google.com with SMTP id e51so2093597eek.27
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 12:06:26 -0800 (PST)
In-Reply-To: <1387224335-902-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Tear down watch request if rbd_dev_device_setup() fails.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c91108b760cf..e709f4ae117f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5101,6 +5101,12 @@ static ssize_t rbd_add(struct bus_type *bus,
 
 	rc = rbd_dev_device_setup(rbd_dev);
 	if (rc) {
+		/*
+		 * rbd_dev_header_unwatch_sync() can't be moved into
+		 * rbd_dev_image_release() without refactoring, see
+		 * commit 1f3ef78861ac.
+		 */
+		rbd_dev_header_unwatch_sync(rbd_dev);
 		rbd_dev_image_release(rbd_dev);
 		goto err_out_module;
 	}
-- 
1.7.10.4

