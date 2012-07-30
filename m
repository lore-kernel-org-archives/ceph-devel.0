From: Sage Weil <sage@inktank.com>
Subject: [PATCH 5/8] libceph: verify state after retaking con lock after dispatch
Date: Mon, 30 Jul 2012 08:59:28 -0700
Message-ID: <1343663971-3221-6-git-send-email-sage@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45769 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab2G3P7n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 11:59:43 -0400
In-Reply-To: <1343663971-3221-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

We drop the con mutex when delivering a message.  When we retake the
lock, we need to verify we are still in the OPEN state before
preparing to read the next tag, or else we risk stepping on a
connection that has been closed.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index a6a0c7a..feb5a2a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2003,7 +2003,6 @@ static void process_message(struct ceph_connection *con)
 	con->ops->dispatch(con, msg);
 
 	mutex_lock(&con->mutex);
-	prepare_read_tag(con);
 }
 
 
@@ -2213,6 +2212,8 @@ more:
 		if (con->in_tag == CEPH_MSGR_TAG_READY)
 			goto more;
 		process_message(con);
+		if (con->state == CON_STATE_OPEN)
+			prepare_read_tag(con);
 		goto more;
 	}
 	if (con->in_tag == CEPH_MSGR_TAG_ACK) {
-- 
1.7.9.5

