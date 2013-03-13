From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: record residual bytes for all message data types
Date: Tue, 12 Mar 2013 20:03:21 -0500
Message-ID: <513FD059.2000604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:61643 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBDZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:03:25 -0400
Received: by mail-ob0-f173.google.com with SMTP id dn14so498869obc.32
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:03:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All of the data types can use this, not just the page array.  Until
now, only the bio type doesn't have it available, and only the
initiator of the request (the rbd client) is able to supply the
length of the full request without re-scanning the bio list.  Change
the cursor init routines so the length is supplied based on the
message header "data_len" field, and use that length to intiialize
the "resid" field of the cursor.

In addition, change the way "last_piece" is defined so it is based
on the residual number of bytes in the original request.  This is
necessary (at least for bio messages) because it is possible for
a read request to succeed without consuming all of the space
available in the data buffer.

This resolves:
    http://tracker.ceph.com/issues/4427

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    2 +-
 net/ceph/messenger.c           |  111
++++++++++++++++++++++------------------
 2 files changed, 63 insertions(+), 50 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 0e4536c..459e552 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -95,6 +95,7 @@ static __inline__ bool ceph_msg_data_type_valid(enum
ceph_msg_data_type type)
 }

 struct ceph_msg_data_cursor {
+	size_t		resid;		/* bytes not yet consumed */
 	bool		last_piece;	/* now at last piece of data item */
 	union {
 #ifdef CONFIG_BLOCK
@@ -105,7 +106,6 @@ struct ceph_msg_data_cursor {
 		};
 #endif /* CONFIG_BLOCK */
 		struct {				/* pages */
-			size_t		resid;		/* bytes from array */
 			unsigned int	page_offset;	/* offset in page */
 			unsigned short	page_index;	/* index in array */
 			unsigned short	page_count;	/* pages in array */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c3f2fa1..07ace1d 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -745,7 +745,8 @@ static void iter_bio_next(struct bio **bio_iter,
unsigned int *seg)
  * entry in the current bio iovec, or the first entry in the next
  * bio in the list.
  */
-static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data *data)
+static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data *data,
+					size_t length)
 {
 	struct ceph_msg_data_cursor *cursor = &data->cursor;
 	struct bio *bio;
@@ -755,12 +756,12 @@ static void ceph_msg_data_bio_cursor_init(struct
ceph_msg_data *data)
 	bio = data->bio;
 	BUG_ON(!bio);
 	BUG_ON(!bio->bi_vcnt);
-	/* resid = bio->bi_size */

+	cursor->resid = length;
 	cursor->bio = bio;
 	cursor->vector_index = 0;
 	cursor->vector_offset = 0;
-	cursor->last_piece = !bio->bi_next && bio->bi_vcnt == 1;
+	cursor->last_piece = length <= bio->bi_io_vec[0].bv_len;
 }

 static struct page *ceph_msg_data_bio_next(struct ceph_msg_data *data,
@@ -784,8 +785,12 @@ static struct page *ceph_msg_data_bio_next(struct
ceph_msg_data *data,
 	BUG_ON(cursor->vector_offset >= bio_vec->bv_len);
 	*page_offset = (size_t) (bio_vec->bv_offset + cursor->vector_offset);
 	BUG_ON(*page_offset >= PAGE_SIZE);
-	*length = (size_t) (bio_vec->bv_len - cursor->vector_offset);
+	if (cursor->last_piece) /* pagelist offset is always 0 */
+		*length = cursor->resid;
+	else
+		*length = (size_t) (bio_vec->bv_len - cursor->vector_offset);
 	BUG_ON(*length > PAGE_SIZE);
+	BUG_ON(*length > cursor->resid);

 	return bio_vec->bv_page;
 }
@@ -805,26 +810,33 @@ static bool ceph_msg_data_bio_advance(struct
ceph_msg_data *data, size_t bytes)
 	index = cursor->vector_index;
 	BUG_ON(index >= (unsigned int) bio->bi_vcnt);
 	bio_vec = &bio->bi_io_vec[index];
-	BUG_ON(cursor->vector_offset + bytes > bio_vec->bv_len);

 	/* Advance the cursor offset */

+	BUG_ON(cursor->resid < bytes);
+	cursor->resid -= bytes;
 	cursor->vector_offset += bytes;
 	if (cursor->vector_offset < bio_vec->bv_len)
 		return false;	/* more bytes to process in this segment */
+	BUG_ON(cursor->vector_offset != bio_vec->bv_len);

 	/* Move on to the next segment, and possibly the next bio */

-	if (++cursor->vector_index == (unsigned int) bio->bi_vcnt) {
+	if (++index == (unsigned int) bio->bi_vcnt) {
 		bio = bio->bi_next;
-		cursor->bio = bio;
-		cursor->vector_index = 0;
+		index = 0;
 	}
+	cursor->bio = bio;
+	cursor->vector_index = index;
 	cursor->vector_offset = 0;

-	if (!cursor->last_piece && bio && !bio->bi_next)
-		if (cursor->vector_index == (unsigned int) bio->bi_vcnt - 1)
+	if (!cursor->last_piece) {
+		BUG_ON(!cursor->resid);
+		BUG_ON(!bio);
+		/* A short read is OK, so use <= rather than == */
+		if (cursor->resid <= bio->bi_io_vec[index].bv_len)
 			cursor->last_piece = true;
+	}

 	return true;
 }
@@ -834,7 +846,8 @@ static bool ceph_msg_data_bio_advance(struct
ceph_msg_data *data, size_t bytes)
  * For a page array, a piece comes from the first page in the array
  * that has not already been fully consumed.
  */
-static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data *data)
+static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data *data,
+					size_t length)
 {
 	struct ceph_msg_data_cursor *cursor = &data->cursor;
 	int page_count;
@@ -843,14 +856,15 @@ static void ceph_msg_data_pages_cursor_init(struct
ceph_msg_data *data)

 	BUG_ON(!data->pages);
 	BUG_ON(!data->length);
+	BUG_ON(length != data->length);

+	cursor->resid = length;
 	page_count = calc_pages_for(data->alignment, (u64)data->length);
-	BUG_ON(page_count > (int) USHRT_MAX);
-	cursor->resid = data->length;
 	cursor->page_offset = data->alignment & ~PAGE_MASK;
 	cursor->page_index = 0;
+	BUG_ON(page_count > (int) USHRT_MAX);
 	cursor->page_count = (unsigned short) page_count;
-	cursor->last_piece = cursor->page_count == 1;
+	cursor->last_piece = length <= PAGE_SIZE;
 }

 static struct page *ceph_msg_data_pages_next(struct ceph_msg_data *data,
@@ -863,15 +877,12 @@ static struct page
*ceph_msg_data_pages_next(struct ceph_msg_data *data,

 	BUG_ON(cursor->page_index >= cursor->page_count);
 	BUG_ON(cursor->page_offset >= PAGE_SIZE);
-	BUG_ON(!cursor->resid);

 	*page_offset = cursor->page_offset;
-	if (cursor->last_piece) {
-		BUG_ON(*page_offset + cursor->resid > PAGE_SIZE);
+	if (cursor->last_piece)
 		*length = cursor->resid;
-	} else {
+	else
 		*length = PAGE_SIZE - *page_offset;
-	}

 	return data->pages[cursor->page_index];
 }
@@ -884,7 +895,6 @@ static bool ceph_msg_data_pages_advance(struct
ceph_msg_data *data,
 	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);

 	BUG_ON(cursor->page_offset + bytes > PAGE_SIZE);
-	BUG_ON(bytes > cursor->resid);

 	/* Advance the cursor page offset */

@@ -898,7 +908,7 @@ static bool ceph_msg_data_pages_advance(struct
ceph_msg_data *data,
 	BUG_ON(cursor->page_index >= cursor->page_count);
 	cursor->page_offset = 0;
 	cursor->page_index++;
-	cursor->last_piece = cursor->page_index == cursor->page_count - 1;
+	cursor->last_piece = cursor->resid <= PAGE_SIZE;

 	return true;
 }
@@ -907,7 +917,8 @@ static bool ceph_msg_data_pages_advance(struct
ceph_msg_data *data,
  * For a pagelist, a piece is whatever remains to be consumed in the
  * first page in the list, or the front of the next page.
  */
-static void ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data *data)
+static void ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data *data,
+					size_t length)
 {
 	struct ceph_msg_data_cursor *cursor = &data->cursor;
 	struct ceph_pagelist *pagelist;
@@ -917,15 +928,18 @@ static void
ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data *data)

 	pagelist = data->pagelist;
 	BUG_ON(!pagelist);
