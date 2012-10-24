From: Sage Weil <sage@inktank.com>
Subject: [PATCH] libceph: avoid NULL kref_put when osd reset races with alloc_msg
Date: Wed, 24 Oct 2012 16:20:29 -0700
Message-ID: <1351120829-12219-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53582 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2JXXTk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 19:19:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

The ceph_on_in_msg_alloc() method drops con->mutex while it allocates a
message.  If that races with a timeout that resends a zillion messages and
resets the connection, and the ->alloc_msg() method returns a NULL message,
it will call ceph_msg_put(NULL) and BUG.

Fix by only calling put if msg is non-NULL.

Fixes http://tracker.newdream.net/issues/3142

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 66f6f56..1041114 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2742,7 +2742,8 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
 		msg = con->ops->alloc_msg(con, hdr, skip);
 		mutex_lock(&con->mutex);
 		if (con->state != CON_STATE_OPEN) {
-			ceph_msg_put(msg);
+			if (msg)
+				ceph_msg_put(msg);
 			return -EAGAIN;
 		}
 		con->in_msg = msg;
-- 
1.7.9

