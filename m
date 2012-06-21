From: Alex Elder <elder@inktank.com>
Subject: [PATCH 08/12] libceph: separate banner and connect writes
Date: Thu, 21 Jun 2012 09:22:21 -0500
Message-ID: <4FE32E1D.1070508@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:55725 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540Ab2FUO3X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:29:23 -0400
Received: by yhnn12 with SMTP id n12so621120yhn.10
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:29:22 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are two phases in the process of linking together the two ends
of a ceph connection.  The first involves exchanging a banner and
IP addresses, and if that is successful a second phase exchanges
some detail about each side's connection capabilities.

When initiating a connection, the client side now queues to send
its information for both phases of this process at the same time.
This is probably a bit more efficient, but it is slightly messier
from a layering perspective in the code.

So rearrange things so that the client doesn't send the connection
information until it has received and processed the response in the
initial banner phase (in process_banner()).

Move the code (in the (con->sock == NULL) case in try_write()) that
prepares for writing the connection information, delaying doing that
until the banner exchange has completed.  Move the code that begins
the transition to this second "NEGOTIATING" phase out of
process_banner() and into its caller, so preparing to write the
connection information and preparing to read the response are
adjacent to each other.

Finally, preparing to write the connection information now requires
the output kvec to be reset in all cases, so move that into the
prepare_write_connect() and delete it from all callers.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -865,6 +865,7 @@ static int prepare_write_connect(struct
 	con->out_connect.authorizer_len = auth ?
 		cpu_to_le32(auth->authorizer_buf_len) : 0;

+	con_out_kvec_reset(con);
 	con_out_kvec_add(con, sizeof (con->out_connect),
 					&con->out_connect);
 	if (auth && auth->authorizer_buf_len)
@@ -1454,8 +1455,6 @@ static int process_banner(struct ceph_co
 		     ceph_pr_addr(&con->msgr->inst.addr.in_addr));
 	}

-	set_bit(NEGOTIATING, &con->state);
-	prepare_read_connect(con);
 	return 0;
 }

@@ -1505,7 +1504,6 @@ static int process_connect(struct ceph_c
 			return -1;
 		}
 		con->auth_retry = 1;
-		con_out_kvec_reset(con);
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			return ret;
@@ -1526,7 +1524,6 @@ static int process_connect(struct ceph_c
 		       ENTITY_NAME(con->peer_name),
 		       ceph_pr_addr(&con->peer_addr.in_addr));
 		reset_connection(con);
-		con_out_kvec_reset(con);
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			return ret;
@@ -1552,7 +1549,6 @@ static int process_connect(struct ceph_c
 		     le32_to_cpu(con->out_connect.connect_seq),
 		     le32_to_cpu(con->in_connect.connect_seq));
 		con->connect_seq = le32_to_cpu(con->in_connect.connect_seq);
-		con_out_kvec_reset(con);
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			return ret;
@@ -1569,7 +1565,6 @@ static int process_connect(struct ceph_c
 		     le32_to_cpu(con->in_connect.global_seq));
 		get_global_seq(con->msgr,
 			       le32_to_cpu(con->in_connect.global_seq));
-		con_out_kvec_reset(con);
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			return ret;
@@ -1983,9 +1978,6 @@ more:

 		con_out_kvec_reset(con);
 		prepare_write_banner(con);
-		ret = prepare_write_connect(con);
-		if (ret < 0)
-			goto out;
 		prepare_read_banner(con);

 		BUG_ON(con->in_msg);
@@ -2098,6 +2090,16 @@ more:
 			ret = process_banner(con);
 			if (ret < 0)
 				goto out;
+
+			/* Banner is good, exchange connection info */
+			ret = prepare_write_connect(con);
+			if (ret < 0)
+				goto out;
+			prepare_read_connect(con);
+			set_bit(NEGOTIATING, &con->state);
+
+			/* Send connection info before awaiting response */
+			goto out;
 		}
 		ret = read_partial_connect(con);
 		if (ret <= 0)
