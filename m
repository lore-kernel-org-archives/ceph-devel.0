From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/7] libceph: set page info with byte length
Date: Sat, 09 Mar 2013 10:02:43 -0600
Message-ID: <513B5D23.70203@inktank.com>
References: <513B5CAF.4010702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:38109 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932811Ab3CIQCq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:02:46 -0500
Received: by mail-ia0-f177.google.com with SMTP id y25so2382616iay.22
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:02:45 -0800 (PST)
In-Reply-To: <513B5CAF.4010702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When setting page array information for message data, provide the
byte length rather than the page count ceph_msg_data_set_pages().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/mds_client.c           |    2 +-
 include/linux/ceph/messenger.h |    2 +-
 net/ceph/messenger.c           |    4 ++--
 net/ceph/osd_client.c          |   14 ++++----------
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2b2991c..bfc28ee 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1721,7 +1721,7 @@ static struct ceph_msg
*create_request_message(struct ceph_mds_client *mdsc,
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);

-	ceph_msg_data_set_pages(msg, req->r_pages, req->r_num_pages, 0);
+	ceph_msg_data_set_pages(msg, req->r_pages, req->r_data_len, 0);

 	msg->hdr.data_len = cpu_to_le32(req->r_data_len);
 	msg->hdr.data_off = cpu_to_le16(0);
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index aa463b9..e6d20e8 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -220,7 +220,7 @@ extern void ceph_msg_revoke_incoming(struct ceph_msg
*msg);
 extern void ceph_con_keepalive(struct ceph_connection *con);

 extern void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page
**pages,
-				unsigned int page_count, size_t alignment);
+				size_t length, size_t alignment);

 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index cec39cb..fc59fcc 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2690,13 +2690,13 @@ void ceph_con_keepalive(struct ceph_connection *con)
 EXPORT_SYMBOL(ceph_con_keepalive);

 void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page **pages,
-		unsigned int page_count, size_t alignment)
+		size_t length, size_t alignment)
 {
 	/* BUG_ON(msg->pages); */
 	/* BUG_ON(msg->page_count); */

 	msg->pages = pages;
-	msg->page_count = page_count;
+	msg->page_count = calc_pages_for((u64)alignment, (u64)length);
 	msg->page_alignment = alignment & ~PAGE_MASK;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pages);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a09d571..f29beda 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1758,12 +1758,9 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,

 	osd_data = &req->r_data_out;
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-		unsigned int page_count;
-
-		page_count = calc_pages_for((u64)osd_data->alignment,
-						(u64)osd_data->length);
+		BUG_ON(osd_data->length > (u64) SIZE_MAX);
 		ceph_msg_data_set_pages(req->r_request, osd_data->pages,
-			page_count, osd_data->alignment);
+			osd_data->length, osd_data->alignment);
 #ifdef CONFIG_BLOCK
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
 		req->r_request->bio = osd_data->bio;
@@ -2119,8 +2116,6 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 		struct ceph_osd_data *osd_data = &req->r_data_in;

 		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-			unsigned int page_count;
-
 			if (osd_data->pages &&
 				unlikely(osd_data->length < data_len)) {

@@ -2132,10 +2127,9 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 				m = NULL;
 				goto out;
 			}
-			page_count = calc_pages_for((u64)osd_data->alignment,
-							(u64)osd_data->length);
+			BUG_ON(osd_data->length > (u64) SIZE_MAX);
 			ceph_msg_data_set_pages(m, osd_data->pages,
-				osd_data->num_pages, osd_data->alignment);
+				osd_data->length, osd_data->alignment);
 #ifdef CONFIG_BLOCK
 		} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
 			m->bio = osd_data->bio;
-- 
1.7.9.5

