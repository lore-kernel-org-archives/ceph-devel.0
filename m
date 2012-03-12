From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 5/5] libceph: isolate kmap() call in write_partial_msg_pages()
Date: Mon, 12 Mar 2012 17:40:30 -0500
Message-ID: <4F5E7B5E.2050400@dreamhost.com>
References: <4F5E79C6.6040301@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58522 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533Ab2CLWk0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:40:26 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id CCB8E243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:41:00 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A00812439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:41:00 -0700 (PDT)
In-Reply-To: <4F5E79C6.6040301@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In write_partial_msg_pages(), every case now does an identical call
to kmap(page).  Instead, just call it once inside the CRC-computing
block where it's needed.  Move the definition of kaddr inside that
block, and make it a (char *) to ensure portable pointer arithmetic.

We still don't kunmap() it until after the sendpage() call, in case
that also ends up needing to use the mapping.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   13 ++-----------
  1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2bf9ab4..f0993af 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -835,7 +835,6 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)

  	while (data_len > con->out_msg_pos.data_pos) {
  		struct page *page = NULL;
-		void *kaddr = NULL;
  		int max_write = PAGE_SIZE;
  		int bio_offset = 0;

@@ -856,18 +855,12 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)

  			page = list_first_entry(&msg->trail->head,
  						struct page, lru);
-			if (do_datacrc)
-				kaddr = kmap(page);
  			max_write = PAGE_SIZE;
  		} else if (msg->pages) {
  			page = msg->pages[con->out_msg_pos.page];
-			if (do_datacrc)
-				kaddr = kmap(page);
  		} else if (msg->pagelist) {
  			page = list_first_entry(&msg->pagelist->head,
  						struct page, lru);
-			if (do_datacrc)
-				kaddr = kmap(page);
  #ifdef CONFIG_BLOCK
  		} else if (msg->bio) {
  			struct bio_vec *bv;
@@ -875,14 +868,10 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)
  			bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
  			page = bv->bv_page;
  			bio_offset = bv->bv_offset;
-			if (do_datacrc)
-				kaddr = kmap(page);
  			max_write = bv->bv_len;
  #endif
  		} else {
  			page = zero_page;
-			if (do_datacrc)
-				kaddr = kmap(page);
  		}
  		len = min_t(int, max_write - con->out_msg_pos.page_pos,
  			    total_max_write);
@@ -891,7 +880,9 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)
  			void *base;
  			u32 crc;
  			u32 tmpcrc = le32_to_cpu(con->out_msg->footer.data_crc);
+			char *kaddr;

+			kaddr = kmap(page);
  			BUG_ON(kaddr == NULL);
  			base = kaddr + con->out_msg_pos.page_pos + bio_offset;
  			crc = crc32c(tmpcrc, base, len);
-- 
1.7.5.4