-	if (!pagelist->length)
+	BUG_ON(length != pagelist->length);
+
+	if (!length)
 		return;		/* pagelist can be assigned but empty */

 	BUG_ON(list_empty(&pagelist->head));
 	page = list_first_entry(&pagelist->head, struct page, lru);

+	cursor->resid = length;
 	cursor->page = page;
 	cursor->offset = 0;
-	cursor->last_piece = pagelist->length <= PAGE_SIZE;
+	cursor->last_piece = length <= PAGE_SIZE;
 }

 static struct page *ceph_msg_data_pagelist_next(struct ceph_msg_data *data,
@@ -934,7 +948,6 @@ static struct page
*ceph_msg_data_pagelist_next(struct ceph_msg_data *data,
 {
 	struct ceph_msg_data_cursor *cursor = &data->cursor;
 	struct ceph_pagelist *pagelist;
-	size_t piece_end;

 	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);

@@ -942,18 +955,13 @@ static struct page
*ceph_msg_data_pagelist_next(struct ceph_msg_data *data,
 	BUG_ON(!pagelist);

 	BUG_ON(!cursor->page);
-	BUG_ON(cursor->offset >= pagelist->length);
+	BUG_ON(cursor->offset + cursor->resid != pagelist->length);

-	if (cursor->last_piece) {
-		/* pagelist offset is always 0 */
-		piece_end = pagelist->length & ~PAGE_MASK;
-		if (!piece_end)
-			piece_end = PAGE_SIZE;
-	} else {
-		piece_end = PAGE_SIZE;
-	}
 	*page_offset = cursor->offset & ~PAGE_MASK;
-	*length = piece_end - *page_offset;
+	if (cursor->last_piece) /* pagelist offset is always 0 */
+		*length = cursor->resid;
+	else
+		*length = PAGE_SIZE - *page_offset;

 	return data->cursor.page;
 }
@@ -968,12 +976,13 @@ static bool ceph_msg_data_pagelist_advance(struct
ceph_msg_data *data,

 	pagelist = data->pagelist;
 	BUG_ON(!pagelist);
-	BUG_ON(!cursor->page);
-	BUG_ON(cursor->offset + bytes > pagelist->length);
+
+	BUG_ON(cursor->offset + cursor->resid != pagelist->length);
 	BUG_ON((cursor->offset & ~PAGE_MASK) + bytes > PAGE_SIZE);

 	/* Advance the cursor offset */

+	cursor->resid -= bytes;
 	cursor->offset += bytes;
 	/* pagelist offset is always 0 */
 	if (!bytes || cursor->offset & ~PAGE_MASK)
@@ -983,10 +992,7 @@ static bool ceph_msg_data_pagelist_advance(struct
ceph_msg_data *data,

 	BUG_ON(list_is_last(&cursor->page->lru, &pagelist->head));
 	cursor->page = list_entry_next(cursor->page, lru);
-
-	/* cursor offset is at page boundary; pagelist offset is always 0 */
-	if (pagelist->length - cursor->offset <= PAGE_SIZE)
-		cursor->last_piece = true;
+	cursor->last_piece = cursor->resid <= PAGE_SIZE;

 	return true;
 }
@@ -999,18 +1005,19 @@ static bool ceph_msg_data_pagelist_advance(struct
ceph_msg_data *data,
  * be processed in that piece.  It also tracks whether the current
  * piece is the last one in the data item.
  */
-static void ceph_msg_data_cursor_init(struct ceph_msg_data *data)
+static void ceph_msg_data_cursor_init(struct ceph_msg_data *data,
+					size_t length)
 {
 	switch (data->type) {
 	case CEPH_MSG_DATA_PAGELIST:
-		ceph_msg_data_pagelist_cursor_init(data);
+		ceph_msg_data_pagelist_cursor_init(data, length);
 		break;
 	case CEPH_MSG_DATA_PAGES:
-		ceph_msg_data_pages_cursor_init(data);
+		ceph_msg_data_pages_cursor_init(data, length);
 		break;
 #ifdef CONFIG_BLOCK
 	case CEPH_MSG_DATA_BIO:
-		ceph_msg_data_bio_cursor_init(data);
+		ceph_msg_data_bio_cursor_init(data, length);
 		break;
 #endif /* CONFIG_BLOCK */
 	case CEPH_MSG_DATA_NONE:
@@ -1064,8 +1071,10 @@ static struct page *ceph_msg_data_next(struct
ceph_msg_data *data,
  */
 static bool ceph_msg_data_advance(struct ceph_msg_data *data, size_t bytes)
 {
+	struct ceph_msg_data_cursor *cursor = &data->cursor;
 	bool new_piece;

+	BUG_ON(bytes > cursor->resid);
 	switch (data->type) {
 	case CEPH_MSG_DATA_PAGELIST:
 		new_piece = ceph_msg_data_pagelist_advance(data, bytes);
@@ -1090,8 +1099,12 @@ static bool ceph_msg_data_advance(struct
ceph_msg_data *data, size_t bytes)
 static void prepare_message_data(struct ceph_msg *msg,
 				struct ceph_msg_pos *msg_pos)
 {
+	size_t data_len;
+
 	BUG_ON(!msg);
-	BUG_ON(!msg->hdr.data_len);
+
+	data_len = le32_to_cpu(msg->hdr.data_len);
+	BUG_ON(!data_len);

 	/* initialize page iterator */
 	msg_pos->page = 0;
@@ -1109,12 +1122,12 @@ static void prepare_message_data(struct ceph_msg
*msg,

 #ifdef CONFIG_BLOCK
 	if (ceph_msg_has_bio(msg))
-		ceph_msg_data_cursor_init(&msg->b);
+		ceph_msg_data_cursor_init(&msg->b, data_len);
 #endif /* CONFIG_BLOCK */
 	if (ceph_msg_has_pages(msg))
-		ceph_msg_data_cursor_init(&msg->p);
+		ceph_msg_data_cursor_init(&msg->p, data_len);
 	if (ceph_msg_has_pagelist(msg))
-		ceph_msg_data_cursor_init(&msg->l);
+		ceph_msg_data_cursor_init(&msg->l, data_len);

 	msg_pos->did_page_crc = false;
 }
-- 
1.7.9.5

