From: Alex Elder <elder@inktank.com>
Subject: [PATCH 8/9] libceph: close connection on connect failure
Date: Fri, 22 Jun 2012 17:48:58 -0500
Message-ID: <4FE4F65A.20208@inktank.com>
References: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53187 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab2FVWs6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:48:58 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so1973383ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:48:57 -0700 (PDT)
In-Reply-To: <4FE4F534.1000009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The only time the CLOSED state is set on a ceph connection is in
ceph_con_init() and ceph_con_close().  Both of these will ensure
the connection's socket is closed.  Therefore there is no need
to close the socket in con_work() if the connection is found to
be in CLOSED state.

Rearrange things a bit in ceph_con_close() so we only manipulate
the state and flag bits *after* we've acquired the connection mutex.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -502,6 +502,8 @@ void ceph_con_close(struct ceph_connecti
 {
 	dout("con_close %p peer %s\n", con,
 	     ceph_pr_addr(&con->peer_addr.in_addr));
+
+	mutex_lock(&con->mutex);
 	clear_bit(NEGOTIATING, &con->state);
 	clear_bit(CONNECTING, &con->state);
 	clear_bit(CONNECTED, &con->state);
@@ -512,11 +514,13 @@ void ceph_con_close(struct ceph_connecti
 	clear_bit(KEEPALIVE_PENDING, &con->flags);
 	clear_bit(WRITE_PENDING, &con->flags);

-	mutex_lock(&con->mutex);
+	/* Clear everything out */
 	reset_connection(con);
 	con->peer_global_seq = 0;
 	cancel_delayed_work(&con->work);
+
 	mutex_unlock(&con->mutex);
+
 	queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_close);
@@ -2372,7 +2376,6 @@ restart:
 	}
 	if (test_bit(CLOSED, &con->state)) { /* e.g. if we are replaced */
 		dout("con_work CLOSED\n");
-		con_close_socket(con);
 		goto done;
 	}
 	if (test_and_clear_bit(OPENING, &con->state)) {
