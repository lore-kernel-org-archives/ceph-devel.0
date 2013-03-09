From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/8] libceph: kill args in read_partial_message_bio()
Date: Sat, 09 Mar 2013 09:14:25 -0600
Message-ID: <513B51D1.5090801@inktank.com>
References: <513B5116.2020305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:59000 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288Ab3CIPO3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 10:14:29 -0500
Received: by mail-ia0-f175.google.com with SMTP id e16so669443iaa.20
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 07:14:29 -0800 (PST)
In-Reply-To: <513B5116.2020305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is only one caller for read_partial_message_bio(), and it
always passes &msg->bio_iter and &bio_seg as the second and third
arguments.  Furthermore, the message in question is always the
connection's in_msg, and we can get that inside the called function.

So drop those two parameters and use their derived equivalents.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 962b2cd..2017b88 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1819,14 +1819,16 @@ static int read_partial_message_pages(struct
ceph_connection *con,

 #ifdef CONFIG_BLOCK
 static int read_partial_message_bio(struct ceph_connection *con,
-				    struct bio **bio_iter,
-				    unsigned int *bio_seg,
 				    unsigned int data_len, bool do_datacrc)
 {
-	struct bio_vec *bv = bio_iovec_idx(*bio_iter, *bio_seg);
+	struct ceph_msg *msg = con->in_msg;
+	struct bio_vec *bv;
 	void *p;
 	int ret, left;

+	BUG_ON(!msg);
+	BUG_ON(!msg->bio_iter);
+	bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
 	left = min((int)(data_len - con->in_msg_pos.data_pos),
 		   (int)(bv->bv_len - con->in_msg_pos.page_pos));

@@ -1845,7 +1847,7 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 	con->in_msg_pos.page_pos += ret;
 	if (con->in_msg_pos.page_pos == bv->bv_len) {
 		con->in_msg_pos.page_pos = 0;
-		iter_bio_next(bio_iter, bio_seg);
+		iter_bio_next(&msg->bio_iter, &msg->bio_seg);
 	}

 	return ret;
@@ -1975,9 +1977,7 @@ static int read_partial_message(struct
ceph_connection *con)
 				return ret;
 #ifdef CONFIG_BLOCK
 		} else if (m->bio) {
-			BUG_ON(!m->bio_iter);
 			ret = read_partial_message_bio(con,
-						 &m->bio_iter, &m->bio_seg,
 						 data_len, do_datacrc);
 			if (ret <= 0)
 				return ret;
-- 
1.7.9.5

