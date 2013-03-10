From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/8] libceph: abstract message data
Date: Sun, 10 Mar 2013 14:15:50 -0500
Message-ID: <513CDBE6.8040409@inktank.com>
References: <513CD9BE.1070505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:38470 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab3CJTPy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 15:15:54 -0400
Received: by mail-ia0-f171.google.com with SMTP id z13so2979775iaz.16
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 12:15:53 -0700 (PDT)
In-Reply-To: <513CD9BE.1070505@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A ceph message has a data payload portion.  The memory for that data
(either the source of data to send or the location to place data
that is received) is specified in several ways.  The ceph_msg
structure includes fields for all of those ways, but this
mispresents the fact that not all of them are used at a time.

Specifically, the data in a message can be in:
    - an array of pages
    - a list of pages
    - a list of Linux bios
    - a second list of pages (the "trail")
(The two page lists are currently only ever used for outgoing data.)

Impose more structure on the ceph message, making the grouping of
some of these fields explicit.  Shorten the name of the
"page_alignment" field.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |   33 ++++++++++++-------
 net/ceph/messenger.c           |   68
++++++++++++++++++++--------------------
 2 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 889fe47..fb2b18a 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -64,12 +64,12 @@ struct ceph_messenger {
 	u32 required_features;
 };

-#define ceph_msg_has_pages(m)		((m)->pages != NULL)
-#define ceph_msg_has_pagelist(m)	((m)->pagelist != NULL)
+#define ceph_msg_has_pages(m)		((m)->p.pages != NULL)
+#define ceph_msg_has_pagelist(m)	((m)->l.pagelist != NULL)
 #ifdef CONFIG_BLOCK
-#define ceph_msg_has_bio(m)		((m)->bio != NULL)
+#define ceph_msg_has_bio(m)		((m)->b.bio != NULL)
 #endif /* CONFIG_BLOCK */
-#define ceph_msg_has_trail(m)		((m)->trail != NULL)
+#define ceph_msg_has_trail(m)		((m)->t.trail != NULL)

 /*
  * a single message.  it contains a header (src, dest, message type, etc.),
@@ -82,16 +82,25 @@ struct ceph_msg {
 	struct kvec front;              /* unaligned blobs of message */
 	struct ceph_buffer *middle;

-	struct page **pages;		/* data payload.  NOT OWNER. */
-	unsigned int page_alignment;	/* io offset in first page */
-	size_t length;			/* # data bytes in array or list */
-	struct ceph_pagelist *pagelist; /* instead of pages */
+	/* data payload */
+	struct {
+		struct page	**pages;	/* NOT OWNER. */
+		size_t		length;		/* # data bytes in array */
+		unsigned int	alignment;	/* first page */
+	} p;
+	struct {
+		struct ceph_pagelist	*pagelist;
+	} l;
 #ifdef CONFIG_BLOCK
-	unsigned int bio_seg;		/* current bio segment */
-	struct bio  *bio;		/* instead of pages/pagelist */
-	struct bio  *bio_iter;		/* bio iterator */
+	struct {
+		struct bio	*bio_iter;	/* iterator */
+		struct bio	*bio;
+		unsigned int	bio_seg;	/* current seg in bio */
+	} b;
 #endif /* CONFIG_BLOCK */
-	struct ceph_pagelist *trail;	/* the trailing part of the data */
+	struct {
+		struct ceph_pagelist *trail;	/* trailing part of data */
+	} t;

 	struct ceph_connection *con;
 	struct list_head list_head;	/* links for connection lists */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c74b528..f485455 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -747,12 +747,12 @@ static void prepare_message_data(struct ceph_msg *msg,
 	/* initialize page iterator */
 	msg_pos->page = 0;
 	if (ceph_msg_has_pages(msg))
-		msg_pos->page_pos = msg->page_alignment;
+		msg_pos->page_pos = msg->p.alignment;
 	else
 		msg_pos->page_pos = 0;
 #ifdef CONFIG_BLOCK
 	if (ceph_msg_has_bio(msg))
-		init_bio_iter(msg->bio, &msg->bio_iter, &msg->bio_seg);
+		init_bio_iter(msg->b.bio, &msg->b.bio_iter, &msg->b.bio_seg);
 #endif
 	msg_pos->data_pos = 0;
 	msg_pos->did_page_crc = false;
@@ -822,7 +822,7 @@ static void prepare_write_message(struct
ceph_connection *con)
 	dout("prepare_write_message %p seq %lld type %d len %d+%d+%d (%zd)\n",
 	     m, con->out_seq, le16_to_cpu(m->hdr.type),
 	     le32_to_cpu(m->hdr.front_len), le32_to_cpu(m->hdr.middle_len),
-	     le32_to_cpu(m->hdr.data_len), m->length);
+	     le32_to_cpu(m->hdr.data_len), m->p.length);
 	BUG_ON(le32_to_cpu(m->hdr.front_len) != m->front.iov_len);

 	/* tag + hdr + front + middle */
@@ -1054,12 +1054,12 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 	msg_pos->did_page_crc = false;
 	if (in_trail) {
 		BUG_ON(!ceph_msg_has_trail(msg));
-		list_rotate_left(&msg->trail->head);
+		list_rotate_left(&msg->t.trail->head);
 	} else if (ceph_msg_has_pagelist(msg)) {
-		list_rotate_left(&msg->pagelist->head);
+		list_rotate_left(&msg->l.pagelist->head);
 #ifdef CONFIG_BLOCK
 	} else if (ceph_msg_has_bio(msg)) {
-		iter_bio_next(&msg->bio_iter, &msg->bio_seg);
+		iter_bio_next(&msg->b.bio_iter, &msg->b.bio_seg);
 #endif
 	}
 }
