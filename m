From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 4/6] net: ceph: messenger: properly align function parameters
Date: Wed, 27 Jan 2016 02:43:37 +0200
Message-ID: <11b640d9b46dacafa0e724e3ea852099538e95bd.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36481 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbcAZWny (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 17:43:54 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so2843wmf.3
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jan 2016 14:43:53 -0800 (PST)
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>

This patch properly aligns function parameters and function call
arguments to match the open bracket '(' in order to follow the linux
kernel coding style.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
 net/ceph/messenger.c | 97 ++++++++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6a0962d..6b15876 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -136,7 +136,7 @@ static bool con_flag_test(struct ceph_connection *con, unsigned long con_flag)
 }
 
 static bool con_flag_test_and_clear(struct ceph_connection *con,
-					unsigned long con_flag)
+				    unsigned long con_flag)
 {
 	BUG_ON(!con_flag_valid(con_flag));
 
@@ -144,7 +144,7 @@ static bool con_flag_test_and_clear(struct ceph_connection *con,
 }
 
 static bool con_flag_test_and_set(struct ceph_connection *con,
-					unsigned long con_flag)
+				  unsigned long con_flag)
 {
 	BUG_ON(!con_flag_valid(con_flag));
 
@@ -236,8 +236,10 @@ static int ceph_msgr_slab_init(void)
 {
 	BUG_ON(ceph_msg_cache);
 	ceph_msg_cache = kmem_cache_create("ceph_msg",
-					sizeof(struct ceph_msg),
-					__alignof__(struct ceph_msg), 0, NULL);
+					   sizeof(struct ceph_msg),
+					   __alignof__(struct ceph_msg),
+					   0,
+					   NULL);
 
 	if (!ceph_msg_cache)
 		return -ENOMEM;
@@ -360,8 +362,8 @@ static void con_sock_state_closing(struct ceph_connection *con)
 
 	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CLOSING);
 	if (WARN_ON(old_state != CON_SOCK_STATE_CONNECTING &&
-			old_state != CON_SOCK_STATE_CONNECTED &&
-			old_state != CON_SOCK_STATE_CLOSING))
+		    old_state != CON_SOCK_STATE_CONNECTED &&
+		    old_state != CON_SOCK_STATE_CLOSING))
 		printk("%s: unexpected old state %d\n", __func__, old_state);
 	dout("%s con %p sock %d -> %d\n", __func__, con, old_state,
 	     CON_SOCK_STATE_CLOSING);
@@ -534,7 +536,7 @@ static int ceph_tcp_recvmsg(struct socket *sock, void *buf, size_t len)
 }
 
 static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
-		     int page_offset, size_t length)
+			     int page_offset, size_t length)
 {
 	void *kaddr;
 	int ret;
@@ -554,7 +556,7 @@ static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
  * shortly.
  */
 static int ceph_tcp_sendmsg(struct socket *sock, struct kvec *iov,
-		     size_t kvlen, size_t len, int more)
+			    size_t kvlen, size_t len, int more)
 {
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL };
 	int r;
