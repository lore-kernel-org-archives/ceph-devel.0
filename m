From: Alex Elder <elder@inktank.com>
Subject: [PATCH 15/16] ceph: rename prepare_connect_authorizer()
Date: Thu, 17 May 2012 09:05:20 -0500
Message-ID: <4FB505A0.5040201@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50220 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966342Ab2EQOFR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:05:17 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so1852487yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:05:17 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change the name of prepare_connect_authorizer().  The next
patch is going to make this function no longer add anything to the
connection's out_kvec, so it will no longer fit the pattern of
the rest of the prepare_connect_*() functions.

In addition, pass the address of a variable that will hold the
authorization protocol to use.  Move the assignment of that to the
connection's out_connect structure into prepare_write_connect().

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  net/ceph/messenger.c |   13 +++++++------
  1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f92d564..bfddd87 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -653,11 +653,11 @@ static void prepare_write_keepalive(struct 
ceph_connection *con)
   * Connection negotiation.
   */

-static struct ceph_auth_handshake *prepare_connect_authorizer(struct 
ceph_connection *con)
+static struct ceph_auth_handshake *get_connect_authorizer(struct 
ceph_connection *con,
+						int *auth_proto)
  {
  	void *auth_buf;
  	int auth_len;
-	int auth_protocol;
  	struct ceph_auth_handshake *auth;

  	if (!con->ops->get_authorizer) {
@@ -671,8 +671,7 @@ static struct ceph_auth_handshake 
*prepare_connect_authorizer(struct ceph_connec

  	mutex_unlock(&con->mutex);

-	auth_protocol = CEPH_AUTH_UNKNOWN;
-	auth = con->ops->get_authorizer(con, &auth_protocol, con->auth_retry);
+	auth = con->ops->get_authorizer(con, auth_proto, con->auth_retry);

  	mutex_lock(&con->mutex);

@@ -686,7 +685,6 @@ static struct ceph_auth_handshake 
*prepare_connect_authorizer(struct ceph_connec
  	con->auth_reply_buf = auth->authorizer_reply_buf;
  	con->auth_reply_buf_len = auth->authorizer_reply_buf_len;

-	con->out_connect.authorizer_protocol = cpu_to_le32(auth_protocol);
  	con->out_connect.authorizer_len = cpu_to_le32(auth_len);

  	if (auth_len)
@@ -712,6 +710,7 @@ static int prepare_write_connect(struct 
ceph_connection *con)
  {
  	unsigned global_seq = get_global_seq(con->msgr, 0);
  	int proto;
+	int auth_proto;
  	struct ceph_auth_handshake *auth;

  	switch (con->peer_name.type) {
@@ -739,9 +738,11 @@ static int prepare_write_connect(struct 
ceph_connection *con)
  	con->out_connect.flags = 0;

  	ceph_con_out_kvec_add(con, sizeof (con->out_connect), &con->out_connect);
-	auth = prepare_connect_authorizer(con);
+	auth_proto = CEPH_AUTH_UNKNOWN;
+	auth = get_connect_authorizer(con, &auth_proto);
  	if (IS_ERR(auth))
  		return PTR_ERR(auth);
+	con->out_connect.authorizer_protocol = cpu_to_le32(auth_proto);

  	con->out_more = 0;
  	set_bit(WRITE_PENDING, &con->state);
-- 
1.7.5.4

