From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/4] libceph: msg signing callouts don't need con argument
Date: Mon,  2 Nov 2015 23:44:07 +0100
Message-ID: <1446504250-25647-2-git-send-email-idryomov@gmail.com>
References: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37860 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbbKBVEc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 16:04:32 -0500
Received: by wicfv8 with SMTP id fv8so58632395wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 13:04:30 -0800 (PST)
In-Reply-To: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

We can use msg->con instead - at the point we sign an outgoing message
or check the signature on the incoming one, msg->con is always set.  We
wouldn't know how to sign a message without an associated session (i.e.
msg->con == NULL) and being able to sign a message using an explicitly
provided authorizer is of no use.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/mds_client.c           | 14 ++++++++------
 include/linux/ceph/messenger.h |  5 ++---
 net/ceph/messenger.c           |  4 ++--
 net/ceph/osd_client.c          | 14 ++++++++------
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 89838a226fe9..e7b130a637f9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3942,17 +3942,19 @@ static struct ceph_msg *mds_alloc_msg(struct ceph_connection *con,
 	return msg;
 }
 
-static int sign_message(struct ceph_connection *con, struct ceph_msg *msg)
+static int mds_sign_message(struct ceph_msg *msg)
 {
-       struct ceph_mds_session *s = con->private;
+       struct ceph_mds_session *s = msg->con->private;
        struct ceph_auth_handshake *auth = &s->s_auth;
+
        return ceph_auth_sign_message(auth, msg);
 }
 
-static int check_message_signature(struct ceph_connection *con, struct ceph_msg *msg)
+static int mds_check_message_signature(struct ceph_msg *msg)
 {
-       struct ceph_mds_session *s = con->private;
+       struct ceph_mds_session *s = msg->con->private;
        struct ceph_auth_handshake *auth = &s->s_auth;
+
        return ceph_auth_check_message_signature(auth, msg);
 }
 
@@ -3965,8 +3967,8 @@ static const struct ceph_connection_operations mds_con_ops = {
 	.invalidate_authorizer = invalidate_authorizer,
 	.peer_reset = peer_reset,
 	.alloc_msg = mds_alloc_msg,
-	.sign_message = sign_message,
-	.check_message_signature = check_message_signature,
+	.sign_message = mds_sign_message,
+	.check_message_signature = mds_check_message_signature,
 };
 
 /* eof */
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index b2371d9b51fa..3687ff0f0133 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -43,10 +43,9 @@ struct ceph_connection_operations {
 	struct ceph_msg * (*alloc_msg) (struct ceph_connection *con,
 					struct ceph_msg_header *hdr,
 					int *skip);
-	int (*sign_message) (struct ceph_connection *con, struct ceph_msg *msg);
 
-	int (*check_message_signature) (struct ceph_connection *con,
-					struct ceph_msg *msg);
+	int (*sign_message) (struct ceph_msg *msg);
+	int (*check_message_signature) (struct ceph_msg *msg);
 };
 
 /* use format string %s%d */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index fce6ad636613..805f6f82139f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1205,7 +1205,7 @@ static void prepare_write_message_footer(struct ceph_connection *con)
 	con->out_kvec[v].iov_base = &m->footer;
 	if (con->peer_features & CEPH_FEATURE_MSG_AUTH) {
 		if (con->ops->sign_message)
-			con->ops->sign_message(con, m);
+			con->ops->sign_message(m);
 		else
 			m->footer.sig = 0;
 		con->out_kvec[v].iov_len = sizeof(m->footer);
@@ -2422,7 +2422,7 @@ static int read_partial_message(struct ceph_connection *con)
 	}
 
 	if (need_sign && con->ops->check_message_signature &&
-	    con->ops->check_message_signature(con, m)) {
+	    con->ops->check_message_signature(m)) {
 		pr_err("read_partial_message %p signature check failed\n", m);
 		return -EBADMSG;
 	}
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 191bc21cecea..118e4ce37ecc 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2979,17 +2979,19 @@ static int invalidate_authorizer(struct ceph_connection *con)
 	return ceph_monc_validate_auth(&osdc->client->monc);
 }
 
-static int sign_message(struct ceph_connection *con, struct ceph_msg *msg)
+static int osd_sign_message(struct ceph_msg *msg)
 {
-	struct ceph_osd *o = con->private;
+	struct ceph_osd *o = msg->con->private;
 	struct ceph_auth_handshake *auth = &o->o_auth;
+
 	return ceph_auth_sign_message(auth, msg);
 }
 
-static int check_message_signature(struct ceph_connection *con, struct ceph_msg *msg)
+static int osd_check_message_signature(struct ceph_msg *msg)
 {
-	struct ceph_osd *o = con->private;
+	struct ceph_osd *o = msg->con->private;
 	struct ceph_auth_handshake *auth = &o->o_auth;
+
 	return ceph_auth_check_message_signature(auth, msg);
 }
 
@@ -3001,7 +3003,7 @@ static const struct ceph_connection_operations osd_con_ops = {
 	.verify_authorizer_reply = verify_authorizer_reply,
 	.invalidate_authorizer = invalidate_authorizer,
 	.alloc_msg = alloc_msg,
-	.sign_message = sign_message,
-	.check_message_signature = check_message_signature,
+	.sign_message = osd_sign_message,
+	.check_message_signature = osd_check_message_signature,
 	.fault = osd_reset,
 };
-- 
2.4.3

