From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: provide data length when preparing message
Date: Fri, 05 Apr 2013 08:35:26 -0500
Message-ID: <515ED31E.4050307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59346 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161177Ab3DENf2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 09:35:28 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so4326123ieb.34
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 06:35:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In prepare_message_data(), the length used to initialize the cursor
is taken from the header of the message provided.  I'm working
toward not using the header data length field to determine length in
outbound messages, and this is a step in that direction.  For
inbound messages this will be set to be the actual number of bytes
that arriving (which may be less than the total size of the data
buffer available).

This resolves:
    http://tracker.ceph.com/issues/4589

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index fa9b4d0..78ab83d 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1076,18 +1076,14 @@ static bool ceph_msg_data_advance(struct
ceph_msg_data *data, size_t bytes)
 	return new_piece;
 }

-static void prepare_message_data(struct ceph_msg *msg)
+static void prepare_message_data(struct ceph_msg *msg, u32 data_len)
 {
-	size_t data_len;
-
 	BUG_ON(!msg);
-
-	data_len = le32_to_cpu(msg->hdr.data_len);
 	BUG_ON(!data_len);

 	/* Initialize data cursor */

-	ceph_msg_data_cursor_init(msg->data, data_len);
+	ceph_msg_data_cursor_init(msg->data, (size_t) data_len);
 }

 /*
@@ -1117,6 +1113,7 @@ static void prepare_write_message_footer(struct
ceph_connection *con)
 static void prepare_write_message(struct ceph_connection *con)
 {
 	struct ceph_msg *m;
+	u32 data_len;
 	u32 crc;

 	con_out_kvec_reset(con);
@@ -1150,11 +1147,12 @@ static void prepare_write_message(struct
ceph_connection *con)
 		m->hdr.seq = cpu_to_le64(++con->out_seq);
 		m->needs_out_seq = false;
 	}
+	data_len = le32_to_cpu(m->hdr.data_len);

 	dout("prepare_write_message %p seq %lld type %d len %d+%d+%d\n",
 	     m, con->out_seq, le16_to_cpu(m->hdr.type),
 	     le32_to_cpu(m->hdr.front_len), le32_to_cpu(m->hdr.middle_len),
-	     le32_to_cpu(m->hdr.data_len));
+	     data_len);
 	BUG_ON(le32_to_cpu(m->hdr.front_len) != m->front.iov_len);

 	/* tag + hdr + front + middle */
@@ -1185,8 +1183,8 @@ static void prepare_write_message(struct
ceph_connection *con)

 	/* is there a data payload? */
 	con->out_msg->footer.data_crc = 0;
-	if (m->hdr.data_len) {
-		prepare_message_data(con->out_msg);
+	if (data_len) {
+		prepare_message_data(con->out_msg, data_len);
 		con->out_more = 1;  /* data + footer will follow */
 	} else {
 		/* no, queue up footer too and be done */
@@ -2231,7 +2229,7 @@ static int read_partial_message(struct
ceph_connection *con)
 		/* prepare for data payload, if any */

 		if (data_len)
-			prepare_message_data(con->in_msg);
+			prepare_message_data(con->in_msg, data_len);
 	}

 	/* front */
-- 
1.7.9.5

