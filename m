From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/8] libceph: implement bio message data item cursor
Date: Sun, 10 Mar 2013 14:17:35 -0500
Message-ID: <513CDC4F.3090109@inktank.com>
References: <513CD9BE.1070505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36612 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab3CJTRi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 15:17:38 -0400
Received: by mail-ie0-f169.google.com with SMTP id 13so3938688iea.14
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 12:17:38 -0700 (PDT)
In-Reply-To: <513CD9BE.1070505@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Implement and use cursor routines for bio message data items for
outbound message data.

(See the previous commit for reasoning in support of the changes
in out_msg_pos_next().)

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    7 +++
 net/ceph/messenger.c           |  128
++++++++++++++++++++++++++++++++++------
 2 files changed, 118 insertions(+), 17 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 716c3fd..76b4645 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -98,6 +98,13 @@ static __inline__ bool ceph_msg_data_type_valid(enum
ceph_msg_data_type type)
 struct ceph_msg_data_cursor {
 	bool		last_piece;	/* now at last piece of data item */
 	union {
+#ifdef CONFIG_BLOCK
+		struct {				/* bio */
+			struct bio	*bio;		/* bio from list */
+			unsigned int	vector_index;	/* vector from bio */
+			unsigned int	vector_offset;	/* bytes from vector */
+		};
+#endif /* CONFIG_BLOCK */
 		struct {				/* pagelist */
 			struct page	*page;		/* page from list */
 			size_t		offset;		/* bytes from list */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c0f89c1..5ddbe5d 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -739,6 +739,97 @@ static void iter_bio_next(struct bio **bio_iter,
unsigned int *seg)
 	if (*seg == (*bio_iter)->bi_vcnt)
 		init_bio_iter((*bio_iter)->bi_next, bio_iter, seg);
 }
+
+/*
+ * For a bio data item, a piece is whatever remains of the next
+ * entry in the current bio iovec, or the first entry in the next
+ * bio in the list.
+ */
+static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data *data)
+{
+	struct ceph_msg_data_cursor *cursor = &data->cursor;
+	struct bio *bio;
+
+	BUG_ON(data->type != CEPH_MSG_DATA_BIO);
+
+	bio = data->bio;
+	BUG_ON(!bio);
+	BUG_ON(!bio->bi_vcnt);
+	/* resid = bio->bi_size */
+
+	cursor->bio = bio;
+	cursor->vector_index = 0;
+	cursor->vector_offset = 0;
+	cursor->last_piece = !bio->bi_next && bio->bi_vcnt == 1;
+}
+
+static struct page *ceph_msg_data_bio_next(struct ceph_msg_data *data,
+						size_t *page_offset,
+						size_t *length,
+						bool *last_piece)
+{
+	struct ceph_msg_data_cursor *cursor = &data->cursor;
+	struct bio *bio;
+	struct bio_vec *bio_vec;
+	unsigned int index;
+
+	BUG_ON(data->type != CEPH_MSG_DATA_BIO);
+
+	bio = cursor->bio;
+	BUG_ON(!bio);
+
+	index = cursor->vector_index;
+	BUG_ON(index >= (unsigned int) bio->bi_vcnt);
+
+	bio_vec = &bio->bi_io_vec[index];
+	BUG_ON(cursor->vector_offset >= bio_vec->bv_len);
+	*page_offset = (size_t) (bio_vec->bv_offset + cursor->vector_offset);
+	BUG_ON(*page_offset >= PAGE_SIZE);
+	*length = (size_t) (bio_vec->bv_len - cursor->vector_offset);
+	BUG_ON(*length > PAGE_SIZE);
+	*last_piece = cursor->last_piece;
+
+	return bio_vec->bv_page;
+}
+
+static bool ceph_msg_data_bio_advance(struct ceph_msg_data *data,
size_t bytes)
+{
+	struct ceph_msg_data_cursor *cursor = &data->cursor;
+	struct bio *bio;
+	struct bio_vec *bio_vec;
+	unsigned int index;
+
+	BUG_ON(data->type != CEPH_MSG_DATA_BIO);
+
+	bio = cursor->bio;
+	BUG_ON(!bio);
+
+	index = cursor->vector_index;
+	BUG_ON(index >= (unsigned int) bio->bi_vcnt);
+	bio_vec = &bio->bi_io_vec[index];
+	BUG_ON(cursor->vector_offset + bytes > bio_vec->bv_len);
+
+	/* Advance the cursor offset */
+
+	cursor->vector_offset += bytes;
+	if (cursor->vector_offset < bio_vec->bv_len)
+		return false;	/* more bytes to process in this segment */
+
+	/* Move on to the next segment, and possibly the next bio */
+
+	if (++cursor->vector_index == (unsigned int) bio->bi_vcnt) {
+		bio = bio->bi_next;
+		cursor->bio = bio;
+		cursor->vector_index = 0;
+	}
+	cursor->vector_offset = 0;
+
+	if (!cursor->last_piece && bio && !bio->bi_next)
+		if (cursor->vector_index == (unsigned int) bio->bi_vcnt - 1)
+			cursor->last_piece = true;
+
+	return true;
+}
 #endif

 /*
@@ -850,6 +941,8 @@ static void ceph_msg_data_cursor_init(struct
ceph_msg_data *data)
 		break;
 #ifdef CONFIG_BLOCK
 	case CEPH_MSG_DATA_BIO:
+		ceph_msg_data_bio_cursor_init(data);
+		break;
 #endif /* CONFIG_BLOCK */
 	default:
 	    break;
@@ -875,7 +968,8 @@ static struct page *ceph_msg_data_next(struct
ceph_msg_data *data,
 						last_piece);
 #ifdef CONFIG_BLOCK
 	case CEPH_MSG_DATA_BIO:
-		break;
+		return ceph_msg_data_bio_next(data, page_offset, length,
+						last_piece);
 #endif /* CONFIG_BLOCK */
 	}
 	BUG();
