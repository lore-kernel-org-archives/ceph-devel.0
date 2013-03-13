From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] libceph: get rid of read helpers
Date: Tue, 12 Mar 2013 20:06:00 -0500
Message-ID: <513FD0F8.80402@inktank.com>
References: <513FD092.2030106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55046 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBGE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:06:04 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so486922obc.41
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:06:03 -0700 (PDT)
In-Reply-To: <513FD092.2030106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now that read_partial_message_pages() and read_partial_message_bio()
are literally identical functions we can factor them out.  They're
pretty simple as well, so just move their relevant content into
read_partial_msg_data().

This is and previous patches together resolve:
    http://tracker.ceph.com/issues/4428

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   80
++++++++++++--------------------------------------
 1 file changed, 18 insertions(+), 62 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5507a12..190b74b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2158,66 +2158,15 @@ static int read_partial_message_section(struct
ceph_connection *con,
 	return 1;
 }

-static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip);
-
-static int read_partial_message_pages(struct ceph_connection *con,
-				      unsigned int data_len, bool do_datacrc)
-{
-	struct ceph_msg *msg = con->in_msg;
-	struct page *page;
-	size_t page_offset;
-	size_t length;
-	int ret;
-
-	page = ceph_msg_data_next(&msg->p, &page_offset, &length, NULL);
-
-	ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
-	if (ret <= 0)
-		return ret;
-
-	if (do_datacrc)
-		con->in_data_crc = ceph_crc32c_page(con->in_data_crc, page,
-							page_offset, ret);
-
-	in_msg_pos_next(con, length, ret);
-
-	return ret;
-}
-
-#ifdef CONFIG_BLOCK
-static int read_partial_message_bio(struct ceph_connection *con,
-				    unsigned int data_len, bool do_datacrc)
-{
-	struct ceph_msg *msg = con->in_msg;
-	struct page *page;
-	size_t page_offset;
-	size_t length;
-	int ret;
-
-	BUG_ON(!msg);
-
-	page = ceph_msg_data_next(&msg->b, &page_offset, &length, NULL);
-
-	ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
-	if (ret <= 0)
-		return ret;
-
-	if (do_datacrc)
-		con->in_data_crc = ceph_crc32c_page(con->in_data_crc, page,
-							page_offset, ret);
-
-	in_msg_pos_next(con, length, ret);
-
-	return ret;
-}
-#endif
-
 static int read_partial_msg_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->in_msg;
 	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
 	const bool do_datacrc = !con->msgr->nocrc;
 	unsigned int data_len;
+	struct page *page;
+	size_t page_offset;
+	size_t length;
 	int ret;

 	BUG_ON(!msg);
@@ -2225,20 +2174,25 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 	data_len = le32_to_cpu(con->in_hdr.data_len);
 	while (msg_pos->data_pos < data_len) {
 		if (ceph_msg_has_pages(msg)) {
-			ret = read_partial_message_pages(con, data_len,
-							do_datacrc);
-			if (ret <= 0)
-				return ret;
+			page = ceph_msg_data_next(&msg->p, &page_offset,
+					&length, NULL);
 #ifdef CONFIG_BLOCK
 		} else if (ceph_msg_has_bio(msg)) {
-			ret = read_partial_message_bio(con,
-						 data_len, do_datacrc);
-			if (ret <= 0)
-				return ret;
+			page = ceph_msg_data_next(&msg->b, &page_offset,
+					&length, NULL);
 #endif
 		} else {
 			BUG_ON(1);
 		}
+		ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
+		if (ret <= 0)
+			return ret;
+
+		if (do_datacrc)
+			con->in_data_crc = ceph_crc32c_page(con->in_data_crc,
+							page, page_offset, ret);
+
+		in_msg_pos_next(con, length, ret);
 	}

 	return 1;	/* must return > 0 to indicate success */
@@ -2247,6 +2201,8 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 /*
  * read (part of) a message.
  */
+static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip);
+
 static int read_partial_message(struct ceph_connection *con)
 {
 	struct ceph_msg *m = con->in_msg;
-- 
1.7.9.5

