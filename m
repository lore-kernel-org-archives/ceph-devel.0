From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] libceph: kill most of ceph_msg_pos
Date: Tue, 12 Mar 2013 20:09:32 -0500
Message-ID: <513FD1CC.804@inktank.com>
References: <513FD178.60207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:62022 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3CMBJf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:09:35 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so524952oag.8
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:09:35 -0700 (PDT)
In-Reply-To: <513FD178.60207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All but one of the fields in the ceph_msg_pos structure are now
never used (only assigned), so get rid of them.  This allows
several small blocks of code to go away.

This is cleanup of old code related to:
    http://tracker.ceph.com/issues/4428

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    2 --
 net/ceph/messenger.c           |   22 +---------------------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index af786b2..c76b228 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -157,8 +157,6 @@ struct ceph_msg {
 };

 struct ceph_msg_pos {
-	int page, page_pos;  /* which page; offset in page */
-	int data_pos;        /* offset in data payload */
 	bool did_page_crc;   /* true if we've calculated crc for current page */
 };

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 389dc62..5e62d02 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1083,14 +1083,6 @@ static void prepare_message_data(struct ceph_msg
*msg,
 	data_len = le32_to_cpu(msg->hdr.data_len);
 	BUG_ON(!data_len);

-	/* initialize page iterator */
-	msg_pos->page = 0;
-	if (ceph_msg_has_data(msg))
-		msg_pos->page_pos = msg->data.alignment;
-	else
-		msg_pos->page_pos = 0;
-	msg_pos->data_pos = 0;
-
 	/* Initialize data cursors */

 	ceph_msg_data_cursor_init(&msg->data, data_len);
@@ -1384,8 +1376,6 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 	BUG_ON(!msg);
 	BUG_ON(!sent);

-	msg_pos->data_pos += sent;
-	msg_pos->page_pos += sent;
 	need_crc = ceph_msg_data_advance(&msg->data, sent);
 	BUG_ON(need_crc && sent != len);

@@ -1393,8 +1383,6 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 		return;

 	BUG_ON(sent != len);
-	msg_pos->page_pos = 0;
-	msg_pos->page++;
 	msg_pos->did_page_crc = false;
 }

@@ -1402,21 +1390,16 @@ static void in_msg_pos_next(struct
ceph_connection *con, size_t len,
 				size_t received)
 {
 	struct ceph_msg *msg = con->in_msg;
-	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;

 	BUG_ON(!msg);
 	BUG_ON(!received);

-	msg_pos->data_pos += received;
-	msg_pos->page_pos += received;
 	(void) ceph_msg_data_advance(&msg->data, received);

 	if (received < len)
 		return;

 	BUG_ON(received != len);
-	msg_pos->page_pos = 0;
-	msg_pos->page++;
 }

 static u32 ceph_crc32c_page(u32 crc, struct page *page,
@@ -1447,8 +1430,7 @@ static int write_partial_message_data(struct
ceph_connection *con)
 	bool do_datacrc = !con->msgr->nocrc;
 	int ret;

-	dout("%s %p msg %p page %d offset %d\n", __func__,
-	     con, msg, msg_pos->page, msg_pos->page_pos);
+	dout("%s %p msg %p\n", __func__, con, msg);

 	if (WARN_ON(!ceph_msg_has_data(msg)))
 		return -EINVAL;
@@ -2132,7 +2114,6 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 	struct ceph_msg *msg = con->in_msg;
 	struct ceph_msg_data_cursor *cursor = &msg->data.cursor;
 	const bool do_datacrc = !con->msgr->nocrc;
-	unsigned int data_len;
 	struct page *page;
 	size_t page_offset;
 	size_t length;
@@ -2142,7 +2123,6 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 	if (WARN_ON(!ceph_msg_has_data(msg)))
 		return -EIO;

-	data_len = le32_to_cpu(con->in_hdr.data_len);
 	while (cursor->resid) {
 		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
 							NULL);
-- 
1.7.9.5

