From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/8] libceph: use data cursor for message pagelist
Date: Sun, 10 Mar 2013 14:17:20 -0500
Message-ID: <513CDC40.4020105@inktank.com>
References: <513CD9BE.1070505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:63592 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab3CJTRX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 15:17:23 -0400
Received: by mail-ia0-f174.google.com with SMTP id k38so1275626iah.19
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 12:17:22 -0700 (PDT)
In-Reply-To: <513CD9BE.1070505@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Switch to using the message cursor for the (non-trail) outgoing
pagelist data item in a message if present.

Notes on the logic changes in out_msg_pos_next():
    - only the mds client uses a ceph pagelist for message data;
    - if the mds client ever uses a pagelist, it never uses a page
      array (or anything else, for that matter) for data in the same
      message;
    - only the osd client uses the trail portion of a message data,
      and when it does, it never uses any other data fields for
      outgoing data in the same message; and finally
    - only the rbd client uses bio message data (never pagelist).

Therefore out_msg_pos_next() can assume:
    - if we're in the trail portion of a message, the message data
      pagelist, data, and bio can be ignored; and
    - if there is a page list, there will never be any a bio or page
      array data, and vice-versa.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index ce81164..c0f89c1 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -921,8 +921,10 @@ static void prepare_message_data(struct ceph_msg *msg,
 #endif
 	msg_pos->data_pos = 0;

-	/* If there's a trail, initialize its cursor */
+	/* Initialize data cursors */

+	if (ceph_msg_has_pagelist(msg))
+		ceph_msg_data_cursor_init(&msg->l);
 	if (ceph_msg_has_trail(msg))
 		ceph_msg_data_cursor_init(&msg->t);

@@ -1210,18 +1212,19 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 {
 	struct ceph_msg *msg = con->out_msg;
 	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;
+	bool need_crc = false;

 	BUG_ON(!msg);
 	BUG_ON(!sent);

 	msg_pos->data_pos += sent;
 	msg_pos->page_pos += sent;
-	if (in_trail) {
-		bool need_crc;
-
+	if (in_trail)
 		need_crc = ceph_msg_data_advance(&msg->t, sent);
-		BUG_ON(need_crc && sent != len);
-	}
+	else if (ceph_msg_has_pagelist(msg))
+		need_crc = ceph_msg_data_advance(&msg->l, sent);
+	BUG_ON(need_crc && sent != len);
+
 	if (sent < len)
 		return;

@@ -1229,13 +1232,10 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 	msg_pos->page_pos = 0;
 	msg_pos->page++;
 	msg_pos->did_page_crc = false;
-	if (ceph_msg_has_pagelist(msg)) {
-		list_rotate_left(&msg->l.pagelist->head);
 #ifdef CONFIG_BLOCK
-	} else if (ceph_msg_has_bio(msg)) {
+	if (ceph_msg_has_bio(msg))
 		iter_bio_next(&msg->b.bio_iter, &msg->b.bio_seg);
 #endif
-	}
 }

 static void in_msg_pos_next(struct ceph_connection *con, size_t len,
@@ -1330,8 +1330,9 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		} else if (ceph_msg_has_pages(msg)) {
 			page = msg->p.pages[msg_pos->page];
 		} else if (ceph_msg_has_pagelist(msg)) {
-			page = list_first_entry(&msg->l.pagelist->head,
-						struct page, lru);
+			use_cursor = true;
+			page = ceph_msg_data_next(&msg->l, &page_offset,
+							&length, &last_piece);
 #ifdef CONFIG_BLOCK
 		} else if (ceph_msg_has_bio(msg)) {
 			struct bio_vec *bv;
-- 
1.7.9.5

