From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] libceph: have osd requests support pagelist data
Date: Sun, 10 Mar 2013 15:36:16 -0500
Message-ID: <513CEEC0.8030606@inktank.com>
References: <513CEE83.4040900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:55450 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab3CJUgU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 16:36:20 -0400
Received: by mail-qe0-f52.google.com with SMTP id s14so1923840qeb.39
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 13:36:20 -0700 (PDT)
In-Reply-To: <513CEE83.4040900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add support for recording a ceph pagelist as data associated with an
osd request.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    4 +++-
 net/ceph/osd_client.c           |    3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index bcf3f72..cf0ba93 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -53,6 +53,7 @@ struct ceph_osd {
 enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE,
 	CEPH_OSD_DATA_TYPE_PAGES,
+	CEPH_OSD_DATA_TYPE_PAGELIST,
 #ifdef CONFIG_BLOCK
 	CEPH_OSD_DATA_TYPE_BIO,
 #endif /* CONFIG_BLOCK */
@@ -68,8 +69,9 @@ struct ceph_osd_data {
 			bool		pages_from_pool;
 			bool		own_pages;
 		};
+		struct ceph_pagelist	*pagelist;
 #ifdef CONFIG_BLOCK
-		struct bio       *bio;
+		struct bio       	*bio;
 #endif /* CONFIG_BLOCK */
 	};
 };
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6b78903..8fa3300 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1757,6 +1757,9 @@ static void ceph_osdc_msg_data_set(struct ceph_msg
*msg,
 		if (osd_data->length)
 			ceph_msg_data_set_pages(msg, osd_data->pages,
 				osd_data->length, osd_data->alignment);
+	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
+		BUG_ON(!osd_data->pagelist->length);
+		ceph_msg_data_set_pagelist(msg, osd_data->pagelist);
 #ifdef CONFIG_BLOCK
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
 		ceph_msg_data_set_bio(msg, osd_data->bio);
-- 
1.7.9.5