@@ -571,7 +573,7 @@ static int ceph_tcp_sendmsg(struct socket *sock, struct kvec *iov,
 }
 
 static int __ceph_tcp_sendpage(struct socket *sock, struct page *page,
-		     int offset, size_t size, bool more)
+			       int offset, size_t size, bool more)
 {
 	int flags = MSG_DONTWAIT | MSG_NOSIGNAL | (more ? MSG_MORE : MSG_EOR);
 	int ret;
@@ -584,7 +586,7 @@ static int __ceph_tcp_sendpage(struct socket *sock, struct page *page,
 }
 
 static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
-		     int offset, size_t size, bool more)
+			     int offset, size_t size, bool more)
 {
 	int ret;
 	struct kvec iov;
@@ -733,8 +735,8 @@ bool ceph_con_opened(struct ceph_connection *con)
  * initialize a new connection.
  */
 void ceph_con_init(struct ceph_connection *con, void *private,
-	const struct ceph_connection_operations *ops,
-	struct ceph_messenger *msgr)
+		   const struct ceph_connection_operations *ops,
+		   struct ceph_messenger *msgr)
 {
 	dout("con_init %p\n", con);
 	memset(con, 0, sizeof(*con));
@@ -779,7 +781,7 @@ static void con_out_kvec_reset(struct ceph_connection *con)
 }
 
 static void con_out_kvec_add(struct ceph_connection *con,
-				size_t size, void *data)
+			     size_t size, void *data)
 {
 	int index = con->out_kvec_left;
 
@@ -821,7 +823,7 @@ static int con_out_kvec_skip(struct ceph_connection *con)
  * bio in the list.
  */
 static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data_cursor *cursor,
-					size_t length)
+					  size_t length)
 {
 	struct ceph_msg_data *data = cursor->data;
 	struct bio *bio;
@@ -839,8 +841,8 @@ static void ceph_msg_data_bio_cursor_init(struct ceph_msg_data_cursor *cursor,
 }
 
 static struct page *ceph_msg_data_bio_next(struct ceph_msg_data_cursor *cursor,
-						size_t *page_offset,
-						size_t *length)
+					   size_t *page_offset,
+					   size_t *length)
 {
 	struct ceph_msg_data *data = cursor->data;
 	struct bio *bio;
@@ -866,7 +868,7 @@ static struct page *ceph_msg_data_bio_next(struct ceph_msg_data_cursor *cursor,
 }
 
 static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
-					size_t bytes)
+				      size_t bytes)
 {
 	struct bio *bio;
 	struct bio_vec bio_vec;
@@ -917,7 +919,7 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
  * that has not already been fully consumed.
  */
 static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data_cursor *cursor,
-					size_t length)
+					    size_t length)
 {
 	struct ceph_msg_data *data = cursor->data;
 	int page_count;
@@ -939,7 +941,7 @@ static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data_cursor *cursor,
 
 static struct page *
 ceph_msg_data_pages_next(struct ceph_msg_data_cursor *cursor,
-					size_t *page_offset, size_t *length)
+			 size_t *page_offset, size_t *length)
 {
 	struct ceph_msg_data *data = cursor->data;
 
@@ -958,7 +960,7 @@ ceph_msg_data_pages_next(struct ceph_msg_data_cursor *cursor,
 }
 
 static bool ceph_msg_data_pages_advance(struct ceph_msg_data_cursor *cursor,
-						size_t bytes)
+					size_t bytes)
 {
 	BUG_ON(cursor->data->type != CEPH_MSG_DATA_PAGES);
 
@@ -989,7 +991,7 @@ static bool ceph_msg_data_pages_advance(struct ceph_msg_data_cursor *cursor,
  */
 static void
 ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data_cursor *cursor,
-					size_t length)
+				   size_t length)
 {
 	struct ceph_msg_data *data = cursor->data;
 	struct ceph_pagelist *pagelist;
@@ -1014,7 +1016,7 @@ ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data_cursor *cursor,
 
 static struct page *
 ceph_msg_data_pagelist_next(struct ceph_msg_data_cursor *cursor,
-				size_t *page_offset, size_t *length)
+			    size_t *page_offset, size_t *length)
 {
 	struct ceph_msg_data *data = cursor->data;
 	struct ceph_pagelist *pagelist;
@@ -1038,7 +1040,7 @@ ceph_msg_data_pagelist_next(struct ceph_msg_data_cursor *cursor,
 }
 
 static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
-						size_t bytes)
+					   size_t bytes)
 {
 	struct ceph_msg_data *data = cursor->data;
 	struct ceph_pagelist *pagelist;
@@ -1126,8 +1128,8 @@ static void ceph_msg_data_cursor_init(struct ceph_msg *msg, size_t length)
  * Indicate whether this is the last piece in this data item.
  */
 static struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
-					size_t *page_offset, size_t *length,
-					bool *last_piece)
+				       size_t *page_offset, size_t *length,
+				       bool *last_piece)
 {
 	struct page *page;
 
@@ -1162,7 +1164,7 @@ static struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
  * of the data item.
  */
 static bool ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
-				size_t bytes)
+				  size_t bytes)
 {
 	bool new_piece;
 
@@ -1291,7 +1293,7 @@ static void prepare_write_message(struct ceph_connection *con)
 
 	if (m->middle)
 		con_out_kvec_add(con, m->middle->vec.iov_len,
-			m->middle->vec.iov_base);
+				 m->middle->vec.iov_base);
 
 	/* fill in hdr crc and finalize hdr */
 	crc = crc32c(0, &m->hdr, offsetof(struct ceph_msg_header, crc));
@@ -1302,8 +1304,9 @@ static void prepare_write_message(struct ceph_connection *con)
 	crc = crc32c(0, m->front.iov_base, m->front.iov_len);
 	con->out_msg->footer.front_crc = cpu_to_le32(crc);
 	if (m->middle) {
-		crc = crc32c(0, m->middle->vec.iov_base,
-				m->middle->vec.iov_len);
+		crc = crc32c(0,
+			     m->middle->vec.iov_base,
+			     m->middle->vec.iov_len);
 		con->out_msg->footer.middle_crc = cpu_to_le32(crc);
 	} else
 		con->out_msg->footer.middle_crc = 0;
@@ -1387,8 +1390,9 @@ static void prepare_write_keepalive(struct ceph_connection *con)
 /*
  * Connection negotiation.
  */
