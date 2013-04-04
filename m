From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/9] libceph: record message data length
Date: Thu, 04 Apr 2013 11:19:04 -0500
Message-ID: <515DA7F8.7030508@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:57732 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762531Ab3DDQTH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 12:19:07 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so3294007ieb.9
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 09:19:07 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Keep track of the length of the data portion for a message in a
separate field in the ceph_msg structure.  This information has
been maintained in wire byte order in the message header, but
that's going to change soon.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    4 +++-
 net/ceph/messenger.c           |    9 ++++++++-
 net/ceph/osd_client.c          |    2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 3181321..b832c0c 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -139,6 +139,7 @@ struct ceph_msg {
 	struct kvec front;              /* unaligned blobs of message */
 	struct ceph_buffer *middle;

+	size_t			data_length;
 	struct ceph_msg_data	*data;	/* data payload */

 	struct ceph_connection *con;
@@ -270,7 +271,8 @@ extern void ceph_msg_data_set_pages(struct ceph_msg
*msg, struct page **pages,
 				size_t length, size_t alignment);
 extern void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
 				struct ceph_pagelist *pagelist);
-extern void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio);
+extern void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio,
+				size_t length);

 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index ee16086..7812c33 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2981,6 +2981,7 @@ void ceph_msg_data_set_pages(struct ceph_msg *msg,
struct page **pages,

 	BUG_ON(!pages);
 	BUG_ON(!length);
+	BUG_ON(msg->data_length);
 	BUG_ON(msg->data != NULL);

 	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGES);
@@ -2990,6 +2991,7 @@ void ceph_msg_data_set_pages(struct ceph_msg *msg,
struct page **pages,
 	data->alignment = alignment & ~PAGE_MASK;

 	msg->data = data;
+	msg->data_length = length;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pages);

@@ -3000,6 +3002,7 @@ void ceph_msg_data_set_pagelist(struct ceph_msg *msg,

 	BUG_ON(!pagelist);
 	BUG_ON(!pagelist->length);
+	BUG_ON(msg->data_length);
 	BUG_ON(msg->data != NULL);

 	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGELIST);
@@ -3007,14 +3010,17 @@ void ceph_msg_data_set_pagelist(struct ceph_msg
*msg,
 	data->pagelist = pagelist;

 	msg->data = data;
+	msg->data_length = pagelist->length;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pagelist);

-void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio)
+void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio,
+		size_t length)
 {
 	struct ceph_msg_data *data;

 	BUG_ON(!bio);
+	BUG_ON(msg->data_length);
 	BUG_ON(msg->data != NULL);

 	data = ceph_msg_data_create(CEPH_MSG_DATA_BIO);
@@ -3022,6 +3028,7 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
struct bio *bio)
 	data->bio = bio;

 	msg->data = data;
+	msg->data_length = length;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_bio);

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e088792..0b4951e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1848,7 +1848,7 @@ static void ceph_osdc_msg_data_set(struct ceph_msg
*msg,
 		ceph_msg_data_set_pagelist(msg, osd_data->pagelist);
 #ifdef CONFIG_BLOCK
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
-		ceph_msg_data_set_bio(msg, osd_data->bio);
+		ceph_msg_data_set_bio(msg, osd_data->bio, osd_data->bio_length);
 #endif
 	} else {
 		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
-- 
1.7.9.5

