From: Sage Weil <sage@inktank.com>
Subject: [PATCH 8/8] libceph: recheck con state after allocating incoming message
Date: Mon, 30 Jul 2012 08:59:31 -0700
Message-ID: <1343663971-3221-9-git-send-email-sage@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45774 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab2G3P7o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 11:59:44 -0400
In-Reply-To: <1343663971-3221-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

We drop the lock when calling the ->alloc_msg() con op, which means
we need to (a) not clobber con->in_msg without the mutex held, and (b)
we need to verify that we are still in the OPEN state when we retake
it to avoid causing any mayhem.  If the state does change, -EAGAIN
will get us back to con_work() and loop.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5177af0..91ad692 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2735,9 +2735,16 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
 	BUG_ON(con->in_msg != NULL);
 
 	if (con->ops->alloc_msg) {
+		struct ceph_msg *msg;
+
 		mutex_unlock(&con->mutex);
-		con->in_msg = con->ops->alloc_msg(con, hdr, skip);
+		msg = con->ops->alloc_msg(con, hdr, skip);
 		mutex_lock(&con->mutex);
+		if (con->state != CON_STATE_OPEN) {
+			ceph_msg_put(msg);
+			return -EAGAIN;
+		}
+		con->in_msg = msg;
 		if (con->in_msg) {
 			con->in_msg->con = con->ops->get(con);
 			BUG_ON(con->in_msg->con == NULL);
-- 
1.7.9.5

