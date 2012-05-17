From: Alex Elder <elder@inktank.com>
Subject: [PATCH 08/16] ceph: messenger: check return from get_authorizer
Date: Thu, 17 May 2012 09:04:45 -0500
Message-ID: <4FB5057D.7070808@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34817 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761919Ab2EQOEn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:04:43 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so1802686ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:04:42 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In prepare_connect_authorizer(), a connection's get_authorizer
method is called but ignores its return value.  This function can
return an error, so check for it and return it if that ever occurs.

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |   10 +++++++---
  1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 09409a3..e0532d5 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -658,6 +658,7 @@ static int prepare_connect_authorizer(struct 
ceph_connection *con)
  	void *auth_buf;
  	int auth_len;
  	int auth_protocol;
+	int ret;

  	if (!con->ops->get_authorizer) {
  		con->out_connect.authorizer_protocol = CEPH_AUTH_UNKNOWN;
@@ -673,11 +674,14 @@ static int prepare_connect_authorizer(struct 
ceph_connection *con)
  	auth_buf = NULL;
  	auth_len = 0;
  	auth_protocol = CEPH_AUTH_UNKNOWN;
-	con->ops->get_authorizer(con, &auth_buf, &auth_len, &auth_protocol,
-				&con->auth_reply_buf, &con->auth_reply_buf_len,
-				con->auth_retry);
+	ret = con->ops->get_authorizer(con, &auth_buf, &auth_len,
+				&auth_protocol, &con->auth_reply_buf,
+				&con->auth_reply_buf_len, con->auth_retry);
  	mutex_lock(&con->mutex);

+	if (ret)
+		return ret;
+
  	if (test_bit(CLOSED, &con->state) || test_bit(OPENING, &con->state))
  		return -EAGAIN;

-- 
1.7.5.4

