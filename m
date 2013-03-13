From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] libceph: kill last of ceph_msg_pos
Date: Tue, 12 Mar 2013 20:09:45 -0500
Message-ID: <513FD1D9.3050604@inktank.com>
References: <513FD178.60207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:34220 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3CMBJs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:09:48 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so539260oag.9
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:09:48 -0700 (PDT)
In-Reply-To: <513FD178.60207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The only remaining field in the ceph_msg_pos structure is
did_page_crc.  In the new cursor model of things that flag (or
something like it) belongs in the cursor.

Define a new field "need_crc" in the cursor (which applies to all
types of data) and initialize it to true whenever a cursor is
initialized.

In write_partial_message_data(), the data CRC still will be computed
as before, but it will check the cursor->need_crc field to determine
whether it's needed.  Any time the cursor is advanced to a new piece
of a data item, need_crc will be set, and this will case the crc
for that entire piece to be accumulated into the data crc.

In write_partial_message_data() the intermediate crc value is now
held in a local variable so it doesn't have to be byte-swapped so
many times.  In read_partial_msg_data() we do something similar
(but mainly for consistency there).

With that, the ceph_msg_pos structure can go away,  and it no longer
needs to be passed as an argument to prepare_message_data().

This cleanup is related to:
    http://tracker.ceph.com/issues/4428

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    7 +-----
 net/ceph/messenger.c           |   47
