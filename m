From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 3.6-rc1] libceph: ensure banner is written on client
 connect before feature negotiation starts
Date: Wed,  8 Aug 2012 12:09:38 -0600
Message-ID: <1344449378-304-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:56646 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030232Ab2HHSKK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 14:10:10 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1B4D6D2CFF0
	for <ceph-devel@vger.kernel.org>; Wed,  8 Aug 2012 12:10:04 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 8 Aug 2012 12:09:59 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Because the Ceph client messenger uses a non-blocking connect, it is possible
for the sending of the client banner to race with the arrival of the banner
sent by the peer.

When ceph_sock_state_change() notices the connect has completed, it schedules
work to process the socket via con_work().  During this time the peer is
writing its banner, and arrival of the peer banner races with con_work().

If con_work() calls try_read() before the peer banner arrives, there is
nothing for it to do, after which con_work() calls try_write() to send the
client's banner.  In this case Ceph's protocol negotiation can complete
succesfully.

If, however, the peer's banner arrives before con_work() calls try_read(),
then try_read() will read the banner and prepare protocol negotiation info via
prepare_write_connect().  prepare_write_connect() calls con_out_kvec_reset(),
which discards the as-yet-unsent client banner.  Next, con_work() calls
try_write(), which sends the protocol negotiation info rather than the banner
that the peer is expecting.

The result is that the peer sees an invalid banner, and the client reports
"negotiation failed".

Fix this by moving con_out_kvec_reset() out of prepare_write_connect() to its
callers at all locations except the one where the banner might still need to
be sent.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 net/ceph/messenger.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b979675..24c5eea 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -915,7 +915,6 @@ static int prepare_write_connect(struct ceph_connection *con)
 	con->out_connect.authorizer_len = auth ?
 		cpu_to_le32(auth->authorizer_buf_len) : 0;
 
-	con_out_kvec_reset(con);
 	con_out_kvec_add(con, sizeof (con->out_connect),
 					&con->out_connect);
 	if (auth && auth->authorizer_buf_len)
@@ -1557,6 +1556,7 @@ static int process_connect(struct ceph_connection *con)
 			return -1;
 		}
 		con->auth_retry = 1;
+		con_out_kvec_reset(con);
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			return ret;
@@ -1577,6 +1577,7 @@ static int process_connect(struct ceph_connection *con)
 		       ENTITY_NAME(con->peer_name),
 		       ceph_pr_addr(&con->peer_addr.in_addr));
 		reset_connection(con);
+		con_out_kvec_reset(con);
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			return ret;
@@ -1601,6 +1602,7 @@ static int process_connect(struct ceph_connection *con)
 		     le32_to_cpu(con->out_connect.connect_seq),
 		     le32_to_cpu(con->in_reply.connect_seq));
 		con->connect_seq = le32_to_cpu(con->in_reply.connect_seq);
+		con_out_kvec_reset(con);
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			return ret;
@@ -1617,6 +1619,7 @@ static int process_connect(struct ceph_connection *con)
 		     le32_to_cpu(con->in_reply.global_seq));
 		get_global_seq(con->msgr,
 			       le32_to_cpu(con->in_reply.global_seq));
+		con_out_kvec_reset(con);
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			return ret;
@@ -2135,7 +2138,11 @@ more:
 		BUG_ON(con->state != CON_STATE_CONNECTING);
 		con->state = CON_STATE_NEGOTIATING;
 
-		/* Banner is good, exchange connection info */
+		/*
+		 * Received banner is good, exchange connection info.
+		 * Do not reset out_kvec, as sending our banner raced
+		 * with receiving peer banner after connect completed.
+		 */
 		ret = prepare_write_connect(con);
 		if (ret < 0)
 			goto out;
-- 
1.7.8.2


