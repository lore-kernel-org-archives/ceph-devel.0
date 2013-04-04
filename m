From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/9] libceph: record length of bio list with bio
Date: Thu, 04 Apr 2013 11:18:46 -0500
Message-ID: <515DA7E6.5020200@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:47977 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762531Ab3DDQSs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 12:18:48 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so3293585ieb.9
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 09:18:48 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When assigning a bio pointer to an osd request, we don't have an
efficient way of knowing the total length bytes in the bio list.
That information is available at the point it's set up by the rbd
code, so record it with the osd data when it's set.

This and the next patch are related to maintaining the length of a
message's data independent of the message header, as described here:
    http://tracker.ceph.com/issues/4589

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    1 +
 include/linux/ceph/osd_client.h |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 02d821e..9fb51b5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1352,6 +1352,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 		rbd_assert(obj_request->bio_list != NULL);
 		osd_data->type = CEPH_OSD_DATA_TYPE_BIO;
 		osd_data->bio = obj_request->bio_list;
+		osd_data->bio_length = obj_request->length;
 		break;
 	case OBJ_REQUEST_PAGES:
 		osd_data->type = CEPH_OSD_DATA_TYPE_PAGES;
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 3b5ba31..fdda93e 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -71,7 +71,10 @@ struct ceph_osd_data {
 		};
 		struct ceph_pagelist	*pagelist;
 #ifdef CONFIG_BLOCK
-		struct bio       	*bio;
+		struct {
+			struct bio	*bio;		/* list of bios */
+			size_t		bio_length;	/* total in list */
+		};
 #endif /* CONFIG_BLOCK */
 	};
 };
-- 
1.7.9.5

