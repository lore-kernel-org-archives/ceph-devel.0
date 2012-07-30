From: Sage Weil <sage@inktank.com>
Subject: [PATCH 4/8] libceph: revoke mon_client messages on session restart
Date: Mon, 30 Jul 2012 08:59:27 -0700
Message-ID: <1343663971-3221-5-git-send-email-sage@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45767 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab2G3P7m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 11:59:42 -0400
In-Reply-To: <1343663971-3221-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Revoke all mon_client messages when we shut down the old connection.
This is mostly moot since we are re-using the same ceph_connection,
but it is cleaner.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/mon_client.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index bfd21a8..105d533 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -118,6 +118,9 @@ static void __close_session(struct ceph_mon_client *monc)
 {
 	dout("__close_session closing mon%d\n", monc->cur_mon);
 	ceph_msg_revoke(monc->m_auth);
+	ceph_msg_revoke_incoming(monc->m_auth_reply);
+	ceph_msg_revoke(monc->m_subscribe);
+	ceph_msg_revoke_incoming(monc->m_subscribe_ack);
 	ceph_con_close(&monc->con);
 	monc->cur_mon = -1;
 	monc->pending_auth = 0;
@@ -685,6 +688,7 @@ static void __resend_generic_request(struct ceph_mon_client *monc)
 	for (p = rb_first(&monc->generic_request_tree); p; p = rb_next(p)) {
 		req = rb_entry(p, struct ceph_mon_generic_request, node);
 		ceph_msg_revoke(req->request);
+		ceph_msg_revoke_incoming(req->reply);
 		ceph_con_send(&monc->con, ceph_msg_get(req->request));
 	}
 }
-- 
1.7.9.5

