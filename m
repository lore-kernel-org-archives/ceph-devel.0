From: Alex Elder <elder@inktank.com>
Subject: [PATCH 10/12] libceph: small changes to messenger.c
Date: Thu, 21 Jun 2012 09:22:38 -0500
Message-ID: <4FE32E2E.6060005@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59948 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab2FUOWk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:22:40 -0400
Received: by gglu4 with SMTP id u4so497540ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:22:39 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch gathers a few small changes in "net/ceph/messenger.c":
  out_msg_pos_next()
    - small logic change that mostly affects indentation
  write_partial_msg_pages().
    - use a local variable trail_off to represent the offset into
      a message of the trail portion of the data (if present)
    - once we are in the trail portion we will always be there, so we
      don't always need to check against our data position
    - avoid computing len twice after we've reached the trail
    - get rid of the variable tmpcrc, which is not needed
    - trail_off and trail_len never change so mark them const
    - update some comments
  read_partial_message_bio()
    - bio_iovec_idx() will never return an error, so don't bother
      checking for it

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   63
+++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -931,21 +931,23 @@ static void out_msg_pos_next(struct ceph

 	con->out_msg_pos.data_pos += sent;
 	con->out_msg_pos.page_pos += sent;
-	if (sent == len) {
-		con->out_msg_pos.page_pos = 0;
-		con->out_msg_pos.page++;
-		con->out_msg_pos.did_page_crc = false;
-		if (in_trail)
-			list_move_tail(&page->lru,
-				       &msg->trail->head);
-		else if (msg->pagelist)
-			list_move_tail(&page->lru,
-				       &msg->pagelist->head);
+	if (sent < len)
+		return;
+
+	BUG_ON(sent != len);
+	con->out_msg_pos.page_pos = 0;
+	con->out_msg_pos.page++;
+	con->out_msg_pos.did_page_crc = false;
+	if (in_trail)
+		list_move_tail(&page->lru,
+			       &msg->trail->head);
+	else if (msg->pagelist)
+		list_move_tail(&page->lru,
+			       &msg->pagelist->head);
 #ifdef CONFIG_BLOCK
-		else if (msg->bio)
-			iter_bio_next(&msg->bio_iter, &msg->bio_seg);
+	else if (msg->bio)
+		iter_bio_next(&msg->bio_iter, &msg->bio_seg);
 #endif
-	}
 }

 /*
@@ -964,30 +966,31 @@ static int write_partial_msg_pages(struc
 	int ret;
 	int total_max_write;
 	bool in_trail = false;
-	size_t trail_len = (msg->trail ? msg->trail->length : 0);
+	const size_t trail_len = (msg->trail ? msg->trail->length : 0);
+	const size_t trail_off = data_len - trail_len;

 	dout("write_partial_msg_pages %p msg %p page %d/%d offset %d\n",
 	     con, msg, con->out_msg_pos.page, msg->nr_pages,
 	     con->out_msg_pos.page_pos);

+	/*
+	 * Iterate through each page that contains data to be
+	 * written, and send as much as possible for each.
+	 *
+	 * If we are calculating the data crc (the default), we will
+	 * need to map the page.  If we have no pages, they have
+	 * been revoked, so use the zero page.
+	 */
 	while (data_len > con->out_msg_pos.data_pos) {
 		struct page *page = NULL;
 		int max_write = PAGE_SIZE;
 		int bio_offset = 0;

-		total_max_write = data_len - trail_len -
-			con->out_msg_pos.data_pos;
-
-		/*
-		 * if we are calculating the data crc (the default), we need
-		 * to map the page.  if our pages[] has been revoked, use the
-		 * zero page.
-		 */
-
-		/* have we reached the trail part of the data? */
-		if (con->out_msg_pos.data_pos >= data_len - trail_len) {
-			in_trail = true;
+		in_trail = in_trail || con->out_msg_pos.data_pos >= trail_off;
+		if (!in_trail)
+			total_max_write = trail_off - con->out_msg_pos.data_pos;

+		if (in_trail) {
 			total_max_write = data_len - con->out_msg_pos.data_pos;

 			page = list_first_entry(&msg->trail->head,
@@ -1014,14 +1017,13 @@ static int write_partial_msg_pages(struc

 		if (do_datacrc && !con->out_msg_pos.did_page_crc) {
 			void *base;
-			u32 crc;
-			u32 tmpcrc = le32_to_cpu(msg->footer.data_crc);
+			u32 crc = le32_to_cpu(msg->footer.data_crc);
 			char *kaddr;

 			kaddr = kmap(page);
 			BUG_ON(kaddr == NULL);
 			base = kaddr + con->out_msg_pos.page_pos + bio_offset;
-			crc = crc32c(tmpcrc, base, len);
+			crc = crc32c(crc, base, len);
 			msg->footer.data_crc = cpu_to_le32(crc);
 			con->out_msg_pos.did_page_crc = true;
 		}
@@ -1726,9 +1728,6 @@ static int read_partial_message_bio(stru
 	void *p;
 	int ret, left;

-	if (IS_ERR(bv))
-		return PTR_ERR(bv);
-
 	left = min((int)(data_len - con->in_msg_pos.data_pos),
 		   (int)(bv->bv_len - con->in_msg_pos.page_pos));

