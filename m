From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/7] ceph: only set message data pointers if non-empty
Date: Sat, 09 Mar 2013 10:03:09 -0600
Message-ID: <513B5D3D.6020200@inktank.com>
References: <513B5CAF.4010702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46432 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692Ab3CIQDM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:03:12 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so3235325iea.14
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:03:11 -0800 (PST)
In-Reply-To: <513B5CAF.4010702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change it so we only assign outgoing data information for
messages if there is outgoing data to send.

This then allows us to add a few more (currently commented-out)
assertions.

This is related to:
    http://tracker.ceph.com/issues/4284

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Greg Farnum <greg@inktank.com>
---
 fs/ceph/mds_client.c  |   13 ++++++++++---
 net/ceph/messenger.c  |    4 ++++
 net/ceph/osd_client.c |    9 ++++++---
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ae9438f..4bef0ab 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1721,7 +1721,11 @@ static struct ceph_msg
*create_request_message(struct ceph_mds_client *mdsc,
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);

-	ceph_msg_data_set_pages(msg, req->r_pages, req->r_data_len, 0);
+	if (req->r_data_len) {
+		/* outbound data set only by ceph_sync_setxattr() */
+		BUG_ON(!req->r_pages);
+		ceph_msg_data_set_pages(msg, req->r_pages, req->r_data_len, 0);
+	}

 	msg->hdr.data_len = cpu_to_le32(req->r_data_len);
 	msg->hdr.data_off = cpu_to_le16(0);
@@ -2603,10 +2607,13 @@ static void send_mds_reconnect(struct
ceph_mds_client *mdsc,
 			goto fail;
 	}

-	ceph_msg_data_set_pagelist(reply, pagelist);
 	if (recon_state.flock)
 		reply->hdr.version = cpu_to_le16(2);
-	reply->hdr.data_len = cpu_to_le32(pagelist->length);
+	if (pagelist->length) {
+		/* set up outbound data if we have any */
+		reply->hdr.data_len = cpu_to_le32(pagelist->length);
+		ceph_msg_data_set_pagelist(reply, pagelist);
+	}
 	ceph_con_send(&session->s_con, reply);

 	mutex_unlock(&session->s_mutex);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d118353..1965d78 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2692,6 +2692,8 @@ EXPORT_SYMBOL(ceph_con_keepalive);
 void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page **pages,
 		size_t length, size_t alignment)
 {
+	/* BUG_ON(!pages); */
+	/* BUG_ON(!length); */
 	/* BUG_ON(msg->pages); */
 	/* BUG_ON(msg->page_count); */

@@ -2705,6 +2707,7 @@ void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
 				struct ceph_pagelist *pagelist)
 {
 	/* BUG_ON(!pagelist); */
+	/* BUG_ON(!pagelist->length); */
 	/* BUG_ON(msg->pagelist); */

 	msg->pagelist = pagelist;
@@ -2723,6 +2726,7 @@ EXPORT_SYMBOL(ceph_msg_data_set_bio);
 void ceph_msg_data_set_trail(struct ceph_msg *msg, struct ceph_pagelist
*trail)
 {
 	/* BUG_ON(!trail); */
+	/* BUG_ON(!trail->length); */
 	/* BUG_ON(msg->trail); */

 	msg->trail = trail;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 387e312..4402e91 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1759,8 +1759,10 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,
 	osd_data = &req->r_data_out;
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
 		BUG_ON(osd_data->length > (u64) SIZE_MAX);
-		ceph_msg_data_set_pages(req->r_request, osd_data->pages,
-			osd_data->length, osd_data->alignment);
+		if (osd_data->length)
+			ceph_msg_data_set_pages(req->r_request,
+				osd_data->pages, osd_data->length,
+				osd_data->alignment);
 #ifdef CONFIG_BLOCK
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
 		ceph_msg_data_set_bio(req->r_request, osd_data->bio);
@@ -1768,7 +1770,8 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,
 	} else {
 		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
 	}
-	ceph_msg_data_set_trail(req->r_request, &req->r_trail);
+	if (req->r_trail.length)
+		ceph_msg_data_set_trail(req->r_request, &req->r_trail);

 	register_request(osdc, req);

-- 
1.7.9.5

