From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/6] libceph: have cursor point to data
Date: Fri, 05 Apr 2013 17:25:53 -0500
Message-ID: <515F4F71.4060601@inktank.com>
References: <515F4F01.2000704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:43524 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163044Ab3DEWZz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 18:25:55 -0400
Received: by mail-ia0-f170.google.com with SMTP id h8so3675120iaa.29
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 15:25:55 -0700 (PDT)
In-Reply-To: <515F4F01.2000704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Rather than having a ceph message data item point to the cursor it's
associated with, have the cursor point to a data item.  This will
allow a message cursor to be used for more than one data item.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    8 +--
 net/ceph/messenger.c           |  113
+++++++++++++++++++---------------------
 2 files changed, 59 insertions(+), 62 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index e755724..8846ff6 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -104,13 +104,13 @@ struct ceph_msg_data {
 		};
 		struct ceph_pagelist	*pagelist;
 	};
-	struct ceph_msg_data_cursor	*cursor;
 };

 struct ceph_msg_data_cursor {
-	size_t		resid;		/* bytes not yet consumed */
-	bool		last_piece;	/* now at last piece of data item */
-	bool		need_crc;	/* new piece; crc update needed */
+	struct ceph_msg_data	*data;		/* data item this describes */
+	size_t			resid;		/* bytes not yet consumed */
+	bool			last_piece;	/* current is last piece */
+	bool			need_crc;	/* crc update needed */
 	union {
 #ifdef CONFIG_BLOCK
 		struct {				/* bio */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 287b7fb..50b4093 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -722,10 +722,10 @@ static void con_out_kvec_add(struct
ceph_connection *con,
  * entry in the current bio iovec, or the first entry in the next
  * bio in the list.
  */
-static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data *data,
+static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data_cursor
*cursor,
 					size_t length)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
+	struct ceph_msg_data *data = cursor->data;
 	struct bio *bio;

 	BUG_ON(data->type != CEPH_MSG_DATA_BIO);
@@ -741,11 +741,11 @@ static void ceph_msg_data_bio_cursor_init(struct
ceph_msg_data *data,
 	cursor->last_piece = length <= bio->bi_io_vec[0].bv_len;
 }

-static struct page *ceph_msg_data_bio_next(struct ceph_msg_data *data,
+static struct page *ceph_msg_data_bio_next(struct ceph_msg_data_cursor
*cursor,
 						size_t *page_offset,
 						size_t *length)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
+	struct ceph_msg_data *data = cursor->data;
 	struct bio *bio;
 	struct bio_vec *bio_vec;
 	unsigned int index;
@@ -772,14 +772,14 @@ static struct page *ceph_msg_data_bio_next(struct
ceph_msg_data *data,
 	return bio_vec->bv_page;
 }

-static bool ceph_msg_data_bio_advance(struct ceph_msg_data *data,
size_t bytes)
+static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
+					size_t bytes)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
 	struct bio *bio;
 	struct bio_vec *bio_vec;
 	unsigned int index;

-	BUG_ON(data->type != CEPH_MSG_DATA_BIO);
+	BUG_ON(cursor->data->type != CEPH_MSG_DATA_BIO);

 	bio = cursor->bio;
 	BUG_ON(!bio);
@@ -823,10 +823,10 @@ static bool ceph_msg_data_bio_advance(struct
ceph_msg_data *data, size_t bytes)
  * For a page array, a piece comes from the first page in the array
  * that has not already been fully consumed.
  */
-static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data *data,
+static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data_cursor
*cursor,
 					size_t length)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
+	struct ceph_msg_data *data = cursor->data;
 	int page_count;

 	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
@@ -845,11 +845,11 @@ static void ceph_msg_data_pages_cursor_init(struct
ceph_msg_data *data,
 	cursor->last_piece = (size_t)cursor->page_offset + length <= PAGE_SIZE;
 }

-static struct page *ceph_msg_data_pages_next(struct ceph_msg_data *data,
-					size_t *page_offset,
-					size_t *length)
+static struct page *
+ceph_msg_data_pages_next(struct ceph_msg_data_cursor *cursor,
+					size_t *page_offset, size_t *length)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
+	struct ceph_msg_data *data = cursor->data;

 	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);

@@ -865,12 +865,10 @@ static struct page
*ceph_msg_data_pages_next(struct ceph_msg_data *data,
 	return data->pages[cursor->page_index];
 }

-static bool ceph_msg_data_pages_advance(struct ceph_msg_data *data,
+static bool ceph_msg_data_pages_advance(struct ceph_msg_data_cursor
*cursor,
 						size_t bytes)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
-
-	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
+	BUG_ON(cursor->data->type != CEPH_MSG_DATA_PAGES);

 	BUG_ON(cursor->page_offset + bytes > PAGE_SIZE);

@@ -894,10 +892,11 @@ static bool ceph_msg_data_pages_advance(struct
ceph_msg_data *data,
  * For a pagelist, a piece is whatever remains to be consumed in the
  * first page in the list, or the front of the next page.
  */
-static void ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data *data,
+static void
+ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data_cursor *cursor,
 					size_t length)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
+	struct ceph_msg_data *data = cursor->data;
 	struct ceph_pagelist *pagelist;
 	struct page *page;

@@ -919,11 +918,11 @@ static void
ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data *data,
 	cursor->last_piece = length <= PAGE_SIZE;
 }

-static struct page *ceph_msg_data_pagelist_next(struct ceph_msg_data *data,
-						size_t *page_offset,
-						size_t *length)
+static struct page *
+ceph_msg_data_pagelist_next(struct ceph_msg_data_cursor *cursor,
+				size_t *page_offset, size_t *length)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
+	struct ceph_msg_data *data = cursor->data;
 	struct ceph_pagelist *pagelist;

 	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);
