From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/6] libceph: define and use ceph_tcp_recvpage()
Date: Sat, 09 Mar 2013 10:43:45 -0600
Message-ID: <513B66C1.8080609@inktank.com>
References: <513B661F.4050203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:46909 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846Ab3CIQnr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:43:47 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so3226983iea.24
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:43:47 -0800 (PST)
In-Reply-To: <513B661F.4050203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define a new function ceph_tcp_recvpage() that behaves in a way
comparable to ceph_tcp_sendpage().

Rearrange the code in both read_partial_message_pages() and
read_partial_message_bio() so they have matching structure,
(similar to what's in write_partial_msg_pages()), and use
this new function.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   86
+++++++++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 26 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 91f577a..7df7941 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -471,6 +471,22 @@ static int ceph_tcp_recvmsg(struct socket *sock,
void *buf, size_t len)
 	return r;
 }

+static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
+		     int page_offset, size_t length)
+{
+	void *kaddr;
+	int ret;
+
+	BUG_ON(page_offset + length > PAGE_SIZE);
+
+	kaddr = kmap(page);
+	BUG_ON(!kaddr);
+	ret = ceph_tcp_recvmsg(sock, kaddr + page_offset, length);
+	kunmap(page);
+
+	return ret;
+}
+
 /*
  * write something.  @more is true if caller will be sending more data
  * shortly.
@@ -1809,26 +1825,36 @@ static int read_partial_message_pages(struct
ceph_connection *con,
 {
 	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
 	struct page *page;
-	void *p;
+	size_t page_offset;
+	size_t length;
+	unsigned int left;
 	int ret;
-	int left;

-	left = min((int)(data_len - msg_pos->data_pos),
-		   (int)(PAGE_SIZE - msg_pos->page_pos));
 	/* (page) data */
 	BUG_ON(pages == NULL);
 	page = pages[msg_pos->page];
-	p = kmap(page);
-	ret = ceph_tcp_recvmsg(con->sock, p + msg_pos->page_pos, left);
-	if (ret > 0 && do_datacrc)
-		con->in_data_crc =
-			crc32c(con->in_data_crc,
-				  p + msg_pos->page_pos, ret);
-	kunmap(page);
+	page_offset = msg_pos->page_pos;
+	BUG_ON(msg_pos->data_pos >= data_len);
+	left = data_len - msg_pos->data_pos;
+	BUG_ON(page_offset >= PAGE_SIZE);
+	length = min_t(unsigned int, PAGE_SIZE - page_offset, left);
+
+	ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
 	if (ret <= 0)
 		return ret;

-	in_msg_pos_next(con, left, ret);
+	if (do_datacrc) {
+		void *kaddr;
+		void *base;
+
+		kaddr = kmap(page);
+		BUG_ON(!kaddr);
+		base = kaddr + page_offset;
+		con->in_data_crc = crc32c(con->in_data_crc, base, ret);
+		kunmap(page);
+	}
+
+	in_msg_pos_next(con, length, ret);

 	return ret;
 }
@@ -1841,29 +1867,37 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
 	struct bio_vec *bv;
 	struct page *page;
-	void *p;
-	int ret, left;
+	size_t page_offset;
+	size_t length;
+	unsigned int left;
+	int ret;

 	BUG_ON(!msg);
 	BUG_ON(!msg->bio_iter);
 	bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
-
-	left = min((int)(data_len - msg_pos->data_pos),
-		   (int)(bv->bv_len - msg_pos->page_pos));
-
 	page = bv->bv_page;
-	p = kmap(page) + bv->bv_offset;
+	page_offset = bv->bv_offset + msg_pos->page_pos;
+	BUG_ON(msg_pos->data_pos >= data_len);
+	left = data_len - msg_pos->data_pos;
+	BUG_ON(msg_pos->page_pos >= bv->bv_len);
+	length = min_t(unsigned int, bv->bv_len - msg_pos->page_pos, left);

-	ret = ceph_tcp_recvmsg(con->sock, p + msg_pos->page_pos, left);
-	if (ret > 0 && do_datacrc)
-		con->in_data_crc =
-			crc32c(con->in_data_crc,
-				  p + msg_pos->page_pos, ret);
-	kunmap(page);
+	ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
 	if (ret <= 0)
 		return ret;

-	in_msg_pos_next(con, left, ret);
+	if (do_datacrc) {
+		void *kaddr;
+		void *base;
+
+		kaddr = kmap(page);
+		BUG_ON(!kaddr);
+		base = kaddr + page_offset;
+		con->in_data_crc = crc32c(con->in_data_crc, base, ret);
+		kunmap(page);
+	}
+
+	in_msg_pos_next(con, length, ret);

 	return ret;
 }
-- 
1.7.9.5

