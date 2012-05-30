From: Alex Elder <elder@inktank.com>
Subject: [PATCH 05/13] libceph: rename kvec_reset and kvec_add functions
Date: Wed, 30 May 2012 14:34:45 -0500
Message-ID: <4FC67655.7030206@inktank.com>
References: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45094 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab2E3Tep (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:34:45 -0400
Received: by qcro28 with SMTP id o28so104576qcr.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:34:44 -0700 (PDT)
In-Reply-To: <4FC673FC.3060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The functions ceph_con_out_kvec_reset() and ceph_con_out_kvec_add()
are entirely private functions, so drop the "ceph_" prefix in their
name to make them slightly more wieldy.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |   48 
++++++++++++++++++++++++------------------------
  1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5ad1f0a..2e9054f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -484,14 +484,14 @@ static u32 get_global_seq(struct ceph_messenger 
*msgr, u32 gt)
  	return ret;
  }

-static void ceph_con_out_kvec_reset(struct ceph_connection *con)
+static void con_out_kvec_reset(struct ceph_connection *con)
  {
  	con->out_kvec_left = 0;
  	con->out_kvec_bytes = 0;
  	con->out_kvec_cur = &con->out_kvec[0];
  }

-static void ceph_con_out_kvec_add(struct ceph_connection *con,
+static void con_out_kvec_add(struct ceph_connection *con,
  				size_t size, void *data)
  {
  	int index;
@@ -532,7 +532,7 @@ static void prepare_write_message(struct 
ceph_connection *con)
  	struct ceph_msg *m;
  	u32 crc;

-	ceph_con_out_kvec_reset(con);
+	con_out_kvec_reset(con);
  	con->out_kvec_is_msg = true;
  	con->out_msg_done = false;

@@ -540,9 +540,9 @@ static void prepare_write_message(struct 
ceph_connection *con)
  	 * TCP packet that's a good thing. */
  	if (con->in_seq > con->in_seq_acked) {
  		con->in_seq_acked = con->in_seq;
-		ceph_con_out_kvec_add(con, sizeof (tag_ack), &tag_ack);
+		con_out_kvec_add(con, sizeof (tag_ack), &tag_ack);
  		con->out_temp_ack = cpu_to_le64(con->in_seq_acked);
-		ceph_con_out_kvec_add(con, sizeof (con->out_temp_ack),
+		con_out_kvec_add(con, sizeof (con->out_temp_ack),
  			&con->out_temp_ack);
  	}

@@ -570,12 +570,12 @@ static void prepare_write_message(struct 
ceph_connection *con)
  	BUG_ON(le32_to_cpu(m->hdr.front_len) != m->front.iov_len);

  	/* tag + hdr + front + middle */
-	ceph_con_out_kvec_add(con, sizeof (tag_msg), &tag_msg);
-	ceph_con_out_kvec_add(con, sizeof (m->hdr), &m->hdr);
-	ceph_con_out_kvec_add(con, m->front.iov_len, m->front.iov_base);
+	con_out_kvec_add(con, sizeof (tag_msg), &tag_msg);
+	con_out_kvec_add(con, sizeof (m->hdr), &m->hdr);
+	con_out_kvec_add(con, m->front.iov_len, m->front.iov_base);

  	if (m->middle)
-		ceph_con_out_kvec_add(con, m->middle->vec.iov_len,
+		con_out_kvec_add(con, m->middle->vec.iov_len,
  			m->middle->vec.iov_base);

  	/* fill in crc (except data pages), footer */
@@ -624,12 +624,12 @@ static void prepare_write_ack(struct 
ceph_connection *con)
  	     con->in_seq_acked, con->in_seq);
  	con->in_seq_acked = con->in_seq;

-	ceph_con_out_kvec_reset(con);
+	con_out_kvec_reset(con);

-	ceph_con_out_kvec_add(con, sizeof (tag_ack), &tag_ack);
+	con_out_kvec_add(con, sizeof (tag_ack), &tag_ack);

  	con->out_temp_ack = cpu_to_le64(con->in_seq_acked);
-	ceph_con_out_kvec_add(con, sizeof (con->out_temp_ack),
+	con_out_kvec_add(con, sizeof (con->out_temp_ack),
  				&con->out_temp_ack);

  	con->out_more = 1;  /* more will follow.. eventually.. */
@@ -642,8 +642,8 @@ static void prepare_write_ack(struct ceph_connection 
*con)
  static void prepare_write_keepalive(struct ceph_connection *con)
  {
  	dout("prepare_write_keepalive %p\n", con);
-	ceph_con_out_kvec_reset(con);
-	ceph_con_out_kvec_add(con, sizeof (tag_keepalive), &tag_keepalive);
+	con_out_kvec_reset(con);
+	con_out_kvec_add(con, sizeof (tag_keepalive), &tag_keepalive);
  	set_bit(WRITE_PENDING, &con->state);
  }

@@ -688,8 +688,8 @@ static struct ceph_auth_handshake 
*get_connect_authorizer(struct ceph_connection
   */
  static void prepare_write_banner(struct ceph_connection *con)
  {
-	ceph_con_out_kvec_add(con, strlen(CEPH_BANNER), CEPH_BANNER);
-	ceph_con_out_kvec_add(con, sizeof (con->msgr->my_enc_addr),
+	con_out_kvec_add(con, strlen(CEPH_BANNER), CEPH_BANNER);
+	con_out_kvec_add(con, sizeof (con->msgr->my_enc_addr),
  					&con->msgr->my_enc_addr);

  	con->out_more = 0;
@@ -736,10 +736,10 @@ static int prepare_write_connect(struct 
ceph_connection *con)
  	con->out_connect.authorizer_len = auth ?
  		cpu_to_le32(auth->authorizer_buf_len) : 0;

-	ceph_con_out_kvec_add(con, sizeof (con->out_connect),
+	con_out_kvec_add(con, sizeof (con->out_connect),
  					&con->out_connect);
  	if (auth && auth->authorizer_buf_len)
-		ceph_con_out_kvec_add(con, auth->authorizer_buf_len,
+		con_out_kvec_add(con, auth->authorizer_buf_len,
  					auth->authorizer_buf);

  	con->out_more = 0;
@@ -933,7 +933,7 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)
  	/* prepare and queue up footer, too */
  	if (!do_datacrc)
  		con->out_msg->footer.flags |= CEPH_MSG_FOOTER_NOCRC;
-	ceph_con_out_kvec_reset(con);
+	con_out_kvec_reset(con);
  	prepare_write_message_footer(con);
  	ret = 1;
  out:
@@ -1396,7 +1396,7 @@ static int process_connect(struct ceph_connection 
*con)
  			return -1;
  		}
  		con->auth_retry = 1;
-		ceph_con_out_kvec_reset(con);
+		con_out_kvec_reset(con);
  		ret = prepare_write_connect(con);
  		if (ret < 0)
  			return ret;
@@ -1417,7 +1417,7 @@ static int process_connect(struct ceph_connection 
*con)
  		       ENTITY_NAME(con->peer_name),
  		       ceph_pr_addr(&con->peer_addr.in_addr));
  		reset_connection(con);
-		ceph_con_out_kvec_reset(con);
+		con_out_kvec_reset(con);
  		ret = prepare_write_connect(con);
  		if (ret < 0)
  			return ret;
@@ -1443,7 +1443,7 @@ static int process_connect(struct ceph_connection 
*con)
  		     le32_to_cpu(con->out_connect.connect_seq),
  		     le32_to_cpu(con->in_connect.connect_seq));
  		con->connect_seq = le32_to_cpu(con->in_connect.connect_seq);
-		ceph_con_out_kvec_reset(con);
+		con_out_kvec_reset(con);
  		ret = prepare_write_connect(con);
  		if (ret < 0)
  			return ret;
@@ -1460,7 +1460,7 @@ static int process_connect(struct ceph_connection 
*con)
  		     le32_to_cpu(con->in_connect.global_seq));
  		get_global_seq(con->msgr,
  			       le32_to_cpu(con->in_connect.global_seq));
-		ceph_con_out_kvec_reset(con);
+		con_out_kvec_reset(con);
  		ret = prepare_write_connect(con);
  		if (ret < 0)
  			return ret;
@@ -1867,7 +1867,7 @@ more:

  	/* open the socket first? */
  	if (con->sock == NULL) {
-		ceph_con_out_kvec_reset(con);
+		con_out_kvec_reset(con);
  		prepare_write_banner(con);
  		ret = prepare_write_connect(con);
  		if (ret < 0)
-- 
1.7.5.4