@@ -941,13 +940,13 @@ static struct page
*ceph_msg_data_pagelist_next(struct ceph_msg_data *data,
 	else
 		*length = PAGE_SIZE - *page_offset;

-	return data->cursor->page;
+	return cursor->page;
 }

-static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data *data,
+static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor
*cursor,
 						size_t bytes)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
+	struct ceph_msg_data *data = cursor->data;
 	struct ceph_pagelist *pagelist;

 	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);
@@ -983,19 +982,21 @@ static bool ceph_msg_data_pagelist_advance(struct
ceph_msg_data *data,
  * be processed in that piece.  It also tracks whether the current
  * piece is the last one in the data item.
  */
-static void ceph_msg_data_cursor_init(struct ceph_msg_data *data,
-					size_t length)
+static void ceph_msg_data_cursor_init(struct ceph_msg *msg, size_t length)
 {
-	switch (data->type) {
+	struct ceph_msg_data_cursor *cursor = &msg->cursor;
+
+	cursor->data = msg->data;
+	switch (cursor->data->type) {
 	case CEPH_MSG_DATA_PAGELIST:
-		ceph_msg_data_pagelist_cursor_init(data, length);
+		ceph_msg_data_pagelist_cursor_init(cursor, length);
 		break;
 	case CEPH_MSG_DATA_PAGES:
-		ceph_msg_data_pages_cursor_init(data, length);
+		ceph_msg_data_pages_cursor_init(cursor, length);
 		break;
 #ifdef CONFIG_BLOCK
 	case CEPH_MSG_DATA_BIO:
-		ceph_msg_data_bio_cursor_init(data, length);
+		ceph_msg_data_bio_cursor_init(cursor, length);
 		break;
 #endif /* CONFIG_BLOCK */
 	case CEPH_MSG_DATA_NONE:
@@ -1003,7 +1004,7 @@ static void ceph_msg_data_cursor_init(struct
ceph_msg_data *data,
 		/* BUG(); */
 		break;
 	}
-	data->cursor->need_crc = true;
+	cursor->need_crc = true;
 }

 /*
@@ -1011,23 +1012,22 @@ static void ceph_msg_data_cursor_init(struct
ceph_msg_data *data,
  * data item, and supply the page offset and length of that piece.
  * Indicate whether this is the last piece in this data item.
  */
-static struct page *ceph_msg_data_next(struct ceph_msg_data *data,
-					size_t *page_offset,
-					size_t *length,
+static struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
+					size_t *page_offset, size_t *length,
 					bool *last_piece)
 {
 	struct page *page;

-	switch (data->type) {
+	switch (cursor->data->type) {
 	case CEPH_MSG_DATA_PAGELIST:
-		page = ceph_msg_data_pagelist_next(data, page_offset, length);
+		page = ceph_msg_data_pagelist_next(cursor, page_offset, length);
 		break;
 	case CEPH_MSG_DATA_PAGES:
-		page = ceph_msg_data_pages_next(data, page_offset, length);
+		page = ceph_msg_data_pages_next(cursor, page_offset, length);
 		break;
 #ifdef CONFIG_BLOCK
 	case CEPH_MSG_DATA_BIO:
-		page = ceph_msg_data_bio_next(data, page_offset, length);
+		page = ceph_msg_data_bio_next(cursor, page_offset, length);
 		break;
 #endif /* CONFIG_BLOCK */
 	case CEPH_MSG_DATA_NONE:
@@ -1039,7 +1039,7 @@ static struct page *ceph_msg_data_next(struct
ceph_msg_data *data,
 	BUG_ON(*page_offset + *length > PAGE_SIZE);
 	BUG_ON(!*length);
 	if (last_piece)
-		*last_piece = data->cursor->last_piece;
+		*last_piece = cursor->last_piece;

 	return page;
 }
@@ -1048,22 +1048,22 @@ static struct page *ceph_msg_data_next(struct
ceph_msg_data *data,
  * Returns true if the result moves the cursor on to the next piece
  * of the data item.
  */
-static bool ceph_msg_data_advance(struct ceph_msg_data *data, size_t bytes)
+static bool ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
+				size_t bytes)
 {
-	struct ceph_msg_data_cursor *cursor = data->cursor;
 	bool new_piece;

 	BUG_ON(bytes > cursor->resid);
-	switch (data->type) {
+	switch (cursor->data->type) {
 	case CEPH_MSG_DATA_PAGELIST:
-		new_piece = ceph_msg_data_pagelist_advance(data, bytes);
+		new_piece = ceph_msg_data_pagelist_advance(cursor, bytes);
 		break;
 	case CEPH_MSG_DATA_PAGES:
-		new_piece = ceph_msg_data_pages_advance(data, bytes);
+		new_piece = ceph_msg_data_pages_advance(cursor, bytes);
 		break;
 #ifdef CONFIG_BLOCK
 	case CEPH_MSG_DATA_BIO:
-		new_piece = ceph_msg_data_bio_advance(data, bytes);
+		new_piece = ceph_msg_data_bio_advance(cursor, bytes);
 		break;
 #endif /* CONFIG_BLOCK */
 	case CEPH_MSG_DATA_NONE:
@@ -1071,7 +1071,7 @@ static bool ceph_msg_data_advance(struct
ceph_msg_data *data, size_t bytes)
 		BUG();
 		break;
 	}
-	data->cursor->need_crc = new_piece;
+	cursor->need_crc = new_piece;

 	return new_piece;
 }
@@ -1083,7 +1083,7 @@ static void prepare_message_data(struct ceph_msg
*msg, u32 data_len)

 	/* Initialize data cursor */

-	ceph_msg_data_cursor_init(msg->data, (size_t)data_len);
+	ceph_msg_data_cursor_init(msg, (size_t)data_len);
 }

 /*
@@ -1404,7 +1404,7 @@ static u32 ceph_crc32c_page(u32 crc, struct page
*page,
 static int write_partial_message_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
-	struct ceph_msg_data_cursor *cursor = msg->data->cursor;
+	struct ceph_msg_data_cursor *cursor = &msg->cursor;
 	bool do_datacrc = !con->msgr->nocrc;
 	u32 crc;

@@ -1430,7 +1430,7 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		bool need_crc;
 		int ret;

-		page = ceph_msg_data_next(msg->data, &page_offset, &length,
+		page = ceph_msg_data_next(&msg->cursor, &page_offset, &length,
 							&last_piece);
 		ret = ceph_tcp_sendpage(con->sock, page, page_offset,
 				      length, last_piece);
@@ -1442,7 +1442,7 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		}
 		if (do_datacrc && cursor->need_crc)
 			crc = ceph_crc32c_page(crc, page, page_offset, length);
-		need_crc = ceph_msg_data_advance(msg->data, (size_t)ret);
+		need_crc = ceph_msg_data_advance(&msg->cursor, (size_t)ret);
 	}

 	dout("%s %p msg %p done\n", __func__, con, msg);
@@ -2102,7 +2102,7 @@ static int read_partial_message_section(struct
ceph_connection *con,
 static int read_partial_msg_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->in_msg;
-	struct ceph_msg_data_cursor *cursor = msg->data->cursor;
+	struct ceph_msg_data_cursor *cursor = &msg->cursor;
 	const bool do_datacrc = !con->msgr->nocrc;
 	struct page *page;
 	size_t page_offset;
@@ -2117,7 +2117,7 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 	if (do_datacrc)
 		crc = con->in_data_crc;
 	while (cursor->resid) {
-		page = ceph_msg_data_next(msg->data, &page_offset, &length,
+		page = ceph_msg_data_next(&msg->cursor, &page_offset, &length,
 							NULL);
 		ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
 		if (ret <= 0) {
@@ -2129,7 +2129,7 @@ static int read_partial_msg_data(struct
ceph_connection *con)

 		if (do_datacrc)
 			crc = ceph_crc32c_page(crc, page, page_offset, ret);
-		(void) ceph_msg_data_advance(msg->data, (size_t)ret);
+		(void) ceph_msg_data_advance(&msg->cursor, (size_t)ret);
 	}
 	if (do_datacrc)
 		con->in_data_crc = crc;
@@ -2989,7 +2989,6 @@ void ceph_msg_data_set_pages(struct ceph_msg *msg,
struct page **pages,

 	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGES);
 	BUG_ON(!data);
-	data->cursor = &msg->cursor;
 	data->pages = pages;
 	data->length = length;
 	data->alignment = alignment & ~PAGE_MASK;
@@ -3011,7 +3010,6 @@ void ceph_msg_data_set_pagelist(struct ceph_msg *msg,

 	data = ceph_msg_data_create(CEPH_MSG_DATA_PAGELIST);
 	BUG_ON(!data);
-	data->cursor = &msg->cursor;
 	data->pagelist = pagelist;

 	msg->data = data;
@@ -3031,7 +3029,6 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
struct bio *bio,

 	data = ceph_msg_data_create(CEPH_MSG_DATA_BIO);
 	BUG_ON(!data);
-	data->cursor = &msg->cursor;
 	data->bio = bio;
 	data->bio_length = length;

-- 
1.7.9.5

