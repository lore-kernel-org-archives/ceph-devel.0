From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] libceph: encapsulate connection kvec operations
Date: Tue, 28 Feb 2012 20:43:52 -0800
Message-ID: <4F4DAD08.6000105@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47111 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964932Ab2B2Enw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:43:52 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id AF0FE24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:43:52 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A37EA24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:43:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Encapsulate the operation of adding a new chunk of data to the next
open slot in a ceph_connection's out_kvec array.  Also add a "reset"
operation to make subsequent add operations start at the beginning
of the array again.

Use these routines throughout, avoiding duplicate code and ensuring
all calls are handled consistently.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |  117 
++++++++++++++++++++++++--------------------------
  1 files changed, 56 insertions(+), 61 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2404a5a..03868cd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -465,14 +465,35 @@ static u32 get_global_seq(struct ceph_messenger 
*msgr, u32 gt)
  	return ret;
  }

+static void ceph_con_out_kvec_reset(struct ceph_connection *con)
+{
+	con->out_kvec_left = 0;
+	con->out_kvec_bytes = 0;
+	con->out_kvec_cur = &con->out_kvec[0];
+}
+
+static void ceph_con_out_kvec_add(struct ceph_connection *con,
+				size_t size, void *data)
+{
+	int index;
+
+	index = con->out_kvec_left;
+	BUG_ON(index >= ARRAY_SIZE(con->out_kvec));
+
+	con->out_kvec[index].iov_len = size;
+	con->out_kvec[index].iov_base = data;
+	con->out_kvec_left++;
+	con->out_kvec_bytes += size;
+}

  /*
   * Prepare footer for currently outgoing message, and finish things
   * off.  Assumes out_kvec* are already valid.. we just add on to the end.
   */
-static void prepare_write_message_footer(struct ceph_connection *con, 
int v)
+static void prepare_write_message_footer(struct ceph_connection *con)
  {
  	struct ceph_msg *m = con->out_msg;
+	int v = con->out_kvec_left;

  	dout("prepare_write_message_footer %p\n", con);
  	con->out_kvec_is_msg = true;
@@ -490,9 +511,8 @@ static void prepare_write_message_footer(struct 
ceph_connection *con, int v)
  static void prepare_write_message(struct ceph_connection *con)
  {
  	struct ceph_msg *m;
-	int v = 0;

-	con->out_kvec_bytes = 0;
+	ceph_con_out_kvec_reset(con);
  	con->out_kvec_is_msg = true;
  	con->out_msg_done = false;

@@ -500,16 +520,13 @@ static void prepare_write_message(struct 
ceph_connection *con)
  	 * TCP packet that's a good thing. */
  	if (con->in_seq > con->in_seq_acked) {
  		con->in_seq_acked = con->in_seq;
-		con->out_kvec[v].iov_base = &tag_ack;
-		con->out_kvec[v++].iov_len = 1;
+		ceph_con_out_kvec_add(con, sizeof tag_ack, &tag_ack);
  		con->out_temp_ack = cpu_to_le64(con->in_seq_acked);
-		con->out_kvec[v].iov_base = &con->out_temp_ack;
-		con->out_kvec[v++].iov_len = sizeof(con->out_temp_ack);
-		con->out_kvec_bytes = 1 + sizeof(con->out_temp_ack);
+		ceph_con_out_kvec_add(con, sizeof con->out_temp_ack,
+			&con->out_temp_ack);
  	}

-	m = list_first_entry(&con->out_queue,
-		       struct ceph_msg, list_head);
+	m = list_first_entry(&con->out_queue, struct ceph_msg, list_head);
  	con->out_msg = m;

  	/* put message on sent list */
@@ -533,17 +550,13 @@ static void prepare_write_message(struct 
ceph_connection *con)
  	BUG_ON(le32_to_cpu(m->hdr.front_len) != m->front.iov_len);

  	/* tag + hdr + front + middle */
-	con->out_kvec[v].iov_base = &tag_msg;
-	con->out_kvec[v++].iov_len = 1;
-	con->out_kvec[v].iov_base = &m->hdr;
-	con->out_kvec[v++].iov_len = sizeof(m->hdr);
-	con->out_kvec[v++] = m->front;
+	ceph_con_out_kvec_add(con, sizeof tag_msg, &tag_msg);
+	ceph_con_out_kvec_add(con, sizeof m->hdr, &m->hdr);
+	ceph_con_out_kvec_add(con, m->front.iov_len, m->front.iov_base);
+
  	if (m->middle)
-		con->out_kvec[v++] = m->middle->vec;
-	con->out_kvec_left = v;
-	con->out_kvec_bytes += 1 + sizeof(m->hdr) + m->front.iov_len +
-		(m->middle ? m->middle->vec.iov_len : 0);
-	con->out_kvec_cur = con->out_kvec;
+		ceph_con_out_kvec_add(con, m->middle->vec.iov_len,
+			m->middle->vec.iov_base);

  	/* fill in crc (except data pages), footer */
  	con->out_msg->hdr.crc =
@@ -576,7 +589,7 @@ static void prepare_write_message(struct 
ceph_connection *con)
  		con->out_more = 1;  /* data + footer will follow */
  	} else {
  		/* no, queue up footer too and be done */
-		prepare_write_message_footer(con, v);
+		prepare_write_message_footer(con);
  	}

  	set_bit(WRITE_PENDING, &con->state);
@@ -591,14 +604,14 @@ static void prepare_write_ack(struct 
ceph_connection *con)
  	     con->in_seq_acked, con->in_seq);
  	con->in_seq_acked = con->in_seq;

