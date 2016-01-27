From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 3/6] net: ceph: messenger: add blank line after declarations
Date: Wed, 27 Jan 2016 02:43:36 +0200
Message-ID: <26cb4650cf99734eef76913bb2d9916721858342.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34056 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbcAZWnw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 17:43:52 -0500
Received: by mail-wm0-f68.google.com with SMTP id p63so15335wmp.1
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jan 2016 14:43:51 -0800 (PST)
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>

This patch adds a blank line after declarations in order to follow the
kernel coding style. Also, it adds spaces around a binary operator.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
 net/ceph/messenger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 7a8bc51..6a0962d 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -389,6 +389,7 @@ static void con_sock_state_closed(struct ceph_connection *con)
 static void ceph_sock_data_ready(struct sock *sk)
 {
 	struct ceph_connection *con = sk->sk_user_data;
+
 	if (atomic_read(&con->msgr->stopping)) {
 		return;
 	}
@@ -457,6 +458,7 @@ static void set_sock_callbacks(struct socket *sock,
 			       struct ceph_connection *con)
 {
 	struct sock *sk = sock->sk;
+
 	sk->sk_user_data = con;
 	sk->sk_data_ready = ceph_sock_data_ready;
 	sk->sk_write_space = ceph_sock_write_space;
@@ -636,6 +638,7 @@ static void ceph_msg_remove(struct ceph_msg *msg)
 
 	ceph_msg_put(msg);
 }
+
 static void ceph_msg_remove_list(struct list_head *head)
 {
 	while (!list_empty(head)) {
@@ -1384,7 +1387,6 @@ static void prepare_write_keepalive(struct ceph_connection *con)
 /*
  * Connection negotiation.
  */
-
 static struct ceph_auth_handshake *get_connect_authorizer(struct ceph_connection *con,
 						int *auth_proto)
 {
@@ -1543,6 +1545,7 @@ static int write_partial_message_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
 	struct ceph_msg_data_cursor *cursor = &msg->cursor;
+
 	bool do_datacrc = !ceph_test_opt(from_msgr(con->msgr), NOCRC);
 	u32 crc;
 
@@ -1677,6 +1680,7 @@ static int read_partial(struct ceph_connection *con,
 		int left = end - con->in_base_pos;
 		int have = size - left;
 		int ret = ceph_tcp_recvmsg(con->sock, object + have, left);
+
 		if (ret <= 0)
 			return ret;
 		con->in_base_pos += ret;
@@ -1904,7 +1908,7 @@ int ceph_parse_ips(const char *c, const char *end,
 	int i, ret = -EINVAL;
 	const char *p = c;
 
-	dout("parse_ips on '%.*s'\n", (int)(end-c), c);
+	dout("parse_ips on '%.*s'\n", (int)(end - c), c);
 	for (i = 0; i < max_count; i++) {
 		const char *ipend;
 		struct sockaddr_storage *ss = &addr[i].in_addr;
@@ -2479,6 +2483,7 @@ static int read_keepalive_ack(struct ceph_connection *con)
 	struct ceph_timespec ceph_ts;
 	size_t size = sizeof(ceph_ts);
 	int ret = read_partial(con, size, size, &ceph_ts);
+
 	if (ret <= 0)
 		return ret;
 	ceph_decode_timespec(&con->last_keepalive_ack, &ceph_ts);
@@ -3151,6 +3156,7 @@ bool ceph_con_keepalive_expired(struct ceph_connection *con,
 	    (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2)) {
 		struct timespec now = CURRENT_TIME;
 		struct timespec ts;
+
 		jiffies_to_timespec(interval, &ts);
 		ts = timespec_add(con->last_keepalive_ack, ts);
 		return timespec_compare(&now, &ts) >= 0;
-- 
2.6.4