@@ -1082,8 +1082,8 @@ static void in_msg_pos_next(struct ceph_connection
*con, size_t len,
 	msg_pos->page_pos = 0;
 	msg_pos->page++;
 #ifdef CONFIG_BLOCK
-	if (msg->bio)
-		iter_bio_next(&msg->bio_iter, &msg->bio_seg);
+	if (msg->b.bio)
+		iter_bio_next(&msg->b.bio_iter, &msg->b.bio_seg);
 #endif /* CONFIG_BLOCK */
 }

@@ -1120,7 +1120,7 @@ static int write_partial_message_data(struct
ceph_connection *con)
 	size_t trail_off = data_len;

 	if (ceph_msg_has_trail(msg)) {
-		trail_len = msg->trail->length;
+		trail_len = msg->t.trail->length;
 		trail_off -= trail_len;
 	}

@@ -1149,18 +1149,18 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		if (in_trail) {
 			BUG_ON(!ceph_msg_has_trail(msg));
 			total_max_write = data_len - msg_pos->data_pos;
-			page = list_first_entry(&msg->trail->head,
+			page = list_first_entry(&msg->t.trail->head,
 						struct page, lru);
 		} else if (ceph_msg_has_pages(msg)) {
-			page = msg->pages[msg_pos->page];
+			page = msg->p.pages[msg_pos->page];
 		} else if (ceph_msg_has_pagelist(msg)) {
-			page = list_first_entry(&msg->pagelist->head,
+			page = list_first_entry(&msg->l.pagelist->head,
 						struct page, lru);
 #ifdef CONFIG_BLOCK
 		} else if (ceph_msg_has_bio(msg)) {
 			struct bio_vec *bv;

-			bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
+			bv = bio_iovec_idx(msg->b.bio_iter, msg->b.bio_seg);
 			page = bv->bv_page;
 			bio_offset = bv->bv_offset;
 			max_write = bv->bv_len;
@@ -1880,8 +1880,8 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 	int ret;

 	BUG_ON(!msg);
-	BUG_ON(!msg->bio_iter);
-	bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
+	BUG_ON(!msg->b.bio_iter);
+	bv = bio_iovec_idx(msg->b.bio_iter, msg->b.bio_seg);
 	page = bv->bv_page;
 	page_offset = bv->bv_offset + msg_pos->page_pos;
 	BUG_ON(msg_pos->data_pos >= data_len);
@@ -1916,7 +1916,7 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 	data_len = le32_to_cpu(con->in_hdr.data_len);
 	while (msg_pos->data_pos < data_len) {
 		if (ceph_msg_has_pages(msg)) {
-			ret = read_partial_message_pages(con, msg->pages,
+			ret = read_partial_message_pages(con, msg->p.pages,
 						 data_len, do_datacrc);
 			if (ret <= 0)
 				return ret;
@@ -2741,12 +2741,12 @@ void ceph_msg_data_set_pages(struct ceph_msg
*msg, struct page **pages,
 {
 	BUG_ON(!pages);
 	BUG_ON(!length);
-	BUG_ON(msg->pages);
-	BUG_ON(msg->length);
+	BUG_ON(msg->p.pages);
+	BUG_ON(msg->p.length);

-	msg->pages = pages;
-	msg->length = length;
-	msg->page_alignment = alignment & ~PAGE_MASK;
+	msg->p.pages = pages;
+	msg->p.length = length;
+	msg->p.alignment = alignment & ~PAGE_MASK;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pages);

@@ -2755,18 +2755,18 @@ void ceph_msg_data_set_pagelist(struct ceph_msg
*msg,
 {
 	BUG_ON(!pagelist);
 	BUG_ON(!pagelist->length);
-	BUG_ON(msg->pagelist);
+	BUG_ON(msg->l.pagelist);

-	msg->pagelist = pagelist;
+	msg->l.pagelist = pagelist;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pagelist);

 void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio)
 {
 	BUG_ON(!bio);
-	BUG_ON(msg->bio);
+	BUG_ON(msg->b.bio);

-	msg->bio = bio;
+	msg->b.bio = bio;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_bio);

@@ -2774,9 +2774,9 @@ void ceph_msg_data_set_trail(struct ceph_msg *msg,
struct ceph_pagelist *trail)
 {
 	BUG_ON(!trail);
 	BUG_ON(!trail->length);
-	BUG_ON(msg->trail);
+	BUG_ON(msg->t.trail);

-	msg->trail = trail;
+	msg->t.trail = trail;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_trail);

@@ -2954,18 +2954,18 @@ void ceph_msg_last_put(struct kref *kref)
 		m->middle = NULL;
 	}
 	if (ceph_msg_has_pages(m)) {
-		m->length = 0;
-		m->pages = NULL;
+		m->p.length = 0;
+		m->p.pages = NULL;
 	}

 	if (ceph_msg_has_pagelist(m)) {
-		ceph_pagelist_release(m->pagelist);
-		kfree(m->pagelist);
-		m->pagelist = NULL;
+		ceph_pagelist_release(m->l.pagelist);
+		kfree(m->l.pagelist);
+		m->l.pagelist = NULL;
 	}

 	if (ceph_msg_has_trail(m))
-		m->trail = NULL;
+		m->t.trail = NULL;

 	if (m->pool)
 		ceph_msgpool_put(m->pool, m);
@@ -2977,7 +2977,7 @@ EXPORT_SYMBOL(ceph_msg_last_put);
 void ceph_msg_dump(struct ceph_msg *msg)
 {
 	pr_debug("msg_dump %p (front_max %d length %zd)\n", msg,
-		 msg->front_max, msg->length);
+		 msg->front_max, msg->p.length);
 	print_hex_dump(KERN_DEBUG, "header: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       &msg->hdr, sizeof(msg->hdr), true);
-- 
1.7.9.5

