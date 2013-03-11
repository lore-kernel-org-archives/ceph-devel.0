From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4, v2] libceph: more cleanup of write_partial_msg_pages()
Date: Mon, 11 Mar 2013 00:08:10 -0500
Message-ID: <513D66BA.8010106@inktank.com>
References: <513CEE83.4040900@inktank.com> <513CEEE7.2090809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:55504 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab3CKFIO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 01:08:14 -0400
Received: by mail-qe0-f50.google.com with SMTP id k5so2058915qej.37
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 22:08:13 -0700 (PDT)
In-Reply-To: <513CEEE7.2090809@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I was a little sloppy in dealing with the zero_page case in
write_partial_message_data(), and I believe it led to some
problems I saw in testing.  So I've modified it so the length
and last_piece values are calculated correctly, and that's
reflected in this updated version of the patch.

					-Alex

Basically all cases in write_partial_msg_pages() use the cursor, and
as a result we can simplify that function quite a bit.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: fixed length and last_piece calculation for zero_page

 net/ceph/messenger.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b7ddf2b..6818c2f 100644
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
@@ -1480,36 +1479,29 @@ static int write_partial_message_data(struct
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
+			unsigned int resid = data_len - msg_pos->data_pos;

+			page = zero_page;
 			page_offset = msg_pos->page_pos;
+			length = min(resid, PAGE_SIZE - page_offset);
+			last_piece = length == resid;
 		}
 		if (do_datacrc && !msg_pos->did_page_crc) {
 			u32 crc = le32_to_cpu(msg->footer.data_crc);
-- 
1.7.9.5


