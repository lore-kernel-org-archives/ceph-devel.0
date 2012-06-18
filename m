From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/6] libceph: move init_bio_*() functions up
Date: Mon, 18 Jun 2012 10:33:23 -0500
Message-ID: <4FDF4A43.4090702@inktank.com>
References: <4FDF4948.10306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:52517 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2FRPdY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:33:24 -0400
Received: by ghrr11 with SMTP id r11so3757733ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 08:33:24 -0700 (PDT)
In-Reply-To: <4FDF4948.10306@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move init_bio_iter() and iter_bio_next() up in their source file so
the'll be defined before they're needed.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   50
+++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -590,6 +590,31 @@ static void con_out_kvec_add(struct ceph
 	con->out_kvec_bytes += size;
 }

+#ifdef CONFIG_BLOCK
+static void init_bio_iter(struct bio *bio, struct bio **iter, int *seg)
+{
+	if (!bio) {
+		*iter = NULL;
+		*seg = 0;
+		return;
+	}
+	*iter = bio;
+	*seg = bio->bi_idx;
+}
+
+static void iter_bio_next(struct bio **bio_iter, int *seg)
+{
+	if (*bio_iter == NULL)
+		return;
+
+	BUG_ON(*seg >= (*bio_iter)->bi_vcnt);
+
+	(*seg)++;
+	if (*seg == (*bio_iter)->bi_vcnt)
+		init_bio_iter((*bio_iter)->bi_next, bio_iter, seg);
+}
+#endif
+
 static void prepare_write_message_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
@@ -892,31 +917,6 @@ out:
 	return ret;  /* done! */
 }

-#ifdef CONFIG_BLOCK
-static void init_bio_iter(struct bio *bio, struct bio **iter, int *seg)
-{
-	if (!bio) {
-		*iter = NULL;
-		*seg = 0;
-		return;
-	}
-	*iter = bio;
-	*seg = bio->bi_idx;
-}
-
-static void iter_bio_next(struct bio **bio_iter, int *seg)
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
-#endif
-
 static void out_msg_pos_next(struct ceph_connection *con, struct page
*page,
 			size_t len, size_t sent, bool in_trail)
 {

