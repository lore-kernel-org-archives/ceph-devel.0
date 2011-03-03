From: Sage Weil <sage@newdream.net>
Subject: [PATCH 5/8] libceph: retry after authorization failure
Date: Thu,  3 Mar 2011 12:40:07 -0800
Message-ID: <1299184810-19125-6-git-send-email-sage@newdream.net>
References: <1299184810-19125-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52166 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758708Ab1CCUj7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:39:59 -0500
In-Reply-To: <1299184810-19125-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

If we mark the connection CLOSED we will give up trying to reconnect to
this server instance.  That is appropriate for things like a protocol
version mismatch that won't change until the server is restarted, at which
point we'll get a new addr and reconnect.  An authorization failure like
this is probably due to the server not properly rotating it's secret keys,
however, and should be treated as transient so that the normal backoff and
retry behavior kicks in.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/messenger.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 35b36b8..6bd5025 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1248,8 +1248,6 @@ static int process_connect(struct ceph_connection *con)
 		     con->auth_retry);
 		if (con->auth_retry == 2) {
 			con->error_msg = "connect authorization failure";
-			reset_connection(con);
-			set_bit(CLOSED, &con->state);
 			return -1;
 		}
 		con->auth_retry = 1;
-- 
1.7.0

