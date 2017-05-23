From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/5] libceph: make ceph_msg_data_advance() return void
Date: Tue, 23 May 2017 18:33:55 +0200
Message-ID: <1495557238-1077-3-git-send-email-idryomov@gmail.com>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33074 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933184AbdEWQeN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 12:34:13 -0400
Received: by mail-qk0-f193.google.com with SMTP id o85so23449548qkh.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 09:34:13 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15sm784055qki.47.2017.05.23.09.34.11
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 09:34:11 -0700 (PDT)
In-Reply-To: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Both callers ignore the returned bool.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5766a6c896c4..d7ab481b2508 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1174,8 +1174,8 @@ static struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
  * Returns true if the result moves the cursor on to the next piece
  * of the data item.
  */
-static bool ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
-				size_t bytes)
+static void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
+				  size_t bytes)
 {
 	bool new_piece;
 
@@ -1207,8 +1207,6 @@ static bool ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
 		new_piece = true;
 	}
 	cursor->need_crc = new_piece;
-
-	return new_piece;
 }
 
 static size_t sizeof_footer(struct ceph_connection *con)
@@ -1577,7 +1575,6 @@ static int write_partial_message_data(struct ceph_connection *con)
 		size_t page_offset;
 		size_t length;
 		bool last_piece;
-		bool need_crc;
 		int ret;
 
 		page = ceph_msg_data_next(cursor, &page_offset, &length,
@@ -1592,7 +1589,7 @@ static int write_partial_message_data(struct ceph_connection *con)
 		}
 		if (do_datacrc && cursor->need_crc)
 			crc = ceph_crc32c_page(crc, page, page_offset, length);
-		need_crc = ceph_msg_data_advance(cursor, (size_t)ret);
+		ceph_msg_data_advance(cursor, (size_t)ret);
 	}
 
 	dout("%s %p msg %p done\n", __func__, con, msg);
@@ -2299,7 +2296,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
 
 		if (do_datacrc)
 			crc = ceph_crc32c_page(crc, page, page_offset, ret);
-		(void) ceph_msg_data_advance(cursor, (size_t)ret);
+		ceph_msg_data_advance(cursor, (size_t)ret);
 	}
 	if (do_datacrc)
 		con->in_data_crc = crc;
-- 
2.4.3

