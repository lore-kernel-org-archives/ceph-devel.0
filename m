From: "Jim Schutt" <jaschut@SANDIA.GOV>
Subject: [PATCH] net/ceph: Only clear SOCK_NOSPACE when there is
 sufficient space in the socket buffer
Date: Wed,  1 Feb 2012 08:59:49 -0700
Message-ID: <1328111989-10191-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:42541 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab2BAQRf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 11:17:35 -0500
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1312717A6F1
	for <ceph-devel@vger.kernel.org>; Wed,  1 Feb 2012 09:00:29 -0700 (MST)
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 1 Feb 2012 09:00:04 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@SANDIA.GOV>

The Ceph messenger would sometimes queue multiple work items to write
data to a socket when the socket buffer was full.

Fix this problem by making ceph_write_space() use SOCK_NOSPACE in the
same way that net/core/stream.c:sk_stream_write_space() does, i.e.,
clearing it only when sufficient space is available in the socket buffer.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 net/ceph/messenger.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 67973f0..a4df90b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -175,16 +175,22 @@ static void ceph_write_space(struct sock *sk)
 	struct ceph_connection *con =
 		(struct ceph_connection *)sk->sk_user_data;
 
-	/* only queue to workqueue if there is data we want to write. */
+	/* only queue to workqueue if there is data we want to write,
+	 * and there is sufficient space in the socket buffer to accept
+	 * more data.  clear SOCK_NOSPACE so that ceph_write_space()
+	 * doesn't get called again until try_write() fills the socket
+	 * buffer. See net/ipv4/tcp_input.c:tcp_check_space()
+	 * and net/core/stream.c:sk_stream_write_space().
+	 */
 	if (test_bit(WRITE_PENDING, &con->state)) {
-		dout("ceph_write_space %p queueing write work\n", con);
-		queue_con(con);
+		if (sk_stream_wspace(sk) >= sk_stream_min_wspace(sk)) {
+			dout("ceph_write_space %p queueing write work\n", con);
+			clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+			queue_con(con);
+		}
 	} else {
 		dout("ceph_write_space %p nothing to write\n", con);
 	}
-
-	/* since we have our own write_space, clear the SOCK_NOSPACE flag */
-	clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 }
 
 /* socket's state has changed */
-- 
1.7.1


