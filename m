From: Sage Weil <sage@inktank.com>
Subject: [PATCH 4/9] libceph: fix mutex coverage for ceph_con_close
Date: Fri, 20 Jul 2012 17:41:43 -0700
Message-ID: <1342831308-18815-5-git-send-email-sage@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46564 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab2GUAdK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 20:33:10 -0400
In-Reply-To: <1342831308-18815-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Hold the mutex while twiddling all of the state bits to avoid possible
races.  While we're here, make not of why we cannot close the socket
directly.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 7105908..e24310e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -503,6 +503,7 @@ static void reset_connection(struct ceph_connection *con)
  */
 void ceph_con_close(struct ceph_connection *con)
 {
+	mutex_lock(&con->mutex);
 	dout("con_close %p peer %s\n", con,
 	     ceph_pr_addr(&con->peer_addr.in_addr));
 	clear_bit(NEGOTIATING, &con->state);
@@ -515,11 +516,16 @@ void ceph_con_close(struct ceph_connection *con)
 	clear_bit(KEEPALIVE_PENDING, &con->flags);
 	clear_bit(WRITE_PENDING, &con->flags);
 
-	mutex_lock(&con->mutex);
 	reset_connection(con);
 	con->peer_global_seq = 0;
 	cancel_delayed_work(&con->work);
 	mutex_unlock(&con->mutex);
+
+	/*
+	 * We cannot close the socket directly from here because the
+	 * work threads use it without holding the mutex.  Instead, let
+	 * con_work() do it.
+	 */
 	queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_close);
-- 
1.7.9

