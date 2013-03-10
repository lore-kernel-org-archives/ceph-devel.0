From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] libceph: kill message trail
Date: Sun, 10 Mar 2013 15:36:44 -0500
Message-ID: <513CEEDC.5050508@inktank.com>
References: <513CEE83.4040900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:53465 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab3CJUgr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 16:36:47 -0400
Received: by mail-qa0-f42.google.com with SMTP id cr7so656165qab.1
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 13:36:46 -0700 (PDT)
In-Reply-To: <513CEE83.4040900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The wart that is the ceph message trail can now be removed, because
its only user was the osd client, and the previous patch made that
no longer hte case.

The result allows write_partial_msg_pages() to be simplified
considerably.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    4 ----
 net/ceph/messenger.c           |   44
+++++-----------------------------------
 2 files changed, 5 insertions(+), 43 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index b53b9ef..0e4536c 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -69,7 +69,6 @@ struct ceph_messenger {
 #ifdef CONFIG_BLOCK
 #define ceph_msg_has_bio(m)		((m)->b.type == CEPH_MSG_DATA_BIO)
 #endif /* CONFIG_BLOCK */
-#define ceph_msg_has_trail(m)		((m)->t.type == CEPH_MSG_DATA_PAGELIST)

 enum ceph_msg_data_type {
 	CEPH_MSG_DATA_NONE,	/* message contains no data payload */
@@ -155,7 +154,6 @@ struct ceph_msg {
 #ifdef CONFIG_BLOCK
 	struct ceph_msg_data	b;	/* bio */
 #endif /* CONFIG_BLOCK */
-	struct ceph_msg_data	t;	/* trail */

 	struct ceph_connection *con;
 	struct list_head list_head;	/* links for connection lists */
@@ -295,8 +293,6 @@ extern void ceph_msg_data_set_pages(struct ceph_msg
*msg, struct page **pages,
 extern void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
 				struct ceph_pagelist *pagelist);
 extern void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio);
-extern void ceph_msg_data_set_trail(struct ceph_msg *msg,
-				struct ceph_pagelist *trail);

 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 12d416f..b7ddf2b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1105,8 +1105,6 @@ static void prepare_message_data(struct ceph_msg *msg,
 		ceph_msg_data_cursor_init(&msg->p);
 	if (ceph_msg_has_pagelist(msg))
 		ceph_msg_data_cursor_init(&msg->l);
-	if (ceph_msg_has_trail(msg))
-		ceph_msg_data_cursor_init(&msg->t);

 	msg_pos->did_page_crc = false;
 }
@@ -1388,7 +1386,7 @@ out:
 }

 static void out_msg_pos_next(struct ceph_connection *con, struct page
*page,
-			size_t len, size_t sent, bool in_trail)
+			size_t len, size_t sent)
 {
 	struct ceph_msg *msg = con->out_msg;
 	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;
@@ -1399,9 +1397,7 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,

 	msg_pos->data_pos += sent;
 	msg_pos->page_pos += sent;
-	if (in_trail)
-		need_crc = ceph_msg_data_advance(&msg->t, sent);
-	else if (ceph_msg_has_pages(msg))
+	if (ceph_msg_has_pages(msg))
 		need_crc = ceph_msg_data_advance(&msg->p, sent);
 	else if (ceph_msg_has_pagelist(msg))
 		need_crc = ceph_msg_data_advance(&msg->l, sent);
@@ -1471,14 +1467,6 @@ static int write_partial_message_data(struct
ceph_connection *con)
 	bool do_datacrc = !con->msgr->nocrc;
 	int ret;
 	int total_max_write;
-	bool in_trail = false;
-	size_t trail_len = 0;
-	size_t trail_off = data_len;
-
-	if (ceph_msg_has_trail(msg)) {
-		trail_len = msg->t.pagelist->length;
-		trail_off -= trail_len;
-	}

 	dout("%s %p msg %p page %d offset %d\n", __func__,
 	     con, msg, msg_pos->page, msg_pos->page_pos);
@@ -1498,16 +1486,9 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		bool use_cursor = false;
 		bool last_piece = true;	/* preserve existing behavior */

-		in_trail = in_trail || msg_pos->data_pos >= trail_off;
-		if (!in_trail)
-			total_max_write = trail_off - msg_pos->data_pos;
+		total_max_write = data_len - msg_pos->data_pos;

-		if (in_trail) {
-			BUG_ON(!ceph_msg_has_trail(msg));
-			use_cursor = true;
-			page = ceph_msg_data_next(&msg->t, &page_offset,
-							&length, &last_piece);
-		} else if (ceph_msg_has_pages(msg)) {
+		if (ceph_msg_has_pages(msg)) {
 			use_cursor = true;
 			page = ceph_msg_data_next(&msg->p, &page_offset,
 							&length, &last_piece);
@@ -1542,7 +1523,7 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		if (ret <= 0)
 			goto out;

-		out_msg_pos_next(con, page, length, (size_t) ret, in_trail);
+		out_msg_pos_next(con, page, length, (size_t) ret);
 	}

 	dout("%s %p msg %p done\n", __func__, con, msg);
@@ -3135,17 +3116,6 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
struct bio *bio)
 }
 EXPORT_SYMBOL(ceph_msg_data_set_bio);

-void ceph_msg_data_set_trail(struct ceph_msg *msg, struct ceph_pagelist
*trail)
-{
-	BUG_ON(!trail);
-	BUG_ON(!trail->length);
-	BUG_ON(msg->b.type != CEPH_MSG_DATA_NONE);
-
-	msg->t.type = CEPH_MSG_DATA_PAGELIST;
-	msg->t.pagelist = trail;
-}
-EXPORT_SYMBOL(ceph_msg_data_set_trail);
-
 /*
  * construct a new message with given type, size
  * the new msg has a ref count of 1.
@@ -3169,7 +3139,6 @@ struct ceph_msg *ceph_msg_new(int type, int
front_len, gfp_t flags,
 	ceph_msg_data_init(&m->p);
 	ceph_msg_data_init(&m->l);
 	ceph_msg_data_init(&m->b);
-	ceph_msg_data_init(&m->t);

 	/* front */
 	m->front_max = front_len;
@@ -3335,9 +3304,6 @@ void ceph_msg_last_put(struct kref *kref)
 		m->l.pagelist = NULL;
 	}

-	if (ceph_msg_has_trail(m))
-		m->t.pagelist = NULL;
-
 	if (m->pool)
 		ceph_msgpool_put(m->pool, m);
 	else
-- 
1.7.9.5

