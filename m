From: Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH] Net: ceph: messenger: Use local variable cursor in read_partial_msg_data()
Date: Sun, 18 Oct 2015 15:30:03 +0530
Message-ID: <1445162403-7612-1-git-send-email-shraddha.6596@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38864 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbJRKAP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Oct 2015 06:00:15 -0400
Received: by wicll6 with SMTP id ll6so61934348wic.1
        for <ceph-devel@vger.kernel.org>; Sun, 18 Oct 2015 03:00:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org

Use local variable cursor in place of &msg->cursor in 
 read_partial_msg_data()

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 net/ceph/messenger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b9b0e3b..b3d1973 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2231,7 +2231,7 @@ static int read_partial_message_section(struct ceph_connection *con,
 static int read_partial_msg_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->in_msg;
-	struct ceph_msg_data_cursor *cursor = &msg->cursor;
+	struct ceph_msg_data_cursor *cursor = cursor;
 	const bool do_datacrc = !con->msgr->nocrc;
 	struct page *page;
 	size_t page_offset;
@@ -2246,7 +2246,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
 	if (do_datacrc)
 		crc = con->in_data_crc;
 	while (cursor->resid) {
-		page = ceph_msg_data_next(&msg->cursor, &page_offset, &length,
+		page = ceph_msg_data_next(cursor, &page_offset, &length,
 							NULL);
 		ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
 		if (ret <= 0) {
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

