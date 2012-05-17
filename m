From: Alex Elder <elder@inktank.com>
Subject: [PATCH 03/16] ceph: messenger: send banner in process_connect()
Date: Thu, 17 May 2012 09:04:09 -0500
Message-ID: <4FB50559.9030903@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50220 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761154Ab2EQOEI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:04:08 -0400
Received: by yhmm54 with SMTP id m54so1852487yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:04:06 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

prepare_write_connect() has an argument indicating whether a banner
should be sent out before sending out a connection message.  It's
only ever set in one of its callers, so move the code that arranges
to send the banner into that caller and drop the "include_banner"
argument from prepare_write_connect().

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |   16 +++++++---------
  1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index cca3cf3..6b38b6f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -695,8 +695,7 @@ static void prepare_write_banner(struct 
ceph_messenger *msgr,
  }

  static int prepare_write_connect(struct ceph_messenger *msgr,
-				 struct ceph_connection *con,
-				 int include_banner)
+				 struct ceph_connection *con)
  {
  	unsigned global_seq = get_global_seq(con->msgr, 0);
  	int proto;
@@ -725,8 +724,6 @@ static int prepare_write_connect(struct 
ceph_messenger *msgr,
  	con->out_connect.protocol_version = cpu_to_le32(proto);
  	con->out_connect.flags = 0;

-	if (include_banner)
-		prepare_write_banner(msgr, con);
  	ceph_con_out_kvec_add(con, sizeof (con->out_connect), &con->out_connect);

  	con->out_more = 0;
@@ -1389,7 +1386,7 @@ static int process_connect(struct ceph_connection 
*con)
  		}
  		con->auth_retry = 1;
  		ceph_con_out_kvec_reset(con);
-		ret = prepare_write_connect(con->msgr, con, 0);
+		ret = prepare_write_connect(con->msgr, con);
  		if (ret < 0)
  			return ret;
  		prepare_read_connect(con);
@@ -1410,7 +1407,7 @@ static int process_connect(struct ceph_connection 
*con)
  		       ceph_pr_addr(&con->peer_addr.in_addr));
  		reset_connection(con);
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(con->msgr, con, 0);
+		prepare_write_connect(con->msgr, con);
  		prepare_read_connect(con);

  		/* Tell ceph about it. */
@@ -1434,7 +1431,7 @@ static int process_connect(struct ceph_connection 
*con)
  		     le32_to_cpu(con->in_connect.connect_seq));
  		con->connect_seq = le32_to_cpu(con->in_connect.connect_seq);
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(con->msgr, con, 0);
+		prepare_write_connect(con->msgr, con);
  		prepare_read_connect(con);
  		break;

@@ -1449,7 +1446,7 @@ static int process_connect(struct ceph_connection 
*con)
  		get_global_seq(con->msgr,
  			       le32_to_cpu(con->in_connect.global_seq));
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(con->msgr, con, 0);
+		prepare_write_connect(con->msgr, con);
  		prepare_read_connect(con);
  		break;

@@ -1855,7 +1852,8 @@ more:
  	/* open the socket first? */
  	if (con->sock == NULL) {
  		ceph_con_out_kvec_reset(con);
-		prepare_write_connect(msgr, con, 1);
+		prepare_write_banner(msgr, con);
+		prepare_write_connect(msgr, con);
  		prepare_read_banner(con);
  		set_bit(CONNECTING, &con->state);
  		clear_bit(NEGOTIATING, &con->state);
-- 
1.7.5.4

