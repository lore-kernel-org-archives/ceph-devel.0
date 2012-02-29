From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/4] ceph: eliminate some needless casts
Date: Tue, 28 Feb 2012 19:12:14 -0800
Message-ID: <4F4D978E.2060901@dreamhost.com>
References: <4F4D96F4.3080707@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44144 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030698Ab2B2DMO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:12:14 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 9298324318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:14 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 89DBF24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:14 -0800 (PST)
In-Reply-To: <4F4D96F4.3080707@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This eliminates type casts in some places where they are not
required.

Signed-off-by: Alex Elder <elder@newdream.net>
---
  net/ceph/messenger.c |   21 ++++++++++-----------
  1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8edfd1a..e95756a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -70,13 +70,13 @@ const char *ceph_pr_addr(const struct 
sockaddr_storage *ss)

  	switch (ss->ss_family) {
  	case AF_INET:
-		snprintf(s, MAX_ADDR_STR_LEN, "%pI4:%u", &in4->sin_addr,
-			 (unsigned int)ntohs(in4->sin_port));
+		snprintf(s, MAX_ADDR_STR_LEN, "%pI4:%hu", &in4->sin_addr,
+			 ntohs(in4->sin_port));
  		break;

  	case AF_INET6:
-		snprintf(s, MAX_ADDR_STR_LEN, "[%pI6c]:%u", &in6->sin6_addr,
-			 (unsigned int)ntohs(in6->sin6_port));
+		snprintf(s, MAX_ADDR_STR_LEN, "[%pI6c]:%hu", &in6->sin6_addr,
+			 ntohs(in6->sin6_port));
  		break;

  	default:
@@ -155,8 +155,8 @@ EXPORT_SYMBOL(ceph_msgr_flush);
  /* data available on socket, or listen socket received a connect */
  static void ceph_data_ready(struct sock *sk, int count_unused)
  {
-	struct ceph_connection *con =
-		(struct ceph_connection *)sk->sk_user_data;
+	struct ceph_connection *con = sk->sk_user_data;
+
  	if (sk->sk_state != TCP_CLOSE_WAIT) {
  		dout("ceph_data_ready on %p state = %lu, queueing work\n",
  		     con, con->state);
@@ -185,8 +185,7 @@ static void ceph_write_space(struct sock *sk)
  /* socket's state has changed */
  static void ceph_state_change(struct sock *sk)
  {
-	struct ceph_connection *con =
-		(struct ceph_connection *)sk->sk_user_data;
+	struct ceph_connection *con = sk->sk_user_data;

  	dout("ceph_state_change %p state = %lu sk_state = %u\n",
  	     con, con->state, sk->sk_state);
@@ -221,7 +220,7 @@ static void set_sock_callbacks(struct socket *sock,
  			       struct ceph_connection *con)
  {
  	struct sock *sk = sock->sk;
-	sk->sk_user_data = (void *)con;
+	sk->sk_user_data = con;
  	sk->sk_data_ready = ceph_data_ready;
  	sk->sk_write_space = ceph_write_space;
  	sk->sk_state_change = ceph_state_change;
@@ -548,7 +547,7 @@ static void prepare_write_message(struct 
ceph_connection *con)

  	/* fill in crc (except data pages), footer */
  	con->out_msg->hdr.crc =
-		cpu_to_le32(crc32c(0, (void *)&m->hdr,
+		cpu_to_le32(crc32c(0, &m->hdr,
  				      sizeof(m->hdr) - sizeof(m->hdr.crc)));
  	con->out_msg->footer.flags = CEPH_MSG_FOOTER_COMPLETE;
  	con->out_msg->footer.front_crc =
@@ -1643,7 +1642,7 @@ static int read_partial_message(struct 
ceph_connection *con)
  			return ret;
  		con->in_base_pos += ret;
  		if (con->in_base_pos == sizeof(con->in_hdr)) {
-			u32 crc = crc32c(0, (void *)&con->in_hdr,
+			u32 crc = crc32c(0, &con->in_hdr,
  				 sizeof(con->in_hdr) - sizeof(con->in_hdr.crc));
  			if (crc != le32_to_cpu(con->in_hdr.crc)) {
  				pr_err("read_partial_message bad hdr "
-- 
1.7.5.4

