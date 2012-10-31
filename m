From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] rbd: skip getting image id if known
Date: Tue, 30 Oct 2012 20:49:04 -0500
Message-ID: <50908390.5020607@inktank.com>
References: <509081C4.3050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:50952 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809Ab2JaBtK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 21:49:10 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so677182iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 18:49:09 -0700 (PDT)
In-Reply-To: <509081C4.3050402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

We will know the image id for format 2 parent images, but won't
initially know its image name.  Avoid making the query for an image
id in rbd_dev_image_id() if it's already known.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8d26c0f..a852133 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3068,6 +3068,14 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 	void *p;

 	/*
+	 * When probing a parent image, the image id is already
+	 * known (and the image name likely is not).  There's no
+	 * need to fetch the image id again in this case.
+	 */
+	if (rbd_dev->spec->image_id)
+		return 0;
+
+	/*
 	 * First, see if the format 2 image id file exists, and if
 	 * so, get the image's persistent id from it.
 	 */
-- 
1.7.9.5

