From: Alex Elder <elder@inktank.com>
Subject: [PATCH 8/8] libceph: implement pages array cursor
Date: Sun, 10 Mar 2013 14:17:53 -0500
Message-ID: <513CDC61.5070004@inktank.com>
References: <513CD9BE.1070505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:63304 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab3CJTR4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 15:17:56 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so3929045iec.32
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 12:17:56 -0700 (PDT)
In-Reply-To: <513CD9BE.1070505@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Implement and use cursor routines for page array message data items
for outbound message data.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    6 +++
 net/ceph/messenger.c           |   92
++++++++++++++++++++++++++++++++++++++--
 2 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 76b4645..b53b9ef 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -105,6 +105,12 @@ struct ceph_msg_data_cursor {
 			unsigned int	vector_offset;	/* bytes from vector */
 		};
 #endif /* CONFIG_BLOCK */
+		struct {				/* pages */
+			size_t		resid;		/* bytes from array */
+			unsigned int	page_offset;	/* offset in page */
+			unsigned short	page_index;	/* index in array */
+			unsigned short	page_count;	/* pages in array */
+		};
 		struct {				/* pagelist */
 			struct page	*page;		/* page from list */
 			size_t		offset;		/* bytes from list */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5ddbe5d..12d416f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -833,6 +833,81 @@ static bool ceph_msg_data_bio_advance(struct
ceph_msg_data *data, size_t bytes)
 #endif

 /*
+ * For a page array, a piece comes from the first page in the array
+ * that has not already been fully consumed.
+ */
+static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data *data)
+{
+	struct ceph_msg_data_cursor *cursor = &data->cursor;
+	int page_count;
+
+	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
+
+	BUG_ON(!data->pages);
+	BUG_ON(!data->length);
+
+	page_count = calc_pages_for(data->alignment, (u64)data->length);
+	BUG_ON(page_count > (int) USHRT_MAX);
+	cursor->resid = data->length;
+	cursor->page_offset = data->alignment & ~PAGE_MASK;
+	cursor->page_index = 0;
+	cursor->page_count = (unsigned short) page_count;
+	cursor->last_piece = cursor->page_count == 1;
+}
+
+static struct page *ceph_msg_data_pages_next(struct ceph_msg_data *data,
+					size_t *page_offset,
+					size_t *length,
+					bool *last_piece)
+{
+	struct ceph_msg_data_cursor *cursor = &data->cursor;
+
+	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
+
+	BUG_ON(cursor->page_index >= cursor->page_count);
+	BUG_ON(cursor->page_offset >= PAGE_SIZE);
+	BUG_ON(!cursor->resid);
+
+	*page_offset = cursor->page_offset;
+	*last_piece = cursor->last_piece;
+	if (*last_piece) {
+		BUG_ON(*page_offset + cursor->resid > PAGE_SIZE);
+		*length = cursor->resid;
+	} else {
+		*length = PAGE_SIZE - *page_offset;
+	}
+
+	return data->pages[cursor->page_index];
+}
+
+static bool ceph_msg_data_pages_advance(struct ceph_msg_data *data,
+						size_t bytes)
+{
+	struct ceph_msg_data_cursor *cursor = &data->cursor;
+
+	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
+
+	BUG_ON(cursor->page_offset + bytes > PAGE_SIZE);
+	BUG_ON(bytes > cursor->resid);
+
+	/* Advance the cursor page offset */
+
+	cursor->resid -= bytes;
+	cursor->page_offset += bytes;
+	if (!bytes || cursor->page_offset & ~PAGE_MASK)
+		return false;	/* more bytes to process in the current page */
+
+	/* Move on to the next page */
+
+	BUG_ON(cursor->page_index >= cursor->page_count);
+	cursor->page_offset = 0;
+	cursor->page_index++;
+	cursor->last_piece = cursor->page_index == cursor->page_count - 1;
+
+	return true;
+}
+
+/*
  * For a pagelist, a piece is whatever remains to be consumed in the
  * first page in the list, or the front of the next page.
  */
@@ -934,7 +1009,9 @@ static void ceph_msg_data_cursor_init(struct
ceph_msg_data *data)
 {
 	switch (data->type) {
 	case CEPH_MSG_DATA_NONE:
+		break;
 	case CEPH_MSG_DATA_PAGES:
+		ceph_msg_data_pages_cursor_init(data);
 		break;
 	case CEPH_MSG_DATA_PAGELIST:
 		ceph_msg_data_pagelist_cursor_init(data);
@@ -961,8 +1038,10 @@ static struct page *ceph_msg_data_next(struct
ceph_msg_data *data,
 {
 	switch (data->type) {
 	case CEPH_MSG_DATA_NONE:
-	case CEPH_MSG_DATA_PAGES:
 		break;
+	case CEPH_MSG_DATA_PAGES:
+		return ceph_msg_data_pages_next(data, page_offset, length,
+						last_piece);
 	case CEPH_MSG_DATA_PAGELIST:
 		return ceph_msg_data_pagelist_next(data, page_offset, length,
 						last_piece);
@@ -984,8 +1063,9 @@ static bool ceph_msg_data_advance(struct
ceph_msg_data *data, size_t bytes)
 {
 	switch (data->type) {
 	case CEPH_MSG_DATA_NONE:
-	case CEPH_MSG_DATA_PAGES:
 		break;
+	case CEPH_MSG_DATA_PAGES:
+		return ceph_msg_data_pages_advance(data, bytes);
 	case CEPH_MSG_DATA_PAGELIST:
 		return ceph_msg_data_pagelist_advance(data, bytes);
 #ifdef CONFIG_BLOCK
@@ -1021,6 +1101,8 @@ static void prepare_message_data(struct ceph_msg *msg,
 	if (ceph_msg_has_bio(msg))
 		ceph_msg_data_cursor_init(&msg->b);
 #endif /* CONFIG_BLOCK */
+	if (ceph_msg_has_pages(msg))
+		ceph_msg_data_cursor_init(&msg->p);
 	if (ceph_msg_has_pagelist(msg))
 		ceph_msg_data_cursor_init(&msg->l);
 	if (ceph_msg_has_trail(msg))
@@ -1319,6 +1401,8 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 	msg_pos->page_pos += sent;
 	if (in_trail)
 		need_crc = ceph_msg_data_advance(&msg->t, sent);
+	else if (ceph_msg_has_pages(msg))
+		need_crc = ceph_msg_data_advance(&msg->p, sent);
 	else if (ceph_msg_has_pagelist(msg))
 		need_crc = ceph_msg_data_advance(&msg->l, sent);
 #ifdef CONFIG_BLOCK
@@ -1424,7 +1508,9 @@ static int write_partial_message_data(struct
ceph_connection *con)
 			page = ceph_msg_data_next(&msg->t, &page_offset,
 							&length, &last_piece);
 		} else if (ceph_msg_has_pages(msg)) {
-			page = msg->p.pages[msg_pos->page];
+			use_cursor = true;
+			page = ceph_msg_data_next(&msg->p, &page_offset,
+							&length, &last_piece);
 		} else if (ceph_msg_has_pagelist(msg)) {
 			use_cursor = true;
 			page = ceph_msg_data_next(&msg->l, &page_offset,
-- 
1.7.9.5