-	con->out_kvec[0].iov_base = &tag_ack;
-	con->out_kvec[0].iov_len = 1;
+	ceph_con_out_kvec_reset(con);
+
+	ceph_con_out_kvec_add(con, sizeof tag_ack, &tag_ack);
+
  	con->out_temp_ack = cpu_to_le64(con->in_seq_acked);
-	con->out_kvec[1].iov_base = &con->out_temp_ack;
-	con->out_kvec[1].iov_len = sizeof(con->out_temp_ack);
-	con->out_kvec_left = 2;
-	con->out_kvec_bytes = 1 + sizeof(con->out_temp_ack);
-	con->out_kvec_cur = con->out_kvec;
+	ceph_con_out_kvec_add(con, sizeof con->out_temp_ack,
+				&con->out_temp_ack);
+
  	con->out_more = 1;  /* more will follow.. eventually.. */
  	set_bit(WRITE_PENDING, &con->state);
  }
@@ -609,11 +622,8 @@ static void prepare_write_ack(struct 
ceph_connection *con)
  static void prepare_write_keepalive(struct ceph_connection *con)
  {
  	dout("prepare_write_keepalive %p\n", con);
-	con->out_kvec[0].iov_base = &tag_keepalive;
-	con->out_kvec[0].iov_len = 1;
-	con->out_kvec_left = 1;
-	con->out_kvec_bytes = 1;
-	con->out_kvec_cur = con->out_kvec;
+	ceph_con_out_kvec_reset(con);
+	ceph_con_out_kvec_add(con, sizeof tag_keepalive, &tag_keepalive);
  	set_bit(WRITE_PENDING, &con->state);
  }

@@ -642,12 +652,9 @@ static int prepare_connect_authorizer(struct 
ceph_connection *con)
  	con->out_connect.authorizer_protocol = cpu_to_le32(auth_protocol);
  	con->out_connect.authorizer_len = cpu_to_le32(auth_len);

-	if (auth_len) {
-		con->out_kvec[con->out_kvec_left].iov_base = auth_buf;
-		con->out_kvec[con->out_kvec_left].iov_len = auth_len;
-		con->out_kvec_left++;
-		con->out_kvec_bytes += auth_len;
-	}
+	if (auth_len)
+		ceph_con_out_kvec_add(con, auth_len, auth_buf);
+
  	return 0;
  }

@@ -657,15 +664,11 @@ static int prepare_connect_authorizer(struct 
ceph_connection *con)
  static void prepare_write_banner(struct ceph_messenger *msgr,
  				 struct ceph_connection *con)
  {
-	int len = strlen(CEPH_BANNER);
+	ceph_con_out_kvec_reset(con);
+	ceph_con_out_kvec_add(con, strlen(CEPH_BANNER), CEPH_BANNER);
+	ceph_con_out_kvec_add(con, sizeof msgr->my_enc_addr,
+					&msgr->my_enc_addr);

-	con->out_kvec[0].iov_base = CEPH_BANNER;
-	con->out_kvec[0].iov_len = len;
-	con->out_kvec[1].iov_base = &msgr->my_enc_addr;
-	con->out_kvec[1].iov_len = sizeof(msgr->my_enc_addr);
-	con->out_kvec_left = 2;
-	con->out_kvec_bytes = len + sizeof(msgr->my_enc_addr);
-	con->out_kvec_cur = con->out_kvec;
  	con->out_more = 0;
  	set_bit(WRITE_PENDING, &con->state);
  }
@@ -703,22 +706,16 @@ static int prepare_write_connect(struct 
ceph_messenger *msgr,

  	if (include_banner)
  		prepare_write_banner(msgr, con);
-	else {
-		con->out_kvec_left = 0;
-		con->out_kvec_bytes = 0;
-	}
-	con->out_kvec[con->out_kvec_left].iov_base = &con->out_connect;
-	con->out_kvec[con->out_kvec_left].iov_len = sizeof(con->out_connect);
-	con->out_kvec_left++;
-	con->out_kvec_bytes += sizeof(con->out_connect);
-	con->out_kvec_cur = con->out_kvec;
+	else
+		ceph_con_out_kvec_reset(con);
+	ceph_con_out_kvec_add(con, sizeof con->out_connect, &con->out_connect);
+
  	con->out_more = 0;
  	set_bit(WRITE_PENDING, &con->state);

  	return prepare_connect_authorizer(con);
  }

-
  /*
   * write as much of pending kvecs to the socket as we can.
   *  1 -> done
@@ -915,10 +912,8 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)
  	/* prepare and queue up footer, too */
  	if (!crc)
  		con->out_msg->footer.flags |= CEPH_MSG_FOOTER_NOCRC;
-	con->out_kvec_bytes = 0;
-	con->out_kvec_left = 0;
-	con->out_kvec_cur = con->out_kvec;
-	prepare_write_message_footer(con, 0);
+	ceph_con_out_kvec_reset(con);
+	prepare_write_message_footer(con);
  	ret = 1;
  out:
  	return ret;
-- 
1.7.5.4

