From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 1/6] net: ceph: messenger: remove unnecessary blank spaces
Date: Wed, 27 Jan 2016 02:43:34 +0200
Message-ID: <da5ff6ac5d737cb44b74b446f0b414b947360eb1.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33613 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbcAZWnv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 17:43:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id r129so21974wmr.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jan 2016 14:43:50 -0800 (PST)
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>

This patch removes unnecessary blank spaces for the following reasons:
    - sizeof() should be treated as a function so there should not be a
      space between the function name and the open bracket
    - there should not be a space after a cast
    - multiple blank lines are prohibited
    - there is no need for a blank line before a closed bracket '}'

Along these changes changing a call to min_t() was done.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
 net/ceph/messenger.c | 73 +++++++++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9cfedf5..424d76b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -195,8 +195,8 @@ const char *ceph_pr_addr(const struct sockaddr_storage *ss)
 {
 	int i;
 	char *s;
-	struct sockaddr_in *in4 = (struct sockaddr_in *) ss;
-	struct sockaddr_in6 *in6 = (struct sockaddr_in6 *) ss;
+	struct sockaddr_in *in4 = (struct sockaddr_in *)ss;
+	struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)ss;
 
 	i = atomic_inc_return(&addr_str_seq) & ADDR_STR_COUNT_MASK;
 	s = addr_str[i];
