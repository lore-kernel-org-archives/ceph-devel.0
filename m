From: Sage Weil <sage@inktank.com>
Subject: [PATCH] libceph: fix protocol feature mismatch failure path
Date: Thu, 27 Dec 2012 16:07:20 -0800
Message-ID: <1356653240-23146-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44063 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab2L0X7N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Dec 2012 18:59:13 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

We should not set con->state to CLOSED here; that happens in ceph_fault()
in the caller, where it first asserts that the state is not yet CLOSED.
Avoids a BUG when the features don't match.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 4d111fd..24a5c86 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1508,9 +1508,9 @@ static int process_banner(struct ceph_connection *con)
 
 static void fail_protocol(struct ceph_connection *con)
 {
+	dout("fail_protocol %p\n", con);
 	reset_connection(con);
 	BUG_ON(con->state != CON_STATE_NEGOTIATING);
-	con->state = CON_STATE_CLOSED;
 }
 
 static int process_connect(struct ceph_connection *con)
-- 
1.7.9