-static struct ceph_auth_handshake *get_connect_authorizer(struct ceph_connection *con,
-						int *auth_proto)
+static struct
+ceph_auth_handshake *get_connect_authorizer(struct ceph_connection *con,
+					    int *auth_proto)
 {
 	struct ceph_auth_handshake *auth;
 
@@ -1471,7 +1475,7 @@ static int prepare_write_connect(struct ceph_connection *con)
 			 &con->out_connect);
 	if (auth && auth->authorizer_buf_len)
 		con_out_kvec_add(con, auth->authorizer_buf_len,
-					auth->authorizer_buf);
+				 auth->authorizer_buf);
 
 	con->out_more = 0;
 	con_flag_set(con, CON_FLAG_WRITE_PENDING);
@@ -1522,8 +1526,8 @@ out:
 }
 
 static u32 ceph_crc32c_page(u32 crc, struct page *page,
-				unsigned int page_offset,
-				unsigned int length)
+			    unsigned int page_offset,
+			    unsigned int length)
 {
 	char *kaddr;
 
@@ -1806,7 +1810,7 @@ static void addr_set_port(struct sockaddr_storage *ss, int p)
  * Unlike other *_pton function semantics, zero indicates success.
  */
 static int ceph_pton(const char *str, size_t len, struct sockaddr_storage *ss,
-		char delim, const char **ipend)
+		     char delim, const char **ipend)
 {
 	struct sockaddr_in *in4 = (struct sockaddr_in *)ss;
 	struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)ss;
@@ -1831,7 +1835,8 @@ static int ceph_pton(const char *str, size_t len, struct sockaddr_storage *ss,
  */
 #ifdef CONFIG_CEPH_LIB_USE_DNS_RESOLVER
 static int ceph_dns_resolve_name(const char *name, size_t namelen,
-		struct sockaddr_storage *ss, char delim, const char **ipend)
+				 struct sockaddr_storage *ss,
+				 char delim, const char **ipend)
 {
 	const char *end, *delim_p;
 	char *colon_p, *ip_addr = NULL;
@@ -1869,13 +1874,14 @@ static int ceph_dns_resolve_name(const char *name, size_t namelen,
 	*ipend = end;
 
 	pr_info("resolve '%.*s' (ret=%d): %s\n", (int)(end - name), name,
-			ret, ret ? "failed" : ceph_pr_addr(ss));
+		ret, ret ? "failed" : ceph_pr_addr(ss));
 
 	return ret;
 }
 #else
 static inline int ceph_dns_resolve_name(const char *name, size_t namelen,
-		struct sockaddr_storage *ss, char delim, const char **ipend)
+					struct sockaddr_storage *ss,
+					char delim, const char **ipend)
 {
 	return -EINVAL;
 }
@@ -1886,7 +1892,8 @@ static inline int ceph_dns_resolve_name(const char *name, size_t namelen,
  * then try to extract a hostname to resolve using userspace DNS upcall.
  */
 static int ceph_parse_server_name(const char *name, size_t namelen,
-			struct sockaddr_storage *ss, char delim, const char **ipend)
+				  struct sockaddr_storage *ss,
+				  char delim, const char **ipend)
 {
 	int ret;
 
@@ -2810,7 +2817,7 @@ static bool con_backoff(struct ceph_connection *con)
 	ret = queue_con_delay(con, round_jiffies_relative(con->delay));
 	if (ret) {
 		dout("%s: con %p FAILED to back off %lu\n", __func__,
-			con, con->delay);
+		     con, con->delay);
 		BUG_ON(ret == -ENOENT);
 		con_flag_set(con, CON_FLAG_BACKOFF);
 	}
@@ -2919,8 +2926,8 @@ static void con_fault(struct ceph_connection *con)
 	con->error_msg = NULL;
 
 	WARN_ON(con->state != CON_STATE_CONNECTING &&
-	       con->state != CON_STATE_NEGOTIATING &&
-	       con->state != CON_STATE_OPEN);
+		con->state != CON_STATE_NEGOTIATING &&
+		con->state != CON_STATE_OPEN);
 
 	con_close_socket(con);
 
@@ -3150,7 +3157,7 @@ void ceph_con_keepalive(struct ceph_connection *con)
 EXPORT_SYMBOL(ceph_con_keepalive);
 
 bool ceph_con_keepalive_expired(struct ceph_connection *con,
-			       unsigned long interval)
+				unsigned long interval)
 {
 	if (interval > 0 &&
 	    (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2)) {
@@ -3191,7 +3198,7 @@ static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 }
 
 void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
-		size_t length, size_t alignment)
+			     size_t length, size_t alignment)
 {
 	struct ceph_msg_data *data;
 
@@ -3228,7 +3235,7 @@ EXPORT_SYMBOL(ceph_msg_data_add_pagelist);
 
 #ifdef	CONFIG_BLOCK
 void ceph_msg_data_add_bio(struct ceph_msg *msg, struct bio *bio,
-		size_t length)
+			   size_t length)
 {
 	struct ceph_msg_data *data;
 
-- 
2.6.4

