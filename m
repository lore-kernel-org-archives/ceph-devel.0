From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/6] libceph: consolidate message prep code
Date: Sat, 09 Mar 2013 10:42:51 -0600
Message-ID: <513B668B.2090305@inktank.com>
References: <513B661F.4050203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:51995 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441Ab3CIQmx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:42:53 -0500
Received: by mail-ie0-f176.google.com with SMTP id k13so3226942iea.35
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:42:53 -0800 (PST)
In-Reply-To: <513B661F.4050203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In prepare_write_message_data(), various fields are initialized in
preparation for writing message data out.  Meanwhile, in
read_partial_message(), there is essentially the same block of code,
operating on message variables associated with an incoming message.

Generalize prepare_write_message_data() so it works for both
incoming and outcoming messages, and use it in both spots.  The
did_page_crc is not used for input (so it's harmless to initialize
it).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 7788170..e8fa449 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -722,11 +722,9 @@ static void iter_bio_next(struct bio **bio_iter,
unsigned int *seg)
 }
 #endif

-static void prepare_write_message_data(struct ceph_connection *con)
+static void prepare_message_data(struct ceph_msg *msg,
+				struct ceph_msg_pos *msg_pos)
 {
-	struct ceph_msg *msg = con->out_msg;
-	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;
-
 	BUG_ON(!msg);
 	BUG_ON(!msg->hdr.data_len);

@@ -742,7 +740,6 @@ static void prepare_write_message_data(struct
ceph_connection *con)
 #endif
 	msg_pos->data_pos = 0;
 	msg_pos->did_page_crc = false;
-	con->out_more = 1;  /* data + footer will follow */
 }

 /*
@@ -840,11 +837,13 @@ static void prepare_write_message(struct
ceph_connection *con)

 	/* is there a data payload? */
 	con->out_msg->footer.data_crc = 0;
-	if (m->hdr.data_len)
-		prepare_write_message_data(con);
-	else
+	if (m->hdr.data_len) {
+		prepare_message_data(con->out_msg, &con->out_msg_pos);
+		con->out_more = 1;  /* data + footer will follow */
+	} else {
 		/* no, queue up footer too and be done */
 		prepare_write_message_footer(con);
+	}

 	con_flag_set(con, CON_FLAG_WRITE_PENDING);
 }
@@ -1956,17 +1955,10 @@ static int read_partial_message(struct
ceph_connection *con)
 		if (m->middle)
 			m->middle->vec.iov_len = 0;

-		msg_pos->page = 0;
-		if (m->pages)
-			msg_pos->page_pos = m->page_alignment;
-		else
-			msg_pos->page_pos = 0;
-		msg_pos->data_pos = 0;
+		/* prepare for data payload, if any */

-#ifdef CONFIG_BLOCK
-		if (m->bio)
-			init_bio_iter(m->bio, &m->bio_iter, &m->bio_seg);
-#endif
+		if (data_len)
+			prepare_message_data(con->in_msg, &con->in_msg_pos);
 	}

 	/* front */
-- 
1.7.9.5

