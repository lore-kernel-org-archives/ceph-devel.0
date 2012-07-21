From: Sage Weil <sage@inktank.com>
Subject: [PATCH 9/9] libceph: reset connection retry on successfully negotiation
Date: Fri, 20 Jul 2012 17:41:48 -0700
Message-ID: <1342831308-18815-10-git-send-email-sage@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46574 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab2GUAdL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 20:33:11 -0400
In-Reply-To: <1342831308-18815-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

We exponentially back off when we encounter connection errors.  If several
errors accumulate, we will eventually wait ages before even trying to
reconnect.

Fix this by resetting the backoff counter after a successful negotiation/
connection with the remote node.  Fixes ceph issue #2802.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 65964c2..28896eb 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1633,6 +1633,8 @@ static int process_connect(struct ceph_connection *con)
 		if (con->in_reply.flags & CEPH_MSG_CONNECT_LOSSY)
 			set_bit(LOSSYTX, &con->flags);
 
+		con->delay = 0;      /* reset backoff memory */
+
 		prepare_read_tag(con);
 		break;
 
-- 
1.7.9

