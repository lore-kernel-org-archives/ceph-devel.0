From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] libceph: close socket directly during ceph_con_close()
Date: Tue, 26 Jun 2012 14:46:47 -0700
Message-ID: <4FEA2DC7.1080104@inktank.com>
References: <4FEA2D76.8080907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54565 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab2FZVqu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 17:46:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so631906pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 14:46:49 -0700 (PDT)
In-Reply-To: <4FEA2D76.8080907@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When we close the connection, immediately shut down the socket
instead of queuing work and letting the worker thread do it.  This
is simpler.

Signed-off-by: Sage Weil <sage@inktank.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |   29 +++++++++++++++--------------
  1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index fe42a36..2f574d2 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -47,18 +47,18 @@
   *       |       \ con_sock_state_connecting()
   *       |        ----------------------
   *       |                              \
- *       + con_sock_state_closed()       \
- *       |\                               \
- *       | \                               \
- *       |  -----------                     \
- *       |  | CLOSING |  socket event;       \
- *       |  -----------  await close          \
- *       |       ^                            |
- *       |       |                            |
- *       |       + con_sock_state_closing()   |
- *       |      / \                           |
- *       |     /   ---------------            |
- *       |    /                   \           v
+ *       +---------------------------    \
+ *       |\ con_sock_state_closed()  \    \
+ *       | \                          \    \
+ *       |  -----------                \    \
+ *       |  | CLOSING |  socket event;  \    \
+ *       |  -----------  await close     \    \
+ *       |       ^                        \   |
+ *       |       |                         \  |
+ *       |       + con_sock_state_closing() \ |
+ *       |      / \                         | |
+ *       |     /   ---------------          | |
+ *       |    /                   \         | v
   *       |   /                    --------------
   *       |  /    -----------------| CONNECTING |  socket created, TCP
   *       |  |   /                 --------------  connect initiated
@@ -241,7 +241,8 @@ static void con_sock_state_closed(struct 
ceph_connection *con)

  	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CLOSED);
  	if (WARN_ON(old_state != CON_SOCK_STATE_CONNECTED &&
-			old_state != CON_SOCK_STATE_CLOSING))
+		    old_state != CON_SOCK_STATE_CLOSING &&
+		    old_state != CON_SOCK_STATE_CONNECTING))
  		printk("%s: unexpected old state %d\n", __func__, old_state);
  }

@@ -514,9 +515,9 @@ void ceph_con_close(struct ceph_connection *con)
  	mutex_lock(&con->mutex);
  	reset_connection(con);
  	con->peer_global_seq = 0;
+	con_close_socket(con);
  	cancel_delayed_work(&con->work);
  	mutex_unlock(&con->mutex);
-	queue_con(con);
  }
  EXPORT_SYMBOL(ceph_con_close);

-- 
1.7.9.5

