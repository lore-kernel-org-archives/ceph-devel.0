From: Sage Weil <sage@inktank.com>
Subject: [PATCH 6/9] libceph: (re)initialize bio_iter on start of message receive
Date: Fri, 20 Jul 2012 17:41:45 -0700
Message-ID: <1342831308-18815-7-git-send-email-sage@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46571 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab2GUAdK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 20:33:10 -0400
In-Reply-To: <1342831308-18815-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Previously, we were opportunistically initializing the bio_iter if it
appeared to be uninitialized in the middle of the read path.  The problem
is that a sequence like:

 - start reading message
 - initialize bio_iter
 - read half a message
 - messenger fault, reconnect
 - restart reading message
 - ** bio_iter now non-NULL, not reinitialized **
 - read past end of bio, crash

Instead, initialize the bio_iter unconditionally when we allocate/claim
the message for read.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e24310e..efa369f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1876,6 +1876,11 @@ static int read_partial_message(struct ceph_connection *con)
 		else
 			con->in_msg_pos.page_pos = 0;
 		con->in_msg_pos.data_pos = 0;
+
+#ifdef CONFIG_BLOCK
+		if (m->bio)
+			init_bio_iter(m->bio, &m->bio_iter, &m->bio_seg);
+#endif
 	}
 
 	/* front */
@@ -1892,10 +1897,6 @@ static int read_partial_message(struct ceph_connection *con)
 		if (ret <= 0)
 			return ret;
 	}
-#ifdef CONFIG_BLOCK
-	if (m->bio && !m->bio_iter)
-		init_bio_iter(m->bio, &m->bio_iter, &m->bio_seg);
-#endif
 
 	/* (page) data */
 	while (con->in_msg_pos.data_pos < data_len) {
@@ -1906,7 +1907,7 @@ static int read_partial_message(struct ceph_connection *con)
 				return ret;
 #ifdef CONFIG_BLOCK
 		} else if (m->bio) {
-
+			BUG_ON(!m->bio_iter);
 			ret = read_partial_message_bio(con,
 						 &m->bio_iter, &m->bio_seg,
 						 data_len, do_datacrc);
-- 
1.7.9

