From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] libceph: kill ceph message bio_iter, bio_seg
Date: Tue, 12 Mar 2013 20:05:35 -0500
Message-ID: <513FD0DF.30103@inktank.com>
References: <513FD092.2030106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:49522 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBFi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:05:38 -0400
Received: by mail-ob0-f181.google.com with SMTP id ni5so483082obc.40
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:05:38 -0700 (PDT)
In-Reply-To: <513FD092.2030106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The bio_iter and bio_seg fields in a message are no longer used, we
use the cursor instead.  So get rid of them and the functions that
operate on them them.

This is related to:
    http://tracker.ceph.com/issues/4428

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    6 +-----
 net/ceph/messenger.c           |   31 -------------------------------
 2 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 459e552..252e01b 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -121,11 +121,7 @@ struct ceph_msg_data {
 	enum ceph_msg_data_type		type;
 	union {
 #ifdef CONFIG_BLOCK
-		struct {
-			struct bio	*bio_iter;	/* iterator */
-			struct bio	*bio;
-			unsigned int	bio_seg;	/* current seg in bio */
-		};
+		struct bio		*bio;
 #endif /* CONFIG_BLOCK */
 		struct {
 			struct page	**pages;	/* NOT OWNER. */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1b003b4..835447c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -716,29 +716,6 @@ static void con_out_kvec_add(struct ceph_connection
*con,
 }

 #ifdef CONFIG_BLOCK
-static void init_bio_iter(struct bio *bio, struct bio **bio_iter,
-			unsigned int *bio_seg)
-{
-	if (!bio) {
-		*bio_iter = NULL;
-		*bio_seg = 0;
-		return;
-	}
-	*bio_iter = bio;
-	*bio_seg = (unsigned int) bio->bi_idx;
-}
-
-static void iter_bio_next(struct bio **bio_iter, unsigned int *seg)
-{
-	if (*bio_iter == NULL)
-		return;
-
-	BUG_ON(*seg >= (*bio_iter)->bi_vcnt);
-
-	(*seg)++;
-	if (*seg == (*bio_iter)->bi_vcnt)
-		init_bio_iter((*bio_iter)->bi_next, bio_iter, seg);
-}

 /*
  * For a bio data item, a piece is whatever remains of the next
@@ -1112,10 +1089,6 @@ static void prepare_message_data(struct ceph_msg
*msg,
 		msg_pos->page_pos = msg->p.alignment;
 	else
 		msg_pos->page_pos = 0;
-#ifdef CONFIG_BLOCK
-	if (ceph_msg_has_bio(msg))
-		init_bio_iter(msg->b.bio, &msg->b.bio_iter, &msg->b.bio_seg);
-#endif
 	msg_pos->data_pos = 0;

 	/* Initialize data cursors */
@@ -1460,10 +1433,6 @@ static void in_msg_pos_next(struct
ceph_connection *con, size_t len,
 	BUG_ON(received != len);
 	msg_pos->page_pos = 0;
 	msg_pos->page++;
-#ifdef CONFIG_BLOCK
-	if (msg->b.bio)
-		iter_bio_next(&msg->b.bio_iter, &msg->b.bio_seg);
-#endif /* CONFIG_BLOCK */
 }

 static u32 ceph_crc32c_page(u32 crc, struct page *page,
-- 
1.7.9.5

