From: Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH v3] net: ceph: messenger: Use local variable cursor instead of &msg->cursor
Date: Mon, 19 Oct 2015 21:59:00 +0530
Message-ID: <1445272140-7084-1-git-send-email-shraddha.6596@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34880 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbJSQ3J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 12:29:09 -0400
Received: by pasz6 with SMTP id z6so34684477pas.2
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 09:29:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Alex Elder <elder@ieee.org>

Use local variable cursor in place of &msg->cursor in
read_partial_msg_data() and write_partial_msg_data()

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
Changes in v3-
 Replace &msg->cursor with cursor in write_partial_msg_data() too

 net/ceph/messenger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b9b0e3b..01b567b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1552,8 +1552,8 @@ static int write_partial_message_data(struct ceph_connection *con)
 		bool need_crc;
 		int ret;
 
-		page = ceph_msg_data_next(&msg->cursor, &page_offset, &length,
-							&last_piece);
+		page = ceph_msg_data_next(cursor, &page_offset, &length,
+						  &last_piece);
 		ret = ceph_tcp_sendpage(con->sock, page, page_offset,
 					length, !last_piece);
 		if (ret <= 0) {
@@ -1564,7 +1564,7 @@ static int write_partial_message_data(struct ceph_connection *con)
 		}
 		if (do_datacrc && cursor->need_crc)
 			crc = ceph_crc32c_page(crc, page, page_offset, length);
-		need_crc = ceph_msg_data_advance(&msg->cursor, (size_t)ret);
+		need_crc = ceph_msg_data_advance(cursor, (size_t)ret);
 	}
 
 	dout("%s %p msg %p done\n", __func__, con, msg);
@@ -2246,8 +2246,8 @@ static int read_partial_msg_data(struct ceph_connection *con)
 	if (do_datacrc)
 		crc = con->in_data_crc;
 	while (cursor->resid) {
-		page = ceph_msg_data_next(&msg->cursor, &page_offset, &length,
-							NULL);
+		page = ceph_msg_data_next(cursor, &page_offset, &length,
+						  NULL);
 		ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
 		if (ret <= 0) {
 			if (do_datacrc)
@@ -2258,7 +2258,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
 
 		if (do_datacrc)
 			crc = ceph_crc32c_page(crc, page, page_offset, ret);
-		(void) ceph_msg_data_advance(&msg->cursor, (size_t)ret);
+		(void) ceph_msg_data_advance(cursor, (size_t)ret);
 	}
 	if (do_datacrc)
 		con->in_data_crc = crc;
-- 
2.1.4

