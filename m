From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/8] libceph: prepare for other message data item types
Date: Sun, 10 Mar 2013 14:16:53 -0500
Message-ID: <513CDC25.4050600@inktank.com>
References: <513CD9BE.1070505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:62750 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3CJTQ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 15:16:56 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so2939494iag.17
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 12:16:55 -0700 (PDT)
In-Reply-To: <513CD9BE.1070505@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This just inserts some infrastructure in preparation for handling
other types of ceph message data items.  No functional changes,
just trying to simplify review by separating out some noise.

I will fold this into the previous patch before committing.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    8 +++-
 net/ceph/messenger.c           |   99
++++++++++++++++++++++++++++++++--------
 2 files changed, 85 insertions(+), 22 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1486243..716c3fd 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -97,8 +97,12 @@ static __inline__ bool ceph_msg_data_type_valid(enum
ceph_msg_data_type type)

 struct ceph_msg_data_cursor {
 	bool		last_piece;	/* now at last piece of data item */
-	struct page	*page;		/* current page in pagelist */
-	size_t		offset;		/* pagelist bytes consumed */
+	union {
+		struct {				/* pagelist */
+			struct page	*page;		/* page from list */
+			size_t		offset;		/* bytes from list */
+		};
+	};
 };

 struct ceph_msg_data {
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b978cf8..ce81164 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -742,21 +742,16 @@ static void iter_bio_next(struct bio **bio_iter,
unsigned int *seg)
 #endif

 /*
- * Message data is handled (sent or received) in pieces, where each
- * piece resides on a single page.  The network layer might not
- * consume an entire piece at once.  A data item's cursor keeps
- * track of which piece is next to process and how much remains to
- * be processed in that piece.  It also tracks whether the current
- * piece is the last one in the data item.
+ * For a pagelist, a piece is whatever remains to be consumed in the
+ * first page in the list, or the front of the next page.
  */
-static void ceph_msg_data_cursor_init(struct ceph_msg_data *data)
+static void ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data *data)
 {
 	struct ceph_msg_data_cursor *cursor = &data->cursor;
 	struct ceph_pagelist *pagelist;
 	struct page *page;

-	if (data->type != CEPH_MSG_DATA_PAGELIST)
-		return;
+	BUG_ON(data->type != CEPH_MSG_DATA_PAGELIST);

 	pagelist = data->pagelist;
 	BUG_ON(!pagelist);
@@ -771,12 +766,7 @@ static void ceph_msg_data_cursor_init(struct
ceph_msg_data *data)
 	cursor->last_piece = pagelist->length <= PAGE_SIZE;
 }

-/*
- * Return the page containing the next piece to process for a given
- * data item, and supply the page offset and length of that piece.
- * Indicate whether this is the last piece in this data item.
- */
-static struct page *ceph_msg_data_next(struct ceph_msg_data *data,
+static struct page *ceph_msg_data_pagelist_next(struct ceph_msg_data *data,
 						size_t *page_offset,
 						size_t *length,
 						bool *last_piece)
@@ -808,11 +798,8 @@ static struct page *ceph_msg_data_next(struct
ceph_msg_data *data,
 	return data->cursor.page;
 }

-/*
- * Returns true if the result moves the cursor on to the next piece
- * (the next page) of the pagelist.
- */
-static bool ceph_msg_data_advance(struct ceph_msg_data *data, size_t bytes)
+static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data *data,
+						size_t bytes)
 {
 	struct ceph_msg_data_cursor *cursor = &data->cursor;
 	struct ceph_pagelist *pagelist;
@@ -844,6 +831,78 @@ static bool ceph_msg_data_advance(struct
ceph_msg_data *data, size_t bytes)
 	return true;
 }

+/*
+ * Message data is handled (sent or received) in pieces, where each
+ * piece resides on a single page.  The network layer might not
+ * consume an entire piece at once.  A data item's cursor keeps
+ * track of which piece is next to process and how much remains to
+ * be processed in that piece.  It also tracks whether the current
+ * piece is the last one in the data item.
+ */
+static void ceph_msg_data_cursor_init(struct ceph_msg_data *data)
+{
+	switch (data->type) {
+	case CEPH_MSG_DATA_NONE:
+	case CEPH_MSG_DATA_PAGES:
+		break;
+	case CEPH_MSG_DATA_PAGELIST:
+		ceph_msg_data_pagelist_cursor_init(data);
+		break;
+#ifdef CONFIG_BLOCK
+	case CEPH_MSG_DATA_BIO:
+#endif /* CONFIG_BLOCK */
+	default:
+	    break;
+	}
+}
+
+/*
+ * Return the page containing the next piece to process for a given
+ * data item, and supply the page offset and length of that piece.
+ * Indicate whether this is the last piece in this data item.
+ */
+static struct page *ceph_msg_data_next(struct ceph_msg_data *data,
+					size_t *page_offset,
+					size_t *length,
+					bool *last_piece)
+{
+	switch (data->type) {
+	case CEPH_MSG_DATA_NONE:
+	case CEPH_MSG_DATA_PAGES:
+		break;
+	case CEPH_MSG_DATA_PAGELIST:
+		return ceph_msg_data_pagelist_next(data, page_offset, length,
+						last_piece);
+#ifdef CONFIG_BLOCK
+	case CEPH_MSG_DATA_BIO:
+		break;
+#endif /* CONFIG_BLOCK */
+	}
+	BUG();
+	return NULL;
+}
+
+/*
+ * Returns true if the result moves the cursor on to the next piece
+ * of the data item.
+ */
+static bool ceph_msg_data_advance(struct ceph_msg_data *data, size_t bytes)
+{
+	switch (data->type) {
+	case CEPH_MSG_DATA_NONE:
+	case CEPH_MSG_DATA_PAGES:
+		break;
+	case CEPH_MSG_DATA_PAGELIST:
+		return ceph_msg_data_pagelist_advance(data, bytes);
+#ifdef CONFIG_BLOCK
+	case CEPH_MSG_DATA_BIO:
+		break;
+#endif /* CONFIG_BLOCK */
+	}
+	BUG();
+	return false;
+}
+
 static void prepare_message_data(struct ceph_msg *msg,
 				struct ceph_msg_pos *msg_pos)
 {
-- 
1.7.9.5

