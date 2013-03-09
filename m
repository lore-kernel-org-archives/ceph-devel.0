From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/6] libceph: encapsulate reading message data
Date: Sat, 09 Mar 2013 10:43:31 -0600
Message-ID: <513B66B3.3090704@inktank.com>
References: <513B661F.4050203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44557 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846Ab3CIQnd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:43:33 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so3269254ieb.15
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:43:33 -0800 (PST)
In-Reply-To: <513B661F.4050203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Pull the code that reads the data portion into a message into
a separate function read_partial_msg_data().

Rename write_partial_msg_pages() to be write_partial_message_data()
to match its read counterpart, and to reflect its more generic
purpose.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   68
+++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 813c299..91f577a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1076,7 +1076,7 @@ static void in_msg_pos_next(struct ceph_connection
*con, size_t len,
  *  0 -> socket full, but more to do
  * <0 -> error
  */
-static int write_partial_msg_pages(struct ceph_connection *con)
+static int write_partial_message_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
 	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;
@@ -1088,7 +1088,7 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 	const size_t trail_len = (msg->trail ? msg->trail->length : 0);
 	const size_t trail_off = data_len - trail_len;

-	dout("write_partial_msg_pages %p msg %p page %d offset %d\n",
+	dout("%s %p msg %p page %d offset %d\n", __func__,
 	     con, msg, msg_pos->page, msg_pos->page_pos);

 	/*
@@ -1157,7 +1157,7 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 		out_msg_pos_next(con, page, length, (size_t) ret, in_trail);
 	}

-	dout("write_partial_msg_pages %p msg %p done\n", con, msg);
+	dout("%s %p msg %p done\n", __func__, con, msg);

 	/* prepare and queue up footer, too */
 	if (!do_datacrc)
@@ -1869,13 +1869,45 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 }
 #endif

+static int read_partial_msg_data(struct ceph_connection *con)
+{
+	struct ceph_msg *msg = con->in_msg;
+	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
+	const bool do_datacrc = !con->msgr->nocrc;
+	unsigned int data_len;
+	int ret = 0;
+
+	BUG_ON(!msg);
+
+	data_len = le32_to_cpu(con->in_hdr.data_len);
+	prepare_message_data(msg, msg_pos);
+	while (msg_pos->data_pos < data_len) {
+		if (msg->pages) {
+			ret = read_partial_message_pages(con, msg->pages,
+						 data_len, do_datacrc);
+			if (ret <= 0)
+				return ret;
+#ifdef CONFIG_BLOCK
+		} else if (msg->bio) {
+			ret = read_partial_message_bio(con,
+						 data_len, do_datacrc);
+			if (ret <= 0)
+				return ret;
+#endif
+		} else {
+			BUG_ON(1);
+		}
+	}
+
+	return ret;
+}
+
 /*
  * read (part of) a message.
  */
 static int read_partial_message(struct ceph_connection *con)
 {
 	struct ceph_msg *m = con->in_msg;
-	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
 	int size;
 	int end;
 	int ret;
@@ -1956,10 +1988,6 @@ static int read_partial_message(struct
ceph_connection *con)
 		if (m->middle)
 			m->middle->vec.iov_len = 0;

-		/* prepare for data payload, if any */
-
-		if (data_len)
-			prepare_message_data(con->in_msg, &con->in_msg_pos);
 	}

 	/* front */
@@ -1978,22 +2006,10 @@ static int read_partial_message(struct
ceph_connection *con)
 	}

 	/* (page) data */
-	while (msg_pos->data_pos < data_len) {
-		if (m->pages) {
-			ret = read_partial_message_pages(con, m->pages,
-						 data_len, do_datacrc);
-			if (ret <= 0)
-				return ret;
-#ifdef CONFIG_BLOCK
-		} else if (m->bio) {
-			ret = read_partial_message_bio(con,
-						 data_len, do_datacrc);
-			if (ret <= 0)
-				return ret;
-#endif
-		} else {
-			BUG_ON(1);
-		}
+	if (m->hdr.data_len) {
+		ret = read_partial_msg_data(con);
+		if (ret <= 0)
+			return ret;
 	}

 	/* footer */
@@ -2119,13 +2135,13 @@ more_kvec:
 			goto do_next;
 		}

-		ret = write_partial_msg_pages(con);
+		ret = write_partial_message_data(con);
 		if (ret == 1)
 			goto more_kvec;  /* we need to send the footer, too! */
 		if (ret == 0)
 			goto out;
 		if (ret < 0) {
-			dout("try_write write_partial_msg_pages err %d\n",
+			dout("try_write write_partial_message_data err %d\n",
 			     ret);
 			goto out;
 		}
-- 
1.7.9.5

