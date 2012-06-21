From: Alex Elder <elder@inktank.com>
Subject: [PATCH 12/12] libceph: add some fine ASCII art
Date: Thu, 21 Jun 2012 09:22:51 -0500
Message-ID: <4FE32E3B.7070203@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40234 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab2FUO2s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:28:48 -0400
Received: by gglu4 with SMTP id u4so504934ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:28:48 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage liked the state diagram I put in my commit description so
I'm putting it in with the code.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -29,7 +29,47 @@
  * the sender.
  */

-/* State values for ceph_connection->sock_state; NEW is assumed to be 0 */
+/*
+ * We track the state of the socket on a given connection using
+ * values defined below.  The transition to a new socket state is
+ * handled by a function which verifies we aren't coming from an
+ * unexpected state.
+ *
+ *      --------
+ *      | NEW* |  transient initial state
+ *      --------
+ *          | con_sock_state_init()
+ *          v
+ *      ----------
+ *      | CLOSED |  initialized, but no socket (and no
+ *      ----------  TCP connection)
+ *       ^      \
+ *       |       \ con_sock_state_connecting()
+ *       |        ----------------------
+ *       |                              \
+ *       + con_sock_state_closed()       \
+ *       |\                               \
+ *       | \                               \
+ *       |  -----------                     \
+ *       |  | CLOSING |  socket event;       \
+ *       |  -----------  await close          \
+ *       |       ^                            |
+ *       |       |                            |
+ *       |       + con_sock_state_closing()   |
+ *       |      / \                           |
+ *       |     /   ---------------            |
+ *       |    /                   \           v
+ *       |   /                    --------------
+ *       |  /    -----------------| CONNECTING |  socket created, TCP
+ *       |  |   /                 --------------  connect initiated
+ *       |  |   | con_sock_state_connected()
+ *       |  |   v
+ *      -------------
+ *      | CONNECTED |  TCP connection established
+ *      -------------
+ *
+ * State values for ceph_connection->sock_state; NEW is assumed to be 0.
+ */

 #define CON_SOCK_STATE_NEW		0	/* -> CLOSED */
 #define CON_SOCK_STATE_CLOSED		1	/* -> CONNECTING */
