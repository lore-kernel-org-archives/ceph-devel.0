From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] libceph: use local variables for message positions
Date: Sat, 09 Mar 2013 10:42:37 -0600
Message-ID: <513B667D.3010906@inktank.com>
References: <513B661F.4050203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:52740 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441Ab3CIQmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:42:40 -0500
Received: by mail-ia0-f173.google.com with SMTP id h37so2407457iak.18
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:42:40 -0800 (PST)
In-Reply-To: <513B661F.4050203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are several places where a message's out_msg_pos or in_msg_pos
field is used repeatedly within a function.  Use a local pointer
variable for this purpose to unclutter the code.

This and the upcoming cleanup patches are related to:
    http://tracker.ceph.com/issues/4403

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   85
+++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 17d9321..7788170 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -725,22 +725,23 @@ static void iter_bio_next(struct bio **bio_iter,
unsigned int *seg)
 static void prepare_write_message_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
+	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;

 	BUG_ON(!msg);
 	BUG_ON(!msg->hdr.data_len);

 	/* initialize page iterator */
-	con->out_msg_pos.page = 0;
+	msg_pos->page = 0;
 	if (msg->pages)
-		con->out_msg_pos.page_pos = msg->page_alignment;
+		msg_pos->page_pos = msg->page_alignment;
 	else
-		con->out_msg_pos.page_pos = 0;
+		msg_pos->page_pos = 0;
 #ifdef CONFIG_BLOCK
 	if (msg->bio)
 		init_bio_iter(msg->bio, &msg->bio_iter, &msg->bio_seg);
 #endif
-	con->out_msg_pos.data_pos = 0;
-	con->out_msg_pos.did_page_crc = false;
+	msg_pos->data_pos = 0;
+	msg_pos->did_page_crc = false;
 	con->out_more = 1;  /* data + footer will follow */
 }

