From: Alex Elder <elder@inktank.com>
Subject: [PATCH 03/12] libceph: just set SOCK_CLOSED when state changes
Date: Thu, 21 Jun 2012 09:21:15 -0500
Message-ID: <4FE32DDB.9080606@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48665 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872Ab2FUOVR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:21:17 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so495707ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:21:17 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a TCP_CLOSE or TCP_CLOSE_WAIT event occurs, the SOCK_CLOSED
connection flag bit is set, and if it had not been previously set
queue_con() is called to ensure con_work() will get a chance to
handle the changed state.

con_work() atomically checks--and if set, clears--the SOCK_CLOSED
bit if it was set.  This means that even if the bit were set
repeatedly, the related processing in con_work() only gets called
once per transition of the bit from 0 to 1.

What's important then is that we ensure con_work() gets called *at
least* once when a socket close event occurs, not that it gets
called *exactly* once.

The work queue mechanism already takes care of queueing work
only if it is not already queued, so there's no need for us
to call queue_con() conditionally.

So this patch just makes it so the SOCK_CLOSED flag gets set
unconditionally in ceph_sock_state_change().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -261,8 +261,8 @@ static void ceph_sock_state_change(struc
 	case TCP_CLOSE_WAIT:
 		dout("%s TCP_CLOSE_WAIT\n", __func__);
 		con_sock_state_closing(con);
-		if (!test_and_set_bit(SOCK_CLOSED, &con->flags))
-			queue_con(con);
+		set_bit(SOCK_CLOSED, &con->flags);
+		queue_con(con);
 		break;
 	case TCP_ESTABLISHED:
 		dout("%s TCP_ESTABLISHED\n", __func__);
