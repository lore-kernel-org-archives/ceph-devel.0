From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: make message data be a pointer
Date: Tue, 12 Mar 2013 20:10:27 -0500
Message-ID: <513FD203.10401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:56327 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3CMBKa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:10:30 -0400
Received: by mail-oa0-f51.google.com with SMTP id h2so528982oag.38
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:10:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Begin the transition from a single message data item to a list of
them by replacing the "data" structure in a message with a pointer
to a ceph_msg_data structure.

A null pointer will indicate the message has no data; replace the
use of ceph_msg_has_data() with a simple check for a null pointer.

Create functions ceph_msg_data_create() and ceph_msg_data_destroy()
to dynamically allocate and free a data item structure of a given type.

When a message has its data item "set," allocate one of these to
hold the data description, and free it when the last reference to
the message is dropped.

This partially resolves:
    http://tracker.ceph.com/issues/4429

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    5 +--
 net/ceph/messenger.c           |   91
+++++++++++++++++++++++++++-------------
 2 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 686df5b..3181321 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -64,8 +64,6 @@ struct ceph_messenger {
 	u32 required_features;
 };

-#define ceph_msg_has_data(m)		((m)->data.type != CEPH_MSG_DATA_NONE)
-
 enum ceph_msg_data_type {
 	CEPH_MSG_DATA_NONE,	/* message contains no data payload */
 	CEPH_MSG_DATA_PAGES,	/* data source/destination is a page array */
@@ -141,8 +139,7 @@ struct ceph_msg {
 	struct kvec front;              /* unaligned blobs of message */
 	struct ceph_buffer *middle;

-	/* data payload */
-	struct ceph_msg_data	data;
+	struct ceph_msg_data	*data;	/* data payload */

 	struct ceph_connection *con;
 	struct list_head list_head;	/* links for connection lists */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8e07ac4..d703813 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1086,7 +1086,7 @@ static void prepare_message_data(struct ceph_msg *msg)

 	/* Initialize data cursors */

-	ceph_msg_data_cursor_init(&msg->data, data_len);
+	ceph_msg_data_cursor_init(msg->data, data_len);
 }

 /*
@@ -1388,13 +1388,13 @@ static u32 ceph_crc32c_page(u32 crc, struct page
*page,
 static int write_partial_message_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
-	struct ceph_msg_data_cursor *cursor = &msg->data.cursor;
+	struct ceph_msg_data_cursor *cursor = &msg->data->cursor;
 	bool do_datacrc = !con->msgr->nocrc;
 	u32 crc;

 	dout("%s %p msg %p\n", __func__, con, msg);

-	if (WARN_ON(!ceph_msg_has_data(msg)))
+	if (WARN_ON(!msg->data))
 		return -EINVAL;

 	/*
@@ -1414,7 +1414,7 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		bool need_crc;
 		int ret;

-		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
+		page = ceph_msg_data_next(msg->data, &page_offset, &length,
 							&last_piece);
 		if (do_datacrc && cursor->need_crc)
 			crc = ceph_crc32c_page(crc, page, page_offset, length);
@@ -1425,7 +1425,7 @@ static int write_partial_message_data(struct
ceph_connection *con)

 			return ret;
 		}
-		need_crc = ceph_msg_data_advance(&msg->data, (size_t) ret);
+		need_crc = ceph_msg_data_advance(msg->data, (size_t) ret);
 	}
 	msg->footer.data_crc = cpu_to_le32(crc);

@@ -2075,7 +2075,7 @@ static int read_partial_message_section(struct
ceph_connection *con,
 static int read_partial_msg_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->in_msg;
-	struct ceph_msg_data_cursor *cursor = &msg->data.cursor;
+	struct ceph_msg_data_cursor *cursor = &msg->data->cursor;
 	const bool do_datacrc = !con->msgr->nocrc;
 	struct page *page;
 	size_t page_offset;
@@ -2084,12 +2084,12 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 	int ret;

 	BUG_ON(!msg);
-	if (WARN_ON(!ceph_msg_has_data(msg)))
+	if (!msg->data)
 		return -EIO;

 	crc = con->in_data_crc;
 	while (cursor->resid) {
-		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
+		page = ceph_msg_data_next(msg->data, &page_offset, &length,
 							NULL);
 		ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
 		if (ret <= 0) {
@@ -2100,7 +2100,7 @@ static int read_partial_msg_data(struct
ceph_connection *con)

 		if (do_datacrc)
 			crc = ceph_crc32c_page(crc, page, page_offset, ret);
-		(void) ceph_msg_data_advance(&msg->data, (size_t) ret);
+		(void) ceph_msg_data_advance(msg->data, (size_t) ret);
 	}
 	con->in_data_crc = crc;

@@ -2910,44 +2910,80 @@ void ceph_con_keepalive(struct ceph_connection *con)
 }
 EXPORT_SYMBOL(ceph_con_keepalive);

-static void ceph_msg_data_init(struct ceph_msg_data *data)
+static struct ceph_msg_data *ceph_msg_data_create(enum
ceph_msg_data_type type)
 {
-	data->type = CEPH_MSG_DATA_NONE;
+	struct ceph_msg_data *data;
+
+	if (WARN_ON(!ceph_msg_data_type_valid(type)))
+		return NULL;
+
+	data = kzalloc(sizeof (*data), GFP_NOFS);
+	if (data)
+		data->type = type;
+
+	return data;
+}
+
+static void ceph_msg_data_destroy(struct ceph_msg_data *data)
+{
+	if (!data)
+		return;
+
+	if (data->type == CEPH_MSG_DATA_PAGELIST) {
+		ceph_pagelist_release(data->pagelist);
+		kfree(data->pagelist);
+	}
+	kfree(data);
 }

 void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page **pages,
 		size_t length, size_t alignment)
 {
+	struct ceph_msg_data *data;
+
 	BUG_ON(!pages);
 	BUG_ON(!length);
-	BUG_ON(msg->data.type != CEPH_MSG_DATA_NONE);
+	BUG_ON(msg->data != NULL);
+
+	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGES);
+	BUG_ON(!data);
+	data->pages = pages;
+	data->length = length;
+	data->alignment = alignment & ~PAGE_MASK;

-	msg->data.type = CEPH_MSG_DATA_PAGES;
-	msg->data.pages = pages;
-	msg->data.length = length;
-	msg->data.alignment = alignment & ~PAGE_MASK;
+	msg->data = data;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pages);

 void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
 				struct ceph_pagelist *pagelist)
 {
+	struct ceph_msg_data *data;
+
 	BUG_ON(!pagelist);
 	BUG_ON(!pagelist->length);
-	BUG_ON(msg->data.type != CEPH_MSG_DATA_NONE);
+	BUG_ON(msg->data != NULL);
+
+	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGELIST);
+	BUG_ON(!data);
+	data->pagelist = pagelist;

-	msg->data.type = CEPH_MSG_DATA_PAGELIST;
-	msg->data.pagelist = pagelist;
+	msg->data = data;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pagelist);

 void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio)
 {
+	struct ceph_msg_data *data;
+
 	BUG_ON(!bio);
-	BUG_ON(msg->data.type != CEPH_MSG_DATA_NONE);
+	BUG_ON(msg->data != NULL);
+
+	data = ceph_msg_data_create(CEPH_MSG_DATA_BIO);
+	BUG_ON(!data);
+	data->bio = bio;

-	msg->data.type = CEPH_MSG_DATA_BIO;
-	msg->data.bio = bio;
+	msg->data = data;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_bio);

@@ -2971,8 +3007,6 @@ struct ceph_msg *ceph_msg_new(int type, int
front_len, gfp_t flags,
 	INIT_LIST_HEAD(&m->list_head);
 	kref_init(&m->kref);

-	ceph_msg_data_init(&m->data);
-
 	/* front */
 	m->front_max = front_len;
 	if (front_len) {
@@ -3127,11 +3161,8 @@ void ceph_msg_last_put(struct kref *kref)
 		m->middle = NULL;
 	}

-	if (ceph_msg_has_data(m) && m->data.type == CEPH_MSG_DATA_PAGELIST) {
-		ceph_pagelist_release(m->data.pagelist);
-		kfree(m->data.pagelist);
-		m->data.pagelist = NULL;
-	}
+	ceph_msg_data_destroy(m->data);
+	m->data = NULL;

 	if (m->pool)
 		ceph_msgpool_put(m->pool, m);
@@ -3143,7 +3174,7 @@ EXPORT_SYMBOL(ceph_msg_last_put);
 void ceph_msg_dump(struct ceph_msg *msg)
 {
 	pr_debug("msg_dump %p (front_max %d length %zd)\n", msg,
-		 msg->front_max, msg->data.length);
+		 msg->front_max, msg->data->length);
 	print_hex_dump(KERN_DEBUG, "header: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       &msg->hdr, sizeof(msg->hdr), true);
-- 
1.7.9.5

