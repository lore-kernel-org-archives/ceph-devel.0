From: Alex Elder <elder@inktank.com>
Subject: [PATCH 04/12] libceph: don't touch con state in con_close_socket()
Date: Thu, 21 Jun 2012 09:21:26 -0500
Message-ID: <4FE32DE6.3070208@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:34764 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078Ab2FUO1S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:27:18 -0400
Received: by yhnn12 with SMTP id n12so618377yhn.10
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:27:17 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In con_close_socket(), a connection's SOCK_CLOSED flag gets set and
then cleared while its shutdown method is called and its reference
gets dropped.

Previously, that flag got set only if it had not already been set,
so setting it in con_close_socket() might have prevented additional
processing being done on a socket being shut down.  We no longer set
SOCK_CLOSED in the socket event routine conditionally, so setting
that bit here no longer provides whatever benefit it might have
provided before.

A race condition could still leave the SOCK_CLOSED bit set even
after we've issued the call to con_close_socket(), so we still clear
that bit after shutting the socket down.  Add a comment explaining
the reason for this.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -392,10 +392,16 @@ static int con_close_socket(struct ceph_
 	dout("con_close_socket on %p sock %p\n", con, con->sock);
 	if (!con->sock)
 		return 0;
-	set_bit(SOCK_CLOSED, &con->flags);
 	rc = con->sock->ops->shutdown(con->sock, SHUT_RDWR);
 	sock_release(con->sock);
 	con->sock = NULL;
+
+	/*
+	 * Forcibly clear the SOCK_CLOSE flag.  It gets set
+	 * independent of the connection mutex, and we could have
+	 * received a socket close event before we had the chance to
+	 * shut the socket down.
+	 */
 	clear_bit(SOCK_CLOSED, &con->flags);
 	con_sock_state_closed(con);
 	return rc;