++++++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index c76b228..686df5b 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -93,6 +93,7 @@ static __inline__ bool ceph_msg_data_type_valid(enum
ceph_msg_data_type type)
 struct ceph_msg_data_cursor {
 	size_t		resid;		/* bytes not yet consumed */
 	bool		last_piece;	/* now at last piece of data item */
+	bool		need_crc;	/* new piece; crc update needed */
 	union {
 #ifdef CONFIG_BLOCK
 		struct {				/* bio */
@@ -156,10 +157,6 @@ struct ceph_msg {
 	struct ceph_msgpool *pool;
 };

-struct ceph_msg_pos {
-	bool did_page_crc;   /* true if we've calculated crc for current page */
-};
-
 /* ceph connection fault delay defaults, for exponential backoff */
 #define BASE_DELAY_INTERVAL	(HZ/2)
 #define MAX_DELAY_INTERVAL	(5 * 60 * HZ)
@@ -217,7 +214,6 @@ struct ceph_connection {
 	struct ceph_msg *out_msg;        /* sending message (== tail of
 					    out_sent) */
 	bool out_msg_done;
-	struct ceph_msg_pos out_msg_pos;

 	struct kvec out_kvec[8],         /* sending header/footer data */
 		*out_kvec_cur;
@@ -231,7 +227,6 @@ struct ceph_connection {
 	/* message in temps */
 	struct ceph_msg_header in_hdr;
 	struct ceph_msg *in_msg;
-	struct ceph_msg_pos in_msg_pos;
 	u32 in_front_crc, in_middle_crc, in_data_crc;  /* calculated crc */

 	char in_tag;         /* protocol control byte */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5e62d02..3180f82 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1002,6 +1002,7 @@ static void ceph_msg_data_cursor_init(struct
ceph_msg_data *data,
 		/* BUG(); */
 		break;
 	}
+	data->cursor.need_crc = true;
 }

 /*
@@ -1069,12 +1070,12 @@ static bool ceph_msg_data_advance(struct
ceph_msg_data *data, size_t bytes)
 		BUG();
 		break;
 	}
+	data->cursor.need_crc = new_piece;

 	return new_piece;
 }

-static void prepare_message_data(struct ceph_msg *msg,
-				struct ceph_msg_pos *msg_pos)
+static void prepare_message_data(struct ceph_msg *msg)
 {
 	size_t data_len;

@@ -1086,8 +1087,6 @@ static void prepare_message_data(struct ceph_msg *msg,
 	/* Initialize data cursors */

 	ceph_msg_data_cursor_init(&msg->data, data_len);
-
-	msg_pos->did_page_crc = false;
 }

 /*
@@ -1186,7 +1185,7 @@ static void prepare_write_message(struct
ceph_connection *con)
 	/* is there a data payload? */
 	con->out_msg->footer.data_crc = 0;
 	if (m->hdr.data_len) {
-		prepare_message_data(con->out_msg, &con->out_msg_pos);
+		prepare_message_data(con->out_msg);
 		con->out_more = 1;  /* data + footer will follow */
 	} else {
 		/* no, queue up footer too and be done */
@@ -1370,7 +1369,6 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 			size_t len, size_t sent)
 {
 	struct ceph_msg *msg = con->out_msg;
-	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;
 	bool need_crc = false;

 	BUG_ON(!msg);
@@ -1383,7 +1381,6 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 		return;

 	BUG_ON(sent != len);
-	msg_pos->did_page_crc = false;
 }

 static void in_msg_pos_next(struct ceph_connection *con, size_t len,
@@ -1426,9 +1423,8 @@ static int write_partial_message_data(struct
ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
 	struct ceph_msg_data_cursor *cursor = &msg->data.cursor;
-	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;
 	bool do_datacrc = !con->msgr->nocrc;
-	int ret;
+	u32 crc;

 	dout("%s %p msg %p\n", __func__, con, msg);

@@ -1443,27 +1439,28 @@ static int write_partial_message_data(struct
ceph_connection *con)
 	 * need to map the page.  If we have no pages, they have
 	 * been revoked, so use the zero page.
 	 */
+	crc = do_datacrc ? le32_to_cpu(msg->footer.data_crc) : 0;
 	while (cursor->resid) {
 		struct page *page;
 		size_t page_offset;
 		size_t length;
 		bool last_piece;
+		int ret;

 		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
 							&last_piece);
-		if (do_datacrc && !msg_pos->did_page_crc) {
-			u32 crc = le32_to_cpu(msg->footer.data_crc);
+		if (do_datacrc && cursor->need_crc)
 			crc = ceph_crc32c_page(crc, page, page_offset, length);
-			msg->footer.data_crc = cpu_to_le32(crc);
-			msg_pos->did_page_crc = true;
-		}
 		ret = ceph_tcp_sendpage(con->sock, page, page_offset,
 				      length, last_piece);
-		if (ret <= 0)
-			goto out;
+		if (ret <= 0) {
+			msg->footer.data_crc = cpu_to_le32(crc);

+			return ret;
+		}
 		out_msg_pos_next(con, page, length, (size_t) ret);
 	}
+	msg->footer.data_crc = cpu_to_le32(crc);

 	dout("%s %p msg %p done\n", __func__, con, msg);

@@ -1472,9 +1469,8 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		msg->footer.flags |= CEPH_MSG_FOOTER_NOCRC;
 	con_out_kvec_reset(con);
 	prepare_write_message_footer(con);
-	ret = 1;
-out:
-	return ret;
+
+	return 1;	/* must return > 0 to indicate success */
 }

 /*
@@ -2117,24 +2113,29 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 	struct page *page;
 	size_t page_offset;
 	size_t length;
+	u32 crc;
 	int ret;

 	BUG_ON(!msg);
 	if (WARN_ON(!ceph_msg_has_data(msg)))
 		return -EIO;

+	crc = con->in_data_crc;
 	while (cursor->resid) {
 		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
 							NULL);
 		ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
-		if (ret <= 0)
+		if (ret <= 0) {
+			con->in_data_crc = crc;
+
 			return ret;
+		}

 		if (do_datacrc)
-			con->in_data_crc = ceph_crc32c_page(con->in_data_crc,
-							page, page_offset, ret);
+			crc = ceph_crc32c_page(crc, page, page_offset, ret);
 		in_msg_pos_next(con, length, ret);
 	}
+	con->in_data_crc = crc;

 	return 1;	/* must return > 0 to indicate success */
 }
@@ -2230,7 +2231,7 @@ static int read_partial_message(struct
ceph_connection *con)
 		/* prepare for data payload, if any */

 		if (data_len)
-			prepare_message_data(con->in_msg, &con->in_msg_pos);
+			prepare_message_data(con->in_msg);
 	}

 	/* front */
-- 
1.7.9.5