@@ -236,7 +236,7 @@ static int ceph_msgr_slab_init(void)
 {
 	BUG_ON(ceph_msg_cache);
 	ceph_msg_cache = kmem_cache_create("ceph_msg",
-					sizeof (struct ceph_msg),
+					sizeof(struct ceph_msg),
 					__alignof__(struct ceph_msg), 0, NULL);
 
 	if (!ceph_msg_cache)
@@ -244,7 +244,7 @@ static int ceph_msgr_slab_init(void)
 
 	BUG_ON(ceph_msg_data_cache);
 	ceph_msg_data_cache = kmem_cache_create("ceph_msg_data",
-					sizeof (struct ceph_msg_data),
+					sizeof(struct ceph_msg_data),
 					__alignof__(struct ceph_msg_data),
 					0, NULL);
 	if (ceph_msg_data_cache)
@@ -463,7 +463,6 @@ static void set_sock_callbacks(struct socket *sock,
 	sk->sk_state_change = ceph_sock_state_change;
 }
 
-
 /*
  * socket helpers
  */
@@ -709,7 +708,7 @@ void ceph_con_open(struct ceph_connection *con,
 	WARN_ON(con->state != CON_STATE_CLOSED);
 	con->state = CON_STATE_PREOPEN;
 
-	con->peer_name.type = (__u8) entity_type;
+	con->peer_name.type = (__u8)entity_type;
 	con->peer_name.num = cpu_to_le64(entity_num);
 
 	memcpy(&con->peer_addr, addr, sizeof(*addr));
@@ -751,7 +750,6 @@ void ceph_con_init(struct ceph_connection *con, void *private,
 }
 EXPORT_SYMBOL(ceph_con_init);
 
-
 /*
  * We maintain a global counter to order connection attempts.  Get
  * a unique seq greater than @gt.
@@ -852,12 +850,12 @@ static struct page *ceph_msg_data_bio_next(struct ceph_msg_data_cursor *cursor,
 
 	bio_vec = bio_iter_iovec(bio, cursor->bvec_iter);
 
-	*page_offset = (size_t) bio_vec.bv_offset;
+	*page_offset = (size_t)bio_vec.bv_offset;
 	BUG_ON(*page_offset >= PAGE_SIZE);
 	if (cursor->last_piece) /* pagelist offset is always 0 */
 		*length = cursor->resid;
 	else
-		*length = (size_t) bio_vec.bv_len;
+		*length = (size_t)bio_vec.bv_len;
 	BUG_ON(*length > cursor->resid);
 	BUG_ON(*page_offset + *length > PAGE_SIZE);
 
@@ -1252,10 +1250,10 @@ static void prepare_write_message(struct ceph_connection *con)
 	 * TCP packet that's a good thing. */
 	if (con->in_seq > con->in_seq_acked) {
 		con->in_seq_acked = con->in_seq;
-		con_out_kvec_add(con, sizeof (tag_ack), &tag_ack);
+		con_out_kvec_add(con, sizeof(tag_ack), &tag_ack);
 		con->out_temp_ack = cpu_to_le64(con->in_seq_acked);
-		con_out_kvec_add(con, sizeof (con->out_temp_ack),
-			&con->out_temp_ack);
+		con_out_kvec_add(con, sizeof(con->out_temp_ack),
+				 &con->out_temp_ack);
 	}
 
 	BUG_ON(list_empty(&con->out_queue));
@@ -1284,7 +1282,7 @@ static void prepare_write_message(struct ceph_connection *con)
 	BUG_ON(le32_to_cpu(m->hdr.front_len) != m->front.iov_len);
 
 	/* tag + hdr + front + middle */
-	con_out_kvec_add(con, sizeof (tag_msg), &tag_msg);
+	con_out_kvec_add(con, sizeof(tag_msg), &tag_msg);
 	con_out_kvec_add(con, sizeof(con->out_hdr), &con->out_hdr);
 	con_out_kvec_add(con, m->front.iov_len, m->front.iov_base);
 
@@ -1335,11 +1333,11 @@ static void prepare_write_ack(struct ceph_connection *con)
 
 	con_out_kvec_reset(con);
 
-	con_out_kvec_add(con, sizeof (tag_ack), &tag_ack);
+	con_out_kvec_add(con, sizeof(tag_ack), &tag_ack);
 
 	con->out_temp_ack = cpu_to_le64(con->in_seq_acked);
-	con_out_kvec_add(con, sizeof (con->out_temp_ack),
-				&con->out_temp_ack);
+	con_out_kvec_add(con, sizeof(con->out_temp_ack),
+			 &con->out_temp_ack);
 
 	con->out_more = 1;  /* more will follow.. eventually.. */
 	con_flag_set(con, CON_FLAG_WRITE_PENDING);
@@ -1357,7 +1355,7 @@ static void prepare_write_seq(struct ceph_connection *con)
 	con_out_kvec_reset(con);
 
 	con->out_temp_ack = cpu_to_le64(con->in_seq_acked);
-	con_out_kvec_add(con, sizeof (con->out_temp_ack),
+	con_out_kvec_add(con, sizeof(con->out_temp_ack),
 			 &con->out_temp_ack);
 
 	con_flag_set(con, CON_FLAG_WRITE_PENDING);
@@ -1419,8 +1417,8 @@ static struct ceph_auth_handshake *get_connect_authorizer(struct ceph_connection
 static void prepare_write_banner(struct ceph_connection *con)
 {
 	con_out_kvec_add(con, strlen(CEPH_BANNER), CEPH_BANNER);
-	con_out_kvec_add(con, sizeof (con->msgr->my_enc_addr),
-					&con->msgr->my_enc_addr);
+	con_out_kvec_add(con, sizeof(con->msgr->my_enc_addr),
+			 &con->msgr->my_enc_addr);
 
 	con->out_more = 0;
 	con_flag_set(con, CON_FLAG_WRITE_PENDING);
@@ -1467,8 +1465,8 @@ static int prepare_write_connect(struct ceph_connection *con)
 	con->out_connect.authorizer_len = auth ?
 		cpu_to_le32(auth->authorizer_buf_len) : 0;
 
-	con_out_kvec_add(con, sizeof (con->out_connect),
-					&con->out_connect);
+	con_out_kvec_add(con, sizeof(con->out_connect),
+			 &con->out_connect);
 	if (auth && auth->authorizer_buf_len)
 		con_out_kvec_add(con, auth->authorizer_buf_len,
 					auth->authorizer_buf);
@@ -1607,7 +1605,7 @@ static int write_partial_skip(struct ceph_connection *con)
 
 	dout("%s %p %d left\n", __func__, con, con->out_skip);
 	while (con->out_skip > 0) {
-		size_t size = min(con->out_skip, (int) PAGE_CACHE_SIZE);
+		size_t size = min_t(int, con->out_skip, (int)PAGE_CACHE_SIZE);
 
 		ret = ceph_tcp_sendpage(con->sock, zero_page, 0, size, true);
 		if (ret <= 0)
@@ -1672,7 +1670,6 @@ static int prepare_read_message(struct ceph_connection *con)
 	return 0;
 }
 
-
 static int read_partial(struct ceph_connection *con,
 			int end, int size, void *object)
 {
@@ -1687,7 +1684,6 @@ static int read_partial(struct ceph_connection *con,
 	return 1;
 }
 
-
 /*
  * Read all or part of the connect-side handshake on a new connection
  */
@@ -1706,13 +1702,13 @@ static int read_partial_banner(struct ceph_connection *con)
 	if (ret <= 0)
 		goto out;
 
-	size = sizeof (con->actual_peer_addr);
+	size = sizeof(con->actual_peer_addr);
 	end += size;
 	ret = read_partial(con, end, size, &con->actual_peer_addr);
 	if (ret <= 0)
 		goto out;
 
-	size = sizeof (con->peer_addr_for_me);
+	size = sizeof(con->peer_addr_for_me);
 	end += size;
 	ret = read_partial(con, end, size, &con->peer_addr_for_me);
 	if (ret <= 0)
@@ -1730,7 +1726,7 @@ static int read_partial_connect(struct ceph_connection *con)
 
 	dout("read_partial_connect %p at %d\n", con, con->in_base_pos);
 
-	size = sizeof (con->in_reply);
+	size = sizeof(con->in_reply);
 	end = size;
 	ret = read_partial(con, end, size, &con->in_reply);
 	if (ret <= 0)
@@ -1748,7 +1744,6 @@ static int read_partial_connect(struct ceph_connection *con)
 	     le32_to_cpu(con->in_reply.global_seq));
 out:
 	return ret;
-
 }
 
 /*
@@ -1809,8 +1804,8 @@ static void addr_set_port(struct sockaddr_storage *ss, int p)
 static int ceph_pton(const char *str, size_t len, struct sockaddr_storage *ss,
 		char delim, const char **ipend)
 {
-	struct sockaddr_in *in4 = (struct sockaddr_in *) ss;
-	struct sockaddr_in6 *in6 = (struct sockaddr_in6 *) ss;
+	struct sockaddr_in *in4 = (struct sockaddr_in *)ss;
+	struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)ss;
 
 	memset(ss, 0, sizeof(*ss));
 
@@ -2188,13 +2183,12 @@ static int process_connect(struct ceph_connection *con)
 	return 0;
 }
 
-
 /*
  * read (part of) an ack
  */
 static int read_partial_ack(struct ceph_connection *con)
 {
-	int size = sizeof (con->in_temp_ack);
+	int size = sizeof(con->in_temp_ack);
 	int end = size;
 
 	return read_partial(con, end, size, &con->in_temp_ack);
@@ -2223,7 +2217,6 @@ static void process_ack(struct ceph_connection *con)
 	prepare_read_tag(con);
 }
 
-
 static int read_partial_message_section(struct ceph_connection *con,
 					struct kvec *section,
 					unsigned int sec_len, u32 *crc)
@@ -2276,7 +2269,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
 
 		if (do_datacrc)
 			crc = ceph_crc32c_page(crc, page, page_offset, ret);
-		(void) ceph_msg_data_advance(cursor, (size_t)ret);
+		(void)ceph_msg_data_advance(cursor, (size_t)ret);
 	}
 	if (do_datacrc)
 		con->in_data_crc = crc;
@@ -2304,7 +2297,7 @@ static int read_partial_message(struct ceph_connection *con)
 	dout("read_partial_message con %p msg %p\n", con, m);
 
 	/* header */
-	size = sizeof (con->in_hdr);
+	size = sizeof(con->in_hdr);
 	end = size;
 	ret = read_partial(con, end, size, &con->in_hdr);
 	if (ret <= 0)
@@ -2585,8 +2578,6 @@ out:
 	return ret;
 }
 
-
-
 /*
  * Read what we can from the socket.
  */
@@ -2651,7 +2642,7 @@ more:
 		 * FIXME: there must be a better way to do this!
 		 */
 		static char buf[SKIP_BUF_SIZE];
-		int skip = min((int) sizeof (buf), -con->in_base_pos);
+		int skip = min((int)sizeof(buf), -con->in_base_pos);
 
 		dout("skipping %d / %d bytes\n", skip, -con->in_base_pos);
 		ret = ceph_tcp_recvmsg(con->sock, buf, skip);
@@ -2740,7 +2731,6 @@ bad_tag:
 	goto out;
 }
 
-
 /*
  * Atomically queue work on a connection after the specified delay.
  * Bump @con reference to avoid races with connection teardown.
@@ -2765,7 +2755,7 @@ static int queue_con_delay(struct ceph_connection *con, unsigned long delay)
 
 static void queue_con(struct ceph_connection *con)
 {
-	(void) queue_con_delay(con, 0);
+	(void)queue_con_delay(con, 0);
 }
 
 static void cancel_con(struct ceph_connection *con)
@@ -2963,8 +2953,6 @@ static void con_fault(struct ceph_connection *con)
 	}
 }
 
-
-
 /*
  * initialize a new messenger instance
  */
@@ -3388,7 +3376,6 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
 	return ret;
 }
 
-
 /*
  * Free a generically kmalloc'd message.
  */
-- 
2.6.4