@@ -1022,19 +1023,20 @@ static void out_msg_pos_next(struct
ceph_connection *con, struct page *page,
 			size_t len, size_t sent, bool in_trail)
 {
 	struct ceph_msg *msg = con->out_msg;
+	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;

 	BUG_ON(!msg);
 	BUG_ON(!sent);

-	con->out_msg_pos.data_pos += sent;
-	con->out_msg_pos.page_pos += sent;
+	msg_pos->data_pos += sent;
+	msg_pos->page_pos += sent;
 	if (sent < len)
 		return;

 	BUG_ON(sent != len);
-	con->out_msg_pos.page_pos = 0;
-	con->out_msg_pos.page++;
-	con->out_msg_pos.did_page_crc = false;
+	msg_pos->page_pos = 0;
+	msg_pos->page++;
+	msg_pos->did_page_crc = false;
 	if (in_trail)
 		list_rotate_left(&msg->trail->head);
 	else if (msg->pagelist)
@@ -1049,18 +1051,19 @@ static void in_msg_pos_next(struct
ceph_connection *con, size_t len,
 				size_t received)
 {
 	struct ceph_msg *msg = con->in_msg;
+	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;

 	BUG_ON(!msg);
 	BUG_ON(!received);

-	con->in_msg_pos.data_pos += received;
-	con->in_msg_pos.page_pos += received;
+	msg_pos->data_pos += received;
+	msg_pos->page_pos += received;
 	if (received < len)
 		return;

 	BUG_ON(received != len);
-	con->in_msg_pos.page_pos = 0;
-	con->in_msg_pos.page++;
+	msg_pos->page_pos = 0;
+	msg_pos->page++;
 #ifdef CONFIG_BLOCK
 	if (msg->bio)
 		iter_bio_next(&msg->bio_iter, &msg->bio_seg);
@@ -1077,6 +1080,7 @@ static void in_msg_pos_next(struct ceph_connection
*con, size_t len,
 static int write_partial_msg_pages(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
+	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;
 	unsigned int data_len = le32_to_cpu(msg->hdr.data_len);
 	size_t len;
 	bool do_datacrc = !con->msgr->nocrc;
@@ -1087,7 +1091,7 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 	const size_t trail_off = data_len - trail_len;

 	dout("write_partial_msg_pages %p msg %p page %d offset %d\n",
-	     con, msg, con->out_msg_pos.page, con->out_msg_pos.page_pos);
+	     con, msg, msg_pos->page, msg_pos->page_pos);

 	/*
 	 * Iterate through each page that contains data to be
@@ -1097,22 +1101,22 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 	 * need to map the page.  If we have no pages, they have
 	 * been revoked, so use the zero page.
 	 */
-	while (data_len > con->out_msg_pos.data_pos) {
+	while (data_len > msg_pos->data_pos) {
 		struct page *page = NULL;
 		int max_write = PAGE_SIZE;
 		int bio_offset = 0;

-		in_trail = in_trail || con->out_msg_pos.data_pos >= trail_off;
+		in_trail = in_trail || msg_pos->data_pos >= trail_off;
 		if (!in_trail)
-			total_max_write = trail_off - con->out_msg_pos.data_pos;
+			total_max_write = trail_off - msg_pos->data_pos;

 		if (in_trail) {
-			total_max_write = data_len - con->out_msg_pos.data_pos;
+			total_max_write = data_len - msg_pos->data_pos;

 			page = list_first_entry(&msg->trail->head,
 						struct page, lru);
 		} else if (msg->pages) {
-			page = msg->pages[con->out_msg_pos.page];
+			page = msg->pages[msg_pos->page];
 		} else if (msg->pagelist) {
 			page = list_first_entry(&msg->pagelist->head,
 						struct page, lru);
@@ -1128,24 +1132,24 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 		} else {
 			page = zero_page;
 		}
-		len = min_t(int, max_write - con->out_msg_pos.page_pos,
+		len = min_t(int, max_write - msg_pos->page_pos,
 			    total_max_write);

-		if (do_datacrc && !con->out_msg_pos.did_page_crc) {
+		if (do_datacrc && !msg_pos->did_page_crc) {
 			void *base;
 			u32 crc = le32_to_cpu(msg->footer.data_crc);
 			char *kaddr;

 			kaddr = kmap(page);
 			BUG_ON(kaddr == NULL);
-			base = kaddr + con->out_msg_pos.page_pos + bio_offset;
+			base = kaddr + msg_pos->page_pos + bio_offset;
 			crc = crc32c(crc, base, len);
 			kunmap(page);
 			msg->footer.data_crc = cpu_to_le32(crc);
-			con->out_msg_pos.did_page_crc = true;
+			msg_pos->did_page_crc = true;
 		}
 		ret = ceph_tcp_sendpage(con->sock, page,
-				      con->out_msg_pos.page_pos + bio_offset,
+				      msg_pos->page_pos + bio_offset,
 				      len, true);
 		if (ret <= 0)
 			goto out;
@@ -1803,22 +1807,23 @@ static int read_partial_message_pages(struct
ceph_connection *con,
 				      struct page **pages,
 				      unsigned int data_len, bool do_datacrc)
 {
+	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
 	struct page *page;
 	void *p;
 	int ret;
 	int left;

-	left = min((int)(data_len - con->in_msg_pos.data_pos),
-		   (int)(PAGE_SIZE - con->in_msg_pos.page_pos));
+	left = min((int)(data_len - msg_pos->data_pos),
+		   (int)(PAGE_SIZE - msg_pos->page_pos));
 	/* (page) data */
 	BUG_ON(pages == NULL);
-	page = pages[con->in_msg_pos.page];
+	page = pages[msg_pos->page];
 	p = kmap(page);
-	ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos, left);
+	ret = ceph_tcp_recvmsg(con->sock, p + msg_pos->page_pos, left);
 	if (ret > 0 && do_datacrc)
 		con->in_data_crc =
 			crc32c(con->in_data_crc,
-				  p + con->in_msg_pos.page_pos, ret);
+				  p + msg_pos->page_pos, ret);
 	kunmap(page);
 	if (ret <= 0)
 		return ret;
@@ -1833,6 +1838,7 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 				    unsigned int data_len, bool do_datacrc)
 {
 	struct ceph_msg *msg = con->in_msg;
+	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
 	struct bio_vec *bv;
 	struct page *page;
 	void *p;
@@ -1842,17 +1848,17 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 	BUG_ON(!msg->bio_iter);
 	bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);

-	left = min((int)(data_len - con->in_msg_pos.data_pos),
-		   (int)(bv->bv_len - con->in_msg_pos.page_pos));
+	left = min((int)(data_len - msg_pos->data_pos),
+		   (int)(bv->bv_len - msg_pos->page_pos));

 	page = bv->bv_page;
 	p = kmap(page) + bv->bv_offset;

-	ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos, left);
+	ret = ceph_tcp_recvmsg(con->sock, p + msg_pos->page_pos, left);
 	if (ret > 0 && do_datacrc)
 		con->in_data_crc =
 			crc32c(con->in_data_crc,
-				  p + con->in_msg_pos.page_pos, ret);
+				  p + msg_pos->page_pos, ret);
 	kunmap(page);
 	if (ret <= 0)
 		return ret;
@@ -1869,6 +1875,7 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 static int read_partial_message(struct ceph_connection *con)
 {
 	struct ceph_msg *m = con->in_msg;
+	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
 	int size;
 	int end;
 	int ret;
@@ -1949,12 +1956,12 @@ static int read_partial_message(struct
ceph_connection *con)
 		if (m->middle)
 			m->middle->vec.iov_len = 0;

-		con->in_msg_pos.page = 0;
+		msg_pos->page = 0;
 		if (m->pages)
-			con->in_msg_pos.page_pos = m->page_alignment;
+			msg_pos->page_pos = m->page_alignment;
 		else
-			con->in_msg_pos.page_pos = 0;
-		con->in_msg_pos.data_pos = 0;
+			msg_pos->page_pos = 0;
+		msg_pos->data_pos = 0;

 #ifdef CONFIG_BLOCK
 		if (m->bio)
@@ -1978,7 +1985,7 @@ static int read_partial_message(struct
ceph_connection *con)
 	}

 	/* (page) data */
-	while (con->in_msg_pos.data_pos < data_len) {
+	while (msg_pos->data_pos < data_len) {
 		if (m->pages) {
 			ret = read_partial_message_pages(con, m->pages,
 						 data_len, do_datacrc);
-- 
1.7.9.5

