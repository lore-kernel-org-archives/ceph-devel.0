From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/6] libceph: move init of bio_iter
Date: Mon, 18 Jun 2012 10:33:27 -0500
Message-ID: <4FDF4A47.6050003@inktank.com>
References: <4FDF4948.10306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:52517 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab2FRPd3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:33:29 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so3757733ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 08:33:28 -0700 (PDT)
In-Reply-To: <4FDF4948.10306@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If a message has a non-null bio pointer, its bio_iter field is
initialized in write_partial_msg_pages() if this has not been done
already.  This is really a one-time setup operation for sending a
message's (bio) data, so move that initialization code into
prepare_write_message_data() which serves that purpose.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -627,6 +627,10 @@ static void prepare_write_message_data(s
 		con->out_msg_pos.page_pos = msg->page_alignment;
 	else
 		con->out_msg_pos.page_pos = 0;
+#ifdef CONFIG_BLOCK
+	if (msg->bio && !msg->bio_iter)
+		init_bio_iter(msg->bio, &msg->bio_iter, &msg->bio_seg);
+#endif
 	con->out_msg_pos.data_pos = 0;
 	con->out_msg_pos.did_page_crc = false;
 	con->out_more = 1;  /* data + footer will follow */
@@ -966,11 +970,6 @@ static int write_partial_msg_pages(struc
 	     con, msg, con->out_msg_pos.page, msg->nr_pages,
 	     con->out_msg_pos.page_pos);

-#ifdef CONFIG_BLOCK
-	if (msg->bio && !msg->bio_iter)
-		init_bio_iter(msg->bio, &msg->bio_iter, &msg->bio_seg);
-#endif
-
 	while (data_len > con->out_msg_pos.data_pos) {
 		struct page *page = NULL;
 		int max_write = PAGE_SIZE;

