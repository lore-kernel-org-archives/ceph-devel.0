From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/6] libceph: replace message data pointer with list
Date: Fri, 05 Apr 2013 17:26:09 -0500
Message-ID: <515F4F81.5090302@inktank.com>
References: <515F4F01.2000704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58713 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163044Ab3DEW0M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 18:26:12 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so4949666iec.18
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 15:26:11 -0700 (PDT)
In-Reply-To: <515F4F01.2000704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In place of the message data pointer, use a list head which links
through message data items.  For now we only support a single entry
on that list.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    3 ++-
 net/ceph/messenger.c           |   46
+++++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 8846ff6..318da01 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -89,6 +89,7 @@ static __inline__ bool ceph_msg_data_type_valid(enum
ceph_msg_data_type type)
 }

 struct ceph_msg_data {
+	struct list_head		links;	/* ceph_msg->data */
 	enum ceph_msg_data_type		type;
 	union {
 #ifdef CONFIG_BLOCK
@@ -143,7 +144,7 @@ struct ceph_msg {
 	struct ceph_buffer *middle;

 	size_t				data_length;
-	struct ceph_msg_data		*data;
+	struct list_head		data;
 	struct ceph_msg_data_cursor	cursor;

 	struct ceph_connection *con;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 50b4093..9ce667e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -985,8 +985,10 @@ static bool ceph_msg_data_pagelist_advance(struct
ceph_msg_data_cursor *cursor,
 static void ceph_msg_data_cursor_init(struct ceph_msg *msg, size_t length)
 {
 	struct ceph_msg_data_cursor *cursor = &msg->cursor;
+	struct ceph_msg_data *data;

-	cursor->data = msg->data;
+	data = list_first_entry(&msg->data, struct ceph_msg_data, links);
+	cursor->data = data;
 	switch (cursor->data->type) {
 	case CEPH_MSG_DATA_PAGELIST:
 		ceph_msg_data_pagelist_cursor_init(cursor, length);
@@ -1410,7 +1412,7 @@ static int write_partial_message_data(struct
ceph_connection *con)

 	dout("%s %p msg %p\n", __func__, con, msg);

-	if (WARN_ON(!msg->data))
+	if (list_empty(&msg->data))
 		return -EINVAL;

 	/*
@@ -2111,7 +2113,7 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 	int ret;

 	BUG_ON(!msg);
-	if (!msg->data)
+	if (list_empty(&msg->data))
 		return -EIO;

 	if (do_datacrc)
@@ -2961,6 +2963,7 @@ static struct ceph_msg_data
*ceph_msg_data_create(enum ceph_msg_data_type type)
 	data = kzalloc(sizeof (*data), GFP_NOFS);
 	if (data)
 		data->type = type;
+	INIT_LIST_HEAD(&data->links);

 	return data;
 }
@@ -2970,6 +2973,7 @@ static void ceph_msg_data_destroy(struct
ceph_msg_data *data)
 	if (!data)
 		return;

+	WARN_ON(!list_empty(&data->links));
 	if (data->type == CEPH_MSG_DATA_PAGELIST) {
 		ceph_pagelist_release(data->pagelist);
 		kfree(data->pagelist);
@@ -2985,7 +2989,7 @@ void ceph_msg_data_set_pages(struct ceph_msg *msg,
struct page **pages,
 	BUG_ON(!pages);
 	BUG_ON(!length);
 	BUG_ON(msg->data_length);
-	BUG_ON(msg->data != NULL);
+	BUG_ON(!list_empty(&msg->data));

 	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGES);
 	BUG_ON(!data);
@@ -2993,8 +2997,9 @@ void ceph_msg_data_set_pages(struct ceph_msg *msg,
struct page **pages,
 	data->length = length;
 	data->alignment = alignment & ~PAGE_MASK;

-	msg->data = data;
-	msg->data_length = length;
+	BUG_ON(!list_empty(&msg->data));
+	list_add_tail(&data->links, &msg->data);
+	msg->data_length += length;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pages);

@@ -3006,14 +3011,14 @@ void ceph_msg_data_set_pagelist(struct ceph_msg
*msg,
 	BUG_ON(!pagelist);
 	BUG_ON(!pagelist->length);
 	BUG_ON(msg->data_length);
-	BUG_ON(msg->data != NULL);
+	BUG_ON(!list_empty(&msg->data));

 	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGELIST);
 	BUG_ON(!data);
 	data->pagelist = pagelist;

-	msg->data = data;
-	msg->data_length = pagelist->length;
+	list_add_tail(&data->links, &msg->data);
+	msg->data_length += pagelist->length;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pagelist);

@@ -3025,15 +3030,15 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
struct bio *bio,

 	BUG_ON(!bio);
 	BUG_ON(msg->data_length);
-	BUG_ON(msg->data != NULL);
+	BUG_ON(!list_empty(&msg->data));

 	data = ceph_msg_data_create(CEPH_MSG_DATA_BIO);
 	BUG_ON(!data);
 	data->bio = bio;
 	data->bio_length = length;

-	msg->data = data;
-	msg->data_length = length;
+	list_add_tail(&data->links, &msg->data);
+	msg->data_length += length;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_bio);
 #endif	/* CONFIG_BLOCK */
@@ -3057,6 +3062,7 @@ struct ceph_msg *ceph_msg_new(int type, int
front_len, gfp_t flags,

 	INIT_LIST_HEAD(&m->list_head);
 	kref_init(&m->kref);
+	INIT_LIST_HEAD(&m->data);

 	/* front */
 	m->front_max = front_len;
@@ -3202,6 +3208,9 @@ void ceph_msg_kfree(struct ceph_msg *m)
 void ceph_msg_last_put(struct kref *kref)
 {
 	struct ceph_msg *m = container_of(kref, struct ceph_msg, kref);
+	LIST_HEAD(data);
+	struct list_head *links;
+	struct list_head *next;

 	dout("ceph_msg_put last one on %p\n", m);
 	WARN_ON(!list_empty(&m->list_head));
@@ -3211,8 +3220,15 @@ void ceph_msg_last_put(struct kref *kref)
 		ceph_buffer_put(m->middle);
 		m->middle = NULL;
 	}
-	ceph_msg_data_destroy(m->data);
-	m->data = NULL;
+
+	list_splice_init(&m->data, &data);
+	list_for_each_safe(links, next, &data) {
+		struct ceph_msg_data *data;
+
+		data = list_entry(links, struct ceph_msg_data, links);
+		list_del_init(links);
+		ceph_msg_data_destroy(data);
+	}
 	m->data_length = 0;

 	if (m->pool)
@@ -3225,7 +3241,7 @@ EXPORT_SYMBOL(ceph_msg_last_put);
 void ceph_msg_dump(struct ceph_msg *msg)
 {
 	pr_debug("msg_dump %p (front_max %d length %zd)\n", msg,
-		 msg->front_max, msg->data->length);
+		 msg->front_max, msg->data_length);
 	print_hex_dump(KERN_DEBUG, "header: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       &msg->hdr, sizeof(msg->hdr), true);
-- 
1.7.9.5

