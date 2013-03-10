From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] libceph: more cleanup of write_partial_msg_pages()
Date: Sun, 10 Mar 2013 15:36:55 -0500
Message-ID: <513CEEE7.2090809@inktank.com>
References: <513CEE83.4040900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:46174 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab3CJUg7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 16:36:59 -0400
Received: by mail-qe0-f49.google.com with SMTP id 1so1918562qec.8
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 13:36:58 -0700 (PDT)
In-Reply-To: <513CEE83.4040900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Basically all cases in write_partial_msg_pages() use the cursor, and
as a result we can simplify that function quite a bit.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b7ddf2b..6c88db4 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1466,7 +1466,6 @@ static int write_partial_message_data(struct
ceph_connection *con)
 	unsigned int data_len = le32_to_cpu(msg->hdr.data_len);
 	bool do_datacrc = !con->msgr->nocrc;
 	int ret;
-	int total_max_write;

 	dout("%s %p msg %p page %d offset %d\n", __func__,
 	     con, msg, msg_pos->page, msg_pos->page_pos);
@@ -1480,36 +1479,30 @@ static int write_partial_message_data(struct
ceph_connection *con)
 	 * been revoked, so use the zero page.
 	 */
 	while (data_len > msg_pos->data_pos) {
-		struct page *page = NULL;
+		struct page *page;
 		size_t page_offset;
 		size_t length;
-		bool use_cursor = false;
-		bool last_piece = true;	/* preserve existing behavior */
-
-		total_max_write = data_len - msg_pos->data_pos;
+		bool last_piece;

 		if (ceph_msg_has_pages(msg)) {
-			use_cursor = true;
 			page = ceph_msg_data_next(&msg->p, &page_offset,
 							&length, &last_piece);
 		} else if (ceph_msg_has_pagelist(msg)) {
-			use_cursor = true;
 			page = ceph_msg_data_next(&msg->l, &page_offset,
 							&length, &last_piece);
 #ifdef CONFIG_BLOCK
 		} else if (ceph_msg_has_bio(msg)) {
-			use_cursor = true;
 			page = ceph_msg_data_next(&msg->b, &page_offset,
 							&length, &last_piece);
 #endif
 		} else {
-			page = zero_page;
-		}
-		if (!use_cursor) {
-			length = min_t(int, PAGE_SIZE - msg_pos->page_pos,
-					    total_max_write);
+			unsigned int end;

+			last_piece = data_len <= PAGE_SIZE;
 			page_offset = msg_pos->page_pos;
+			end = last_piece ? data_len : PAGE_SIZE;
+			length = end - page_offset;
+			page = zero_page;
 		}
 		if (do_datacrc && !msg_pos->did_page_crc) {
 			u32 crc = le32_to_cpu(msg->footer.data_crc);
-- 
1.7.9.5

