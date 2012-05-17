From: Alex Elder <elder@inktank.com>
Subject: [PATCH 04/16] ceph: drop msgr argument from prepare_write_connect()
Date: Thu, 17 May 2012 09:04:20 -0500
Message-ID: <4FB50564.8090207@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34817 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761802Ab2EQOER (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:04:17 -0400
Received: by gglu4 with SMTP id u4so1802686ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:04:16 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In all cases, the value passed as the msgr argument to
prepare_write_connect() is just con->msgr.  Just get the msgr
value from the ceph connection and drop the unneeded argument.

The only msgr passed to prepare_write_banner() is also therefore
just the one from con->msgr, so change that function to drop the
msgr argument as well.

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |   25 +++++++++++--------------
  1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6b38b6f..47499dc 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -683,19 +683,17 @@ static int prepare_connect_authorizer(struct 
ceph_connection *con)
  /*
   * We connected to a peer and are saying hello.
   */
-static void prepare_write_banner(struct ceph_messenger *msgr,
-				 struct ceph_connection *con)
+static void prepare_write_banner(struct ceph_connection *con)
  {
  	ceph_con_out_kvec_add(con, strlen(CEPH_BANNER), CEPH_BANNER);
-	ceph_con_out_kvec_add(con, sizeof (msgr->my_enc_addr),
-					&msgr->my_enc_addr);
+	ceph_con_out_kvec_add(con, sizeof (con->msgr->my_enc_addr),
+					&con->msgr->my_enc_addr);

  	con->out_more = 0;
  	set_bit(WRITE_PENDING, &con->state);
  }

-static int prepare_write_connect(struct ceph_messenger *msgr,
-				 struct ceph_connection *con)
+static int prepare_write_connect(struct ceph_connection *con)
  {
  	unsigned global_seq = get_global_seq(con->msgr, 0);
  	int proto;
@@ -717,7 +715,7 @@ static int prepare_write_connect(struct 
ceph_messenger *msgr,
  	dout("prepare_write_connect %p cseq=%d gseq=%d proto=%d\n", con,
  	     con->connect_seq, global_seq, proto);

-	con->out_connect.features = cpu_to_le64(msgr->supported_features);
+	con->out_connect.features = cpu_to_le64(con->msgr->supported_features);
  	con->out_connect.host_type = cpu_to_le32(CEPH_ENTITY_TYPE_CLIENT);
  	con->out_connect.connect_seq = cpu_to_le32(con->connect_seq);
  	con->out_connect.global_seq = cpu_to_le32(global_seq);
@@ -1386,7 +1384,7 @@ static int process_connect(struct ceph_connection 
*con)
  		}
  		con->auth_retry = 1;
  		ceph_con_out_kvec_reset(con);
-		ret = prepare_write_connect(con->msgr, con);
+		ret = prepare_write_connect(con);
  		if (ret < 0)
  			return ret;
  		prepare_read_connect(con);
@@ -1407,7 +1405,7 @@ static int process_connect(struct ceph_connection 
*con)
  		       ceph_pr_addr(&con->peer_addr.in_addr));
  		reset_connection(con);
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(con->msgr, con);
+		prepare_write_connect(con);
  		prepare_read_connect(con);

  		/* Tell ceph about it. */
@@ -1431,7 +1429,7 @@ static int process_connect(struct ceph_connection 
*con)
  		     le32_to_cpu(con->in_connect.connect_seq));
  		con->connect_seq = le32_to_cpu(con->in_connect.connect_seq);
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(con->msgr, con);
+		prepare_write_connect(con);
  		prepare_read_connect(con);
  		break;

@@ -1446,7 +1444,7 @@ static int process_connect(struct ceph_connection 
*con)
  		get_global_seq(con->msgr,
  			       le32_to_cpu(con->in_connect.global_seq));
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(con->msgr, con);
+		prepare_write_connect(con);
  		prepare_read_connect(con);
  		break;

@@ -1840,7 +1838,6 @@ static void process_message(struct ceph_connection 
*con)
   */
  static int try_write(struct ceph_connection *con)
  {
-	struct ceph_messenger *msgr = con->msgr;
  	int ret = 1;

  	dout("try_write start %p state %lu nref %d\n", con, con->state,
@@ -1852,8 +1849,8 @@ more:
  	/* open the socket first? */
  	if (con->sock == NULL) {
  		ceph_con_out_kvec_reset(con);
-		prepare_write_banner(msgr, con);
-		prepare_write_connect(msgr, con);
+		prepare_write_banner(con);
+		prepare_write_connect(con);
  		prepare_read_banner(con);
  		set_bit(CONNECTING, &con->state);
  		clear_bit(NEGOTIATING, &con->state);
-- 
1.7.5.4