@@ -896,7 +990,7 @@ static bool ceph_msg_data_advance(struct
ceph_msg_data *data, size_t bytes)
 		return ceph_msg_data_pagelist_advance(data, bytes);
 #ifdef CONFIG_BLOCK
 	case CEPH_MSG_DATA_BIO:
-		break;
+		return ceph_msg_data_bio_advance(data, bytes);
 #endif /* CONFIG_BLOCK */
 	}
 	BUG();
@@ -923,6 +1017,10 @@ static void prepare_message_data(struct ceph_msg *msg,

 	/* Initialize data cursors */

+#ifdef CONFIG_BLOCK
+	if (ceph_msg_has_bio(msg))
+		ceph_msg_data_cursor_init(&msg->b);
+#endif /* CONFIG_BLOCK */
 	if (ceph_msg_has_pagelist(msg))
 		ceph_msg_data_cursor_init(&msg->l);
 	if (ceph_msg_has_trail(msg))
@@ -1223,6 +1321,10 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 		need_crc = ceph_msg_data_advance(&msg->t, sent);
 	else if (ceph_msg_has_pagelist(msg))
 		need_crc = ceph_msg_data_advance(&msg->l, sent);
+#ifdef CONFIG_BLOCK
+	else if (ceph_msg_has_bio(msg))
+		need_crc = ceph_msg_data_advance(&msg->b, sent);
+#endif /* CONFIG_BLOCK */
 	BUG_ON(need_crc && sent != len);

 	if (sent < len)
@@ -1232,10 +1334,6 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 	msg_pos->page_pos = 0;
 	msg_pos->page++;
 	msg_pos->did_page_crc = false;
-#ifdef CONFIG_BLOCK
-	if (ceph_msg_has_bio(msg))
-		iter_bio_next(&msg->b.bio_iter, &msg->b.bio_seg);
-#endif
 }

 static void in_msg_pos_next(struct ceph_connection *con, size_t len,
@@ -1313,8 +1411,6 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		struct page *page = NULL;
 		size_t page_offset;
 		size_t length;
-		int max_write = PAGE_SIZE;
-		int bio_offset = 0;
 		bool use_cursor = false;
 		bool last_piece = true;	/* preserve existing behavior */

@@ -1335,21 +1431,19 @@ static int write_partial_message_data(struct
ceph_connection *con)
 							&length, &last_piece);
 #ifdef CONFIG_BLOCK
 		} else if (ceph_msg_has_bio(msg)) {
-			struct bio_vec *bv;
-
-			bv = bio_iovec_idx(msg->b.bio_iter, msg->b.bio_seg);
-			page = bv->bv_page;
-			bio_offset = bv->bv_offset;
-			max_write = bv->bv_len;
+			use_cursor = true;
+			page = ceph_msg_data_next(&msg->b, &page_offset,
+							&length, &last_piece);
 #endif
 		} else {
 			page = zero_page;
 		}
-		if (!use_cursor)
-			length = min_t(int, max_write - msg_pos->page_pos,
+		if (!use_cursor) {
+			length = min_t(int, PAGE_SIZE - msg_pos->page_pos,
 					    total_max_write);

-		page_offset = msg_pos->page_pos + bio_offset;
+			page_offset = msg_pos->page_pos;
+		}
 		if (do_datacrc && !msg_pos->did_page_crc) {
 			u32 crc = le32_to_cpu(msg->footer.data_crc);

-- 
1.7.9.5

