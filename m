From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/6, v3] libceph: encapsulate reading message data
Date: Sun, 10 Mar 2013 11:33:50 -0500
Message-ID: <513CB5EE.2070903@inktank.com>
References: <513B661F.4050203@inktank.com> <513B66B3.3090704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:37424 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab3CJQdz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 12:33:55 -0400
Received: by mail-qe0-f41.google.com with SMTP id 6so1901724qeb.28
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 09:33:54 -0700 (PDT)
In-Reply-To: <513B66B3.3090704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Found another problem with this one.  In order to indicate
that the it is successful, read_partial_msg_data() needs to
return a positive value (even if no bytes were read because
the entire data portion of a message has been read).  So
this latest version has it return 1 in that case rather than
zero.  The last update--initializing the message position
information--is still in place here.  I think this will be
the last one (though I probably just jinxed that.)


Pull the code that reads the data portion into a message into
a separate function read_partial_msg_data().

Rename write_partial_msg_pages() to be write_partial_message_data()
to match its read counterpart, and to reflect its more generic
purpose.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v3: read_partial_msg_data() returns positive for success
v2: do not move the call to prepare_message_data()

 net/ceph/messenger.c |   63
++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 813c299..6e0bd36 100644
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
@@ -1869,13 +1869,44 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 }
 #endif

+static int read_partial_msg_data(struct ceph_connection *con)
+{
+	struct ceph_msg *msg = con->in_msg;
+	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
+	const bool do_datacrc = !con->msgr->nocrc;
+	unsigned int data_len;
+	int ret;
+
+	BUG_ON(!msg);
+
+	data_len = le32_to_cpu(con->in_hdr.data_len);
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
+	return 1;	/* must return > 0 to indicate success */
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
@@ -1978,22 +2009,10 @@ static int read_partial_message(struct
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
+	if (data_len) {
+		ret = read_partial_msg_data(con);
+		if (ret <= 0)
+			return ret;
 	}

 	/* footer */
@@ -2119,13 +2138,13 @@ more_kvec:
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

