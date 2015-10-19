From: Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH v2] Net: ceph: messenger: Use local variable cursor in read_partial_msg_data()
Date: Mon, 19 Oct 2015 08:19:35 +0530
Message-ID: <1445222975-16086-1-git-send-email-shraddha.6596@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36306 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbbJSCtn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Oct 2015 22:49:43 -0400
Received: by pacfv9 with SMTP id fv9so79502035pac.3
        for <ceph-devel@vger.kernel.org>; Sun, 18 Oct 2015 19:49:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Alex Elder <elder@ieee.org>

Use local variable cursor in place of &msg->cursor in
 read_partial_msg_data()

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
Changes in v2-
 Drop incorrect use of cursor

 net/ceph/messenger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b9b0e3b..b087edd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
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

