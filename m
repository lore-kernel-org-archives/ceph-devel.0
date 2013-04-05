From: Alex Elder <elder@inktank.com>
Subject: [PATCH 05/20] libceph: define ceph_osd_data_length()
Date: Fri, 05 Apr 2013 09:02:26 -0500
Message-ID: <515ED972.2030309@inktank.com>
References: <515ED849.9060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:34876 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161757Ab3DEOC2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 10:02:28 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so3187606iad.26
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 07:02:28 -0700 (PDT)
In-Reply-To: <515ED849.9060901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

One more osd data helper, which returns the length of the
data item, regardless of its type.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index df0f856..110cd83 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -117,6 +117,25 @@ void ceph_osd_data_bio_init(struct ceph_osd_data
*osd_data,
 EXPORT_SYMBOL(ceph_osd_data_bio_init);
 #endif /* CONFIG_BLOCK */

+static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
+{
+	switch (osd_data->type) {
+	case CEPH_OSD_DATA_TYPE_NONE:
+		return 0;
+	case CEPH_OSD_DATA_TYPE_PAGES:
+		return osd_data->length;
+	case CEPH_OSD_DATA_TYPE_PAGELIST:
+		return (u64)osd_data->pagelist->length;
+#ifdef CONFIG_BLOCK
+	case CEPH_OSD_DATA_TYPE_BIO:
+		return (u64)osd_data->bio_length;
+#endif /* CONFIG_BLOCK */
+	default:
+		WARN(true, "unrecognized data type %d\n", (int)osd_data->type);
+		return 0;
+	}
+}
+
 static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
 {
 	if (osd_data->type != CEPH_OSD_DATA_TYPE_PAGES)
@@ -1887,17 +1906,19 @@ bad:
 static void ceph_osdc_msg_data_set(struct ceph_msg *msg,
 				struct ceph_osd_data *osd_data)
 {
+	u64 length = ceph_osd_data_length(osd_data);
+
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-		BUG_ON(osd_data->length > (u64) SIZE_MAX);
-		if (osd_data->length)
+		BUG_ON(length > (u64) SIZE_MAX);
+		if (length)
 			ceph_msg_data_set_pages(msg, osd_data->pages,
-				osd_data->length, osd_data->alignment);
+					length, osd_data->alignment);
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
-		BUG_ON(!osd_data->pagelist->length);
+		BUG_ON(!length);
 		ceph_msg_data_set_pagelist(msg, osd_data->pagelist);
 #ifdef CONFIG_BLOCK
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
-		ceph_msg_data_set_bio(msg, osd_data->bio, osd_data->bio_length);
+		ceph_msg_data_set_bio(msg, osd_data->bio, length);
 #endif
 	} else {
 		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
-- 
1.7.9.5

