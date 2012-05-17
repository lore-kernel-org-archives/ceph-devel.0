From: Alex Elder <elder@inktank.com>
Subject: [PATCH 07/16] ceph: messenger: rework prepare_connect_authorizer()
Date: Thu, 17 May 2012 09:04:38 -0500
Message-ID: <4FB50576.5070904@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50220 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761919Ab2EQOEh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:04:37 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so1852487yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:04:37 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change prepare_connect_authorizer() so it returns without dropping
the connection mutex if the connection has no get_authorizer method.

Use the symbolic CEPH_AUTH_UNKNOWN instead of 0 when assigning
authorization protocols.

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |   28 +++++++++++++++++++---------
  1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8e76936..09409a3 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -656,19 +656,29 @@ static void prepare_write_keepalive(struct 
ceph_connection *con)
  static int prepare_connect_authorizer(struct ceph_connection *con)
  {
  	void *auth_buf;
-	int auth_len = 0;
-	int auth_protocol = 0;
+	int auth_len;
+	int auth_protocol;
+
+	if (!con->ops->get_authorizer) {
+		con->out_connect.authorizer_protocol = CEPH_AUTH_UNKNOWN;
+		con->out_connect.authorizer_len = 0;
+
+		return 0;
+	}
+
+	/* Can't hold the mutex while getting authorizer */

  	mutex_unlock(&con->mutex);
-	if (con->ops->get_authorizer)
-		con->ops->get_authorizer(con, &auth_buf, &auth_len,
-					 &auth_protocol, &con->auth_reply_buf,
-					 &con->auth_reply_buf_len,
-					 con->auth_retry);
+
+	auth_buf = NULL;
+	auth_len = 0;
+	auth_protocol = CEPH_AUTH_UNKNOWN;
+	con->ops->get_authorizer(con, &auth_buf, &auth_len, &auth_protocol,
+				&con->auth_reply_buf, &con->auth_reply_buf_len,
+				con->auth_retry);
  	mutex_lock(&con->mutex);

-	if (test_bit(CLOSED, &con->state) ||
-	    test_bit(OPENING, &con->state))
+	if (test_bit(CLOSED, &con->state) || test_bit(OPENING, &con->state))
  		return -EAGAIN;

  	con->out_connect.authorizer_protocol = cpu_to_le32(auth_protocol);
-- 
1.7.5.4

