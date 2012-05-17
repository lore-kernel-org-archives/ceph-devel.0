From: Alex Elder <elder@inktank.com>
Subject: [PATCH 14/16] ceph: return pointer from prepare_connect_authorizer()
Date: Thu, 17 May 2012 09:05:17 -0500
Message-ID: <4FB5059D.8080404@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34817 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966342Ab2EQOFO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:05:14 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so1802686ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:05:14 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change prepare_connect_authorizer() so it returns a pointer (or
pointer-coded error).

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |   18 +++++++++---------
  1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6d82c1a..f92d564 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -653,7 +653,7 @@ static void prepare_write_keepalive(struct 
ceph_connection *con)
   * Connection negotiation.
   */

-static int prepare_connect_authorizer(struct ceph_connection *con)
+static struct ceph_auth_handshake *prepare_connect_authorizer(struct 
ceph_connection *con)
  {
  	void *auth_buf;
  	int auth_len;
@@ -664,7 +664,7 @@ static int prepare_connect_authorizer(struct 
ceph_connection *con)
  		con->out_connect.authorizer_protocol = CEPH_AUTH_UNKNOWN;
  		con->out_connect.authorizer_len = 0;

-		return 0;
+		return NULL;
  	}

  	/* Can't hold the mutex while getting authorizer */
@@ -677,9 +677,9 @@ static int prepare_connect_authorizer(struct 
ceph_connection *con)
  	mutex_lock(&con->mutex);

  	if (IS_ERR(auth))
-		return PTR_ERR(auth);
+		return auth;
  	if (test_bit(CLOSED, &con->state) || test_bit(OPENING, &con->state))
-		return -EAGAIN;
+		return ERR_PTR(-EAGAIN);

  	auth_buf = auth->authorizer_buf;
  	auth_len = auth->authorizer_buf_len;
@@ -692,7 +692,7 @@ static int prepare_connect_authorizer(struct 
ceph_connection *con)
  	if (auth_len)
  		ceph_con_out_kvec_add(con, auth_len, auth_buf);

-	return 0;
+	return auth;
  }

  /*
@@ -712,7 +712,7 @@ static int prepare_write_connect(struct 
ceph_connection *con)
  {
  	unsigned global_seq = get_global_seq(con->msgr, 0);
  	int proto;
-	int ret;
+	struct ceph_auth_handshake *auth;

  	switch (con->peer_name.type) {
  	case CEPH_ENTITY_TYPE_MON:
@@ -739,9 +739,9 @@ static int prepare_write_connect(struct 
ceph_connection *con)
  	con->out_connect.flags = 0;

  	ceph_con_out_kvec_add(con, sizeof (con->out_connect), &con->out_connect);
-	ret = prepare_connect_authorizer(con);
-	if (ret)
-		return ret;
+	auth = prepare_connect_authorizer(con);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);

  	con->out_more = 0;
  	set_bit(WRITE_PENDING, &con->state);
-- 
1.7.5.4

