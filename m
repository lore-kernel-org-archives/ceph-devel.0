From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/8] libceph: define ceph_msg_has_*() data macros
Date: Sun, 10 Mar 2013 14:12:32 -0500
Message-ID: <513CDB20.7060703@inktank.com>
References: <513CD9BE.1070505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:60647 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab3CJTMg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 15:12:36 -0400
Received: by mail-ia0-f171.google.com with SMTP id z13so2995486iaz.30
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 12:12:35 -0700 (PDT)
In-Reply-To: <513CD9BE.1070505@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define and use macros ceph_msg_has_*() to determine whether to
operate on the pages, pagelist, bio, and trail fields of a message.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    7 +++++++
 net/ceph/messenger.c           |   44
++++++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1991a6f..889fe47 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -64,6 +64,13 @@ struct ceph_messenger {
 	u32 required_features;
 };

+#define ceph_msg_has_pages(m)		((m)->pages != NULL)
+#define ceph_msg_has_pagelist(m)	((m)->pagelist != NULL)
+#ifdef CONFIG_BLOCK
+#define ceph_msg_has_bio(m)		((m)->bio != NULL)
+#endif /* CONFIG_BLOCK */
+#define ceph_msg_has_trail(m)		((m)->trail != NULL)
+
 /*
  * a single message.  it contains a header (src, dest, message type, etc.),
  * footer (crc values, mainly), a "front" message body, and possibly a
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f70bc92..c74b528 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -746,12 +746,12 @@ static void prepare_message_data(struct ceph_msg *msg,

 	/* initialize page iterator */
 	msg_pos->page = 0;
-	if (msg->pages)
+	if (ceph_msg_has_pages(msg))
 		msg_pos->page_pos = msg->page_alignment;
 	else
 		msg_pos->page_pos = 0;
 #ifdef CONFIG_BLOCK
-	if (msg->bio)
+	if (ceph_msg_has_bio(msg))
 		init_bio_iter(msg->bio, &msg->bio_iter, &msg->bio_seg);
 #endif
 	msg_pos->data_pos = 0;
@@ -1052,14 +1052,16 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 	msg_pos->page_pos = 0;
 	msg_pos->page++;
 	msg_pos->did_page_crc = false;
-	if (in_trail)
+	if (in_trail) {
+		BUG_ON(!ceph_msg_has_trail(msg));
 		list_rotate_left(&msg->trail->head);
-	else if (msg->pagelist)
+	} else if (ceph_msg_has_pagelist(msg)) {
 		list_rotate_left(&msg->pagelist->head);
 #ifdef CONFIG_BLOCK
-	else if (msg->bio)
+	} else if (ceph_msg_has_bio(msg)) {
 		iter_bio_next(&msg->bio_iter, &msg->bio_seg);
 #endif
+	}
 }

 static void in_msg_pos_next(struct ceph_connection *con, size_t len,
@@ -1114,8 +1116,13 @@ static int write_partial_message_data(struct
ceph_connection *con)
 	int ret;
 	int total_max_write;
 	bool in_trail = false;
-	const size_t trail_len = (msg->trail ? msg->trail->length : 0);
-	const size_t trail_off = data_len - trail_len;
+	size_t trail_len = 0;
+	size_t trail_off = data_len;
+
+	if (ceph_msg_has_trail(msg)) {
+		trail_len = msg->trail->length;
+		trail_off -= trail_len;
+	}

 	dout("%s %p msg %p page %d offset %d\n", __func__,
 	     con, msg, msg_pos->page, msg_pos->page_pos);
@@ -1140,17 +1147,17 @@ static int write_partial_message_data(struct
ceph_connection *con)
 			total_max_write = trail_off - msg_pos->data_pos;

 		if (in_trail) {
+			BUG_ON(!ceph_msg_has_trail(msg));
 			total_max_write = data_len - msg_pos->data_pos;
-
 			page = list_first_entry(&msg->trail->head,
 						struct page, lru);
-		} else if (msg->pages) {
+		} else if (ceph_msg_has_pages(msg)) {
 			page = msg->pages[msg_pos->page];
-		} else if (msg->pagelist) {
+		} else if (ceph_msg_has_pagelist(msg)) {
 			page = list_first_entry(&msg->pagelist->head,
 						struct page, lru);
 #ifdef CONFIG_BLOCK
-		} else if (msg->bio) {
+		} else if (ceph_msg_has_bio(msg)) {
 			struct bio_vec *bv;

 			bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
@@ -1908,13 +1915,13 @@ static int read_partial_msg_data(struct
ceph_connection *con)

 	data_len = le32_to_cpu(con->in_hdr.data_len);
 	while (msg_pos->data_pos < data_len) {
-		if (msg->pages) {
+		if (ceph_msg_has_pages(msg)) {
 			ret = read_partial_message_pages(con, msg->pages,
 						 data_len, do_datacrc);
 			if (ret <= 0)
 				return ret;
 #ifdef CONFIG_BLOCK
-		} else if (msg->bio) {
+		} else if (ceph_msg_has_bio(msg)) {
 			ret = read_partial_message_bio(con,
 						 data_len, do_datacrc);
 			if (ret <= 0)
@@ -2946,16 +2953,19 @@ void ceph_msg_last_put(struct kref *kref)
 		ceph_buffer_put(m->middle);
 		m->middle = NULL;
 	}
-	m->length = 0;
-	m->pages = NULL;
+	if (ceph_msg_has_pages(m)) {
+		m->length = 0;
+		m->pages = NULL;
+	}

-	if (m->pagelist) {
+	if (ceph_msg_has_pagelist(m)) {
 		ceph_pagelist_release(m->pagelist);
 		kfree(m->pagelist);
 		m->pagelist = NULL;
 	}

-	m->trail = NULL;
+	if (ceph_msg_has_trail(m))
+		m->trail = NULL;

 	if (m->pool)
 		ceph_msgpool_put(m->pool, m);
-- 
1.7.9.5

