From: Alex Elder <elder@inktank.com>
Subject: [PATCH 06/12] libceph: clear NEGOTIATING when done
Date: Thu, 21 Jun 2012 09:21:53 -0500
Message-ID: <4FE32E01.4050702@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64146 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108Ab2FUOVz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:21:55 -0400
Received: by yenl2 with SMTP id l2so496672yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:21:54 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A connection state's NEGOTIATING bit gets set while in CONNECTING
state after we have successfully exchanged a ceph banner and IP
addresses with the connection's peer (the server).  But that bit
is not cleared again--at least not until another connection attempt
is initiated.

Instead, clear it as soon as the connection is fully established.
Also, clear it when a socket connection gets prematurely closed
in the midst of establishing a ceph connection (in case we had
reached the point where it was set).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1586,6 +1586,7 @@ static int process_connect(struct ceph_c
 			fail_protocol(con);
 			return -1;
 		}
+		clear_bit(NEGOTIATING, &con->state);
 		clear_bit(CONNECTING, &con->state);
 		con->peer_global_seq = le32_to_cpu(con->in_reply.global_seq);
 		con->connect_seq++;
@@ -1976,7 +1977,6 @@ more:

 	/* open the socket first? */
 	if (con->sock == NULL) {
-		clear_bit(NEGOTIATING, &con->state);
 		set_bit(CONNECTING, &con->state);

 		con_out_kvec_reset(con);
@@ -2215,10 +2215,12 @@ static void con_work(struct work_struct
 	mutex_lock(&con->mutex);
 restart:
 	if (test_and_clear_bit(SOCK_CLOSED, &con->flags)) {
-		if (test_and_clear_bit(CONNECTING, &con->state))
+		if (test_and_clear_bit(CONNECTING, &con->state)) {
+			clear_bit(NEGOTIATING, &con->state);
 			con->error_msg = "connection failed";
-		else
+		} else {
 			con->error_msg = "socket closed";
+		}
 		goto fault;
 	}

