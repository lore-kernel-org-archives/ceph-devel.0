From: Sage Weil <sage@inktank.com>
Subject: [PATCH 6/6] libceph: verify authorizer reply
Date: Tue, 19 Mar 2013 16:08:06 -0700
Message-ID: <1363734486-26879-6-git-send-email-sage@inktank.com>
References: <1363734486-26879-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54530 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab3CSXIK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 19:08:10 -0400
In-Reply-To: <1363734486-26879-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

The 'cephx' auth protocol provides mutual authenticate for client and
server.  However, as the client, we were not verifying that the server
auth reply was in fact authentic.  Although the infrastructure to do so was
all in place, we neglected to actually call the function to do it.  Fix!

This resolves http://tracker.ceph.com/issues/2429.

Reported-by: Alex Elder <elder@inktank.com>
Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 19af956..664adb1 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1954,10 +1954,27 @@ static int process_connect(struct ceph_connection *con)
 	u64 sup_feat = con->msgr->supported_features;
 	u64 req_feat = con->msgr->required_features;
 	u64 server_feat = le64_to_cpu(con->in_reply.features);
+	int authorizer_len = le32_to_cpu(con->in_reply.authorizer_len);
 	int ret;
 
 	dout("process_connect on %p tag %d\n", con, (int)con->in_tag);
 
+	if (authorizer_len && con->ops->verify_authorizer_reply) {
+		mutex_unlock(&con->mutex);
+		ret = con->ops->verify_authorizer_reply(con, authorizer_len);
+		mutex_lock(&con->mutex);
+		if (con->state != CON_STATE_NEGOTIATING)
+			return -EAGAIN;
+		if (ret < 0) {
+			pr_err("%s%lld %s bad authorizer reply, failed to"
+			       " authenticate server\n",
+			       ENTITY_NAME(con->peer_name),
+			       ceph_pr_addr(&con->peer_addr.in_addr));
+			con->error_msg = "failed to authenticate server";
+			return -1;
+		}
+	}
+
 	switch (con->in_reply.tag) {
 	case CEPH_MSGR_TAG_FEATURES:
 		pr_err("%s%lld %s feature set mismatch,"
-- 
1.7.9.5

