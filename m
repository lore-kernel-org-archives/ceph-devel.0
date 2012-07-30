From: Sage Weil <sage@inktank.com>
Subject: [PATCH 6/8] libceph: avoid dropping con mutex before fault
Date: Mon, 30 Jul 2012 08:59:29 -0700
Message-ID: <1343663971-3221-7-git-send-email-sage@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45771 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2G3P7n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 11:59:43 -0400
In-Reply-To: <1343663971-3221-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

The ceph_fault() function takes the con mutex, so we should avoid
dropping it before calling it.  This fixes a potential race with
another thread calling ceph_con_close(), or _open(), or similar (we
don't reverify con->state after retaking the lock).

Add annotation so that lockdep realizes we will drop the mutex before
returning.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index feb5a2a..c3b628c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2336,7 +2336,6 @@ done_unlocked:
 	return;
 
 fault:
-	mutex_unlock(&con->mutex);
 	ceph_fault(con);     /* error/fault path */
 	goto done_unlocked;
 }
@@ -2347,9 +2346,8 @@ fault:
  * exponential backoff
  */
 static void ceph_fault(struct ceph_connection *con)
+	__releases(con->mutex)
 {
-	mutex_lock(&con->mutex);
-
 	pr_err("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
 	       ceph_pr_addr(&con->peer_addr.in_addr), con->error_msg);
 	dout("fault %p state %lu to peer %s\n",
-- 
1.7.9.5

