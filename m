From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/2] libceph: message signature support
Date: Tue,  4 Nov 2014 17:04:52 +0800
Message-ID: <1415091892-2086-2-git-send-email-zyan@redhat.com>
References: <1415091892-2086-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49875 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbaKDJFY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Nov 2014 04:05:24 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sA495N3i029422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 4 Nov 2014 04:05:24 -0500
In-Reply-To: <1415091892-2086-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/mds_client.c               | 16 +++++++++++
 include/linux/ceph/auth.h          | 26 +++++++++++++++++
 include/linux/ceph/ceph_features.h |  1 +
 include/linux/ceph/messenger.h     |  9 +++++-
 include/linux/ceph/msgr.h          |  8 ++++++
 net/ceph/auth_x.c                  | 58 ++++++++++++++++++++++++++++++++++++++
 net/ceph/messenger.c               | 32 +++++++++++++++++++--
 net/ceph/osd_client.c              | 16 +++++++++++
 8 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2eab332..14ca763 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3668,6 +3668,20 @@ static struct ceph_msg *mds_alloc_msg(struct ceph_connection *con,
 	return msg;
 }
 
+static int sign_message(struct ceph_connection *con, struct ceph_msg *msg)
+{
+       struct ceph_mds_session *s = con->private;
+       struct ceph_auth_handshake *auth = &s->s_auth;
+       return ceph_auth_sign_message(auth, msg);
+}
+
+static int check_message_signature(struct ceph_connection *con, struct ceph_msg *msg)
+{
+       struct ceph_mds_session *s = con->private;
+       struct ceph_auth_handshake *auth = &s->s_auth;
+       return ceph_auth_check_message_signature(auth, msg);
+}
+
 static const struct ceph_connection_operations mds_con_ops = {
 	.get = con_get,
 	.put = con_put,
@@ -3677,6 +3691,8 @@ static const struct ceph_connection_operations mds_con_ops = {
 	.invalidate_authorizer = invalidate_authorizer,
 	.peer_reset = peer_reset,
 	.alloc_msg = mds_alloc_msg,
+	.sign_message = sign_message,
+	.check_message_signature = check_message_signature,
 };
 
 /* eof */
diff --git a/include/linux/ceph/auth.h b/include/linux/ceph/auth.h
index 5f33868..260d78b 100644
--- a/include/linux/ceph/auth.h
+++ b/include/linux/ceph/auth.h
@@ -13,6 +13,7 @@
 
 struct ceph_auth_client;
 struct ceph_authorizer;
+struct ceph_msg;
 
 struct ceph_auth_handshake {
 	struct ceph_authorizer *authorizer;
@@ -20,6 +21,10 @@ struct ceph_auth_handshake {
 	size_t authorizer_buf_len;
 	void *authorizer_reply_buf;
 	size_t authorizer_reply_buf_len;
+	int (*sign_message)(struct ceph_auth_handshake *auth,
+			    struct ceph_msg *msg);
+	int (*check_message_signature)(struct ceph_auth_handshake *auth,
+				       struct ceph_msg *msg);
 };
 
 struct ceph_auth_client_ops {
@@ -66,6 +71,11 @@ struct ceph_auth_client_ops {
 	void (*reset)(struct ceph_auth_client *ac);
 
 	void (*destroy)(struct ceph_auth_client *ac);
+
+	int (*sign_message)(struct ceph_auth_handshake *auth,
+			    struct ceph_msg *msg);
+	int (*check_message_signature)(struct ceph_auth_handshake *auth,
+				       struct ceph_msg *msg);
 };
 
 struct ceph_auth_client {
@@ -113,4 +123,20 @@ extern int ceph_auth_verify_authorizer_reply(struct ceph_auth_client *ac,
 extern void ceph_auth_invalidate_authorizer(struct ceph_auth_client *ac,
 					    int peer_type);
 
+static inline int ceph_auth_sign_message(struct ceph_auth_handshake *auth,
+					 struct ceph_msg *msg)
+{
+	if (auth->sign_message)
+		return auth->sign_message(auth, msg);
+	return 0;
+}
+
+static inline
+int ceph_auth_check_message_signature(struct ceph_auth_handshake *auth,
+				      struct ceph_msg *msg)
+{
+	if (auth->check_message_signature)
+		return auth->check_message_signature(auth, msg);
+	return 0;
+}
 #endif
diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index d12659c..71e05bb 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -84,6 +84,7 @@ static inline u64 ceph_sanitize_features(u64 features)
 	 CEPH_FEATURE_PGPOOL3 |			\
 	 CEPH_FEATURE_OSDENC |			\
 	 CEPH_FEATURE_CRUSH_TUNABLES |		\
+	 CEPH_FEATURE_MSG_AUTH |		\
 	 CEPH_FEATURE_CRUSH_TUNABLES2 |		\
 	 CEPH_FEATURE_REPLY_CREATE_INODE |	\
 	 CEPH_FEATURE_OSDHASHPSPOOL |		\
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 40ae58e..d9d396c 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -42,6 +42,10 @@ struct ceph_connection_operations {
 	struct ceph_msg * (*alloc_msg) (struct ceph_connection *con,
 					struct ceph_msg_header *hdr,
 					int *skip);
+	int (*sign_message) (struct ceph_connection *con, struct ceph_msg *msg);
+
+	int (*check_message_signature) (struct ceph_connection *con,
+					struct ceph_msg *msg);
 };
 
 /* use format string %s%d */
@@ -142,7 +146,10 @@ struct ceph_msg_data_cursor {
  */
 struct ceph_msg {
 	struct ceph_msg_header hdr;	/* header */
-	struct ceph_msg_footer footer;	/* footer */
+	union {
+		struct ceph_msg_footer footer;		/* footer */
+		struct ceph_msg_footer_old old_footer;	/* old format footer */
+	};
 	struct kvec front;              /* unaligned blobs of message */
 	struct ceph_buffer *middle;
 
diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
index 3d94a73..cac4b28 100644
--- a/include/linux/ceph/msgr.h
+++ b/include/linux/ceph/msgr.h
@@ -164,13 +164,21 @@ struct ceph_msg_header {
 /*
  * follows data payload
  */
+struct ceph_msg_footer_old {
+	__le32 front_crc, middle_crc, data_crc;
+	__u8 flags;
+} __attribute__ ((packed));
+
 struct ceph_msg_footer {
 	__le32 front_crc, middle_crc, data_crc;
+	// sig holds the 64 bits of the digital signature for the message PLR
+	__le64  sig;
 	__u8 flags;
 } __attribute__ ((packed));
 
 #define CEPH_MSG_FOOTER_COMPLETE  (1<<0)   /* msg wasn't aborted */
 #define CEPH_MSG_FOOTER_NOCRC     (1<<1)   /* no data crc */
+#define CEPH_MSG_FOOTER_SIGNED	  (1<<2)   /* msg was signed */
 
 
 #endif
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 8da8568..9cd1823 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -8,6 +8,7 @@
 
 #include <linux/ceph/decode.h>
 #include <linux/ceph/auth.h>
+#include <linux/ceph/messenger.h>
 
 #include "crypto.h"
 #include "auth_x.h"
@@ -572,6 +573,8 @@ static int ceph_x_create_authorizer(
 	auth->authorizer_buf_len = au->buf->vec.iov_len;
 	auth->authorizer_reply_buf = au->reply_buf;
 	auth->authorizer_reply_buf_len = sizeof (au->reply_buf);
+	auth->sign_message = ac->ops->sign_message;
+	auth->check_message_signature = ac->ops->check_message_signature;
 
 	return 0;
 }
@@ -672,6 +675,59 @@ static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
 		memset(&th->validity, 0, sizeof(th->validity));
 }
 
+static int calcu_signature(struct ceph_x_authorizer *au,
+			   struct ceph_msg *msg, __le64 *sig)
+{
+	int ret;
+	char tmp_enc[40];
+	__le32 tmp[5] = {
+		16, msg->hdr.crc, msg->footer.front_crc,
+		msg->footer.middle_crc, msg->footer.data_crc,
+	};
+	ret = ceph_x_encrypt(&au->session_key, &tmp, sizeof(tmp),
+			     tmp_enc, sizeof(tmp_enc));
+	if (ret < 0)
+		return ret;
+	*sig = *(__le64*)(tmp_enc + 4);
+	return 0;
+}
+
+static int ceph_x_sign_message(struct ceph_auth_handshake *auth,
+			       struct ceph_msg *msg)
+{
+	int ret;
+	if (!auth->authorizer)
+		return 0;
+	ret = calcu_signature((struct ceph_x_authorizer *)auth->authorizer,
+			      msg, &msg->footer.sig);
+	if (ret < 0)
+		return ret;
+	msg->footer.flags |= CEPH_MSG_FOOTER_SIGNED;
+	return 0;
+}
+
+static int ceph_x_check_message_signature(struct ceph_auth_handshake *auth,
+					  struct ceph_msg *msg)
+{
+	__le64 sig_check;
+	int ret;
+
+	if (!auth->authorizer)
+		return 0;
+	ret = calcu_signature((struct ceph_x_authorizer *)auth->authorizer,
+			      msg, &sig_check);
+	if (ret < 0)
+		return ret;
+	if (sig_check == msg->footer.sig)
+		return 0;
+	if (msg->footer.flags & CEPH_MSG_FOOTER_SIGNED)
+		dout("ceph_x_check_message_signature %p has signature %llx "
+		     "expect %llx\n", msg, msg->footer.sig, sig_check);
+	else
+		dout("ceph_x_check_message_signature %p sender did not set "
+		     "CEPH_MSG_FOOTER_SIGNED\n", msg);
+	return -EBADMSG;
+}
 
 static const struct ceph_auth_client_ops ceph_x_ops = {
 	.name = "x",
@@ -686,6 +742,8 @@ static const struct ceph_auth_client_ops ceph_x_ops = {
 	.invalidate_authorizer = ceph_x_invalidate_authorizer,
 	.reset =  ceph_x_reset,
 	.destroy = ceph_x_destroy,
+	.sign_message = ceph_x_sign_message,
+	.check_message_signature = ceph_x_check_message_signature,
 };
 
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index b2f571d..83b6163 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1189,8 +1189,18 @@ static void prepare_write_message_footer(struct ceph_connection *con)
 	dout("prepare_write_message_footer %p\n", con);
 	con->out_kvec_is_msg = true;
 	con->out_kvec[v].iov_base = &m->footer;
-	con->out_kvec[v].iov_len = sizeof(m->footer);
-	con->out_kvec_bytes += sizeof(m->footer);
+	if (con->peer_features & CEPH_FEATURE_MSG_AUTH) {
+		if (con->ops->sign_message)
+			con->ops->sign_message(con, m);
+		else
+			m->footer.sig = 0;
+		con->out_kvec[v].iov_len = sizeof(m->footer);
+		con->out_kvec_bytes += sizeof(m->footer);
+	} else {
+		m->old_footer.flags = m->footer.flags;
+		con->out_kvec[v].iov_len = sizeof(m->old_footer);
+		con->out_kvec_bytes += sizeof(m->old_footer);
+	}
 	con->out_kvec_left++;
 	con->out_more = m->more_to_follow;
 	con->out_msg_done = true;
@@ -2242,6 +2252,7 @@ static int read_partial_message(struct ceph_connection *con)
 	int ret;
 	unsigned int front_len, middle_len, data_len;
 	bool do_datacrc = !con->msgr->nocrc;
+	bool need_sign = (con->peer_features & CEPH_FEATURE_MSG_AUTH);
 	u64 seq;
 	u32 crc;
 
@@ -2354,12 +2365,21 @@ static int read_partial_message(struct ceph_connection *con)
 	}
 
 	/* footer */
-	size = sizeof (m->footer);
+	if (need_sign)
+		size = sizeof(m->footer);
+	else
+		size = sizeof(m->old_footer);
+
 	end += size;
 	ret = read_partial(con, end, size, &m->footer);
 	if (ret <= 0)
 		return ret;
 
+	if (!need_sign) {
+		m->footer.flags = m->old_footer.flags;
+		m->footer.sig = 0;
+	}
+
 	dout("read_partial_message got msg %p %d (%u) + %d (%u) + %d (%u)\n",
 	     m, front_len, m->footer.front_crc, middle_len,
 	     m->footer.middle_crc, data_len, m->footer.data_crc);
@@ -2383,6 +2403,12 @@ static int read_partial_message(struct ceph_connection *con)
 		return -EBADMSG;
 	}
 
+	if (need_sign && con->ops->check_message_signature &&
+	    con->ops->check_message_signature(con, m)) {
+		pr_err("read_partial_message %p signature check failed\n", m);
+		return -EBADMSG;
+	}
+
 	return 1; /* done! */
 }
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 30f6faf..ee28db3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2937,6 +2937,20 @@ static int invalidate_authorizer(struct ceph_connection *con)
 	return ceph_monc_validate_auth(&osdc->client->monc);
 }
 
+static int sign_message(struct ceph_connection *con, struct ceph_msg *msg)
+{
+	struct ceph_osd *o = con->private;
+	struct ceph_auth_handshake *auth = &o->o_auth;
+	return ceph_auth_sign_message(auth, msg);
+}
+
+static int check_message_signature(struct ceph_connection *con, struct ceph_msg *msg)
+{
+	struct ceph_osd *o = con->private;
+	struct ceph_auth_handshake *auth = &o->o_auth;
+	return ceph_auth_check_message_signature(auth, msg);
+}
+
 static const struct ceph_connection_operations osd_con_ops = {
 	.get = get_osd_con,
 	.put = put_osd_con,
@@ -2945,5 +2959,7 @@ static const struct ceph_connection_operations osd_con_ops = {
 	.verify_authorizer_reply = verify_authorizer_reply,
 	.invalidate_authorizer = invalidate_authorizer,
 	.alloc_msg = alloc_msg,
+	.sign_message = sign_message,
+	.check_message_signature = check_message_signature,
 	.fault = osd_reset,
 };
-- 
1.9.3

