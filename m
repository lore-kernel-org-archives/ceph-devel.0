From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] rbd: check for overflow in rbd_get_num_segments()
Date: Tue, 22 Jan 2013 15:58:14 -0600
Message-ID: <50FF0B76.5040402@inktank.com>
References: <50FF0B22.5060201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62891 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151Ab3AVV6R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:58:17 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so12130943iea.8
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:58:17 -0800 (PST)
In-Reply-To: <50FF0B22.5060201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The return type of rbd_get_num_segments() is int, but the values it
operates on are u64.  Although it's not likely, there's no guarantee
the result won't exceed what can be respresented in an int.  The
function is already designed to return -ERANGE on error, so just add
this possible overflow as another reason to return that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4ed0741..58d01e3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -820,6 +820,7 @@ static int rbd_get_num_segments(struct
rbd_image_header *header,
 {
 	u64 start_seg;
 	u64 end_seg;
+	u64 result;

 	if (!len)
 		return 0;
@@ -829,7 +830,11 @@ static int rbd_get_num_segments(struct
rbd_image_header *header,
 	start_seg = ofs >> header->obj_order;
 	end_seg = (ofs + len - 1) >> header->obj_order;

-	return end_seg - start_seg + 1;
+	result = end_seg - start_seg + 1;
+	if (result > (u64) INT_MAX)
+		return -ERANGE;
+
+	return (int) result;
 }

 /*
-- 
1.7.9.5

