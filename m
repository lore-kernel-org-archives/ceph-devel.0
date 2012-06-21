From: Alex Elder <elder@inktank.com>
Subject: [PATCH 01/12] libceph: SOCK_CLOSED is a flag, not a state
Date: Thu, 21 Jun 2012 09:20:56 -0500
Message-ID: <4FE32DC8.5020306@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36345 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab2FUO0A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:26:00 -0400
Received: by yenl2 with SMTP id l2so501676yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:26:00 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The following commit changed it so SOCK_CLOSED bit was stored in
a connection's new "flags" field rather than its "state" field.

    libceph: start separating connection flags from state
    commit 928443cd

That bit is used in con_close_socket() to protect against setting an
error message more than once in the socket event handler function.

Unfortunately, the field being operated on in that function was not
updated to be "flags" as it should have been.  This fixes that
error.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -397,11 +397,11 @@ static int con_close_socket(struct ceph_
 	dout("con_close_socket on %p sock %p\n", con, con->sock);
 	if (!con->sock)
 		return 0;
-	set_bit(SOCK_CLOSED, &con->state);
+	set_bit(SOCK_CLOSED, &con->flags);
 	rc = con->sock->ops->shutdown(con->sock, SHUT_RDWR);
 	sock_release(con->sock);
 	con->sock = NULL;
-	clear_bit(SOCK_CLOSED, &con->state);
+	clear_bit(SOCK_CLOSED, &con->flags);
 	con_sock_state_closed(con);
 	return rc;
 }
