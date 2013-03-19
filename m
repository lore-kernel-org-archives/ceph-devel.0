From: Sage Weil <sage@inktank.com>
Subject: [PATCH 3/6] libceph: add update_authorizer auth method
Date: Tue, 19 Mar 2013 16:08:03 -0700
Message-ID: <1363734486-26879-3-git-send-email-sage@inktank.com>
References: <1363734486-26879-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54523 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab3CSXIK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 19:08:10 -0400
In-Reply-To: <1363734486-26879-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Currently the messenger calls out to a get_authorizer con op, which will
create a new authorizer if it doesn't yet have one.  In the meantime, when
we rotate our service keys, the authorizer doesn't get updated.  Eventually
it will be rejected by the server on a new connection attempt and get
invalidated, and we will then rebuild a new authorizer, but this is not
ideal.

Instead, if we do have an authorizer, call a new update_authorizer op that
will verify that the current authorizer is using the latest secret.  If it
is not, we will build a new one that does.  This avoids the transient
failure.

This fixes one of the sorry sequence of events for bug

	http://tracker.ceph.com/issues/4282

Signed-off-by: Sage Weil <sage@inktank.com>
---
 fs/ceph/mds_client.c      |    7 ++++++-
 include/linux/ceph/auth.h |    3 +++
 net/ceph/auth_x.c         |   23 +++++++++++++++++++++++
 net/ceph/auth_x.h         |    1 +
 net/ceph/osd_client.c     |    5 +++++
 5 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 06ea2ca..75cca49 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3445,7 +3445,12 @@ static struct ceph_auth_handshake *get_authorizer(struct ceph_connection *con,
 	}
 	if (!auth->authorizer && ac->ops && ac->ops->create_authorizer) {
 		int ret = ac->ops->create_authorizer(ac, CEPH_ENTITY_TYPE_MDS,
-							auth);
+						     auth);
+		if (ret)
+			return ERR_PTR(ret);
+	} else if (ac->ops && ac->ops_update_authorizer) {
+		int ret = ac->ops->update_authorizer(ac, CEPH_ENTITY_TYPE_MDS,
+						     auth);
 		if (ret)
 			return ERR_PTR(ret);
 	}
diff --git a/include/linux/ceph/auth.h b/include/linux/ceph/auth.h
index d4080f3..73e973e 100644
--- a/include/linux/ceph/auth.h
+++ b/include/linux/ceph/auth.h
@@ -52,6 +52,9 @@ struct ceph_auth_client_ops {
 	 */
 	int (*create_authorizer)(struct ceph_auth_client *ac, int peer_type,
 				 struct ceph_auth_handshake *auth);
+	/* ensure that an existing authorizer is up to date */
+	int (*update_authorizer)(struct ceph_auth_client *ac, int peer_type,
+				 struct ceph_auth_handshake *auth);
 	int (*verify_authorizer_reply)(struct ceph_auth_client *ac,
 				       struct ceph_authorizer *a, size_t len);
 	void (*destroy_authorizer)(struct ceph_auth_client *ac,
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index bd8758d..2d59815 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -298,6 +298,7 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 			return -ENOMEM;
 	}
 	au->service = th->service;
+	au->secret_id = th->secret_id;
 
 	msg_a = au->buf->vec.iov_base;
 	msg_a->struct_v = 1;
@@ -555,6 +556,27 @@ static int ceph_x_create_authorizer(
 	return 0;
 }
 
+static int ceph_x_update_authorizer(
+	struct ceph_auth_client *ac, int peer_type,
+	struct ceph_auth_handshake *auth)
+{
+	struct ceph_x_authorizer *au;
+	struct ceph_x_ticket_handler *th;
+	int ret;
+
+	th = get_ticket_handler(ac, peer_type);
+	if (IS_ERR(th))
+		return PTR_ERR(th);
+
+	au = (struct ceph_x_authorizer *)auth->authorizer;
+	if (au->secret_id < th->secret_id) {
+		dout("ceph_x_update_authorizer service %u secret %llu < %llu\n",
+		     au->service, au->secret_id, th->secret_id);
+		return ceph_x_build_authorizer(ac, th, au);
+	}
+	return 0;
+}
+
 static int ceph_x_verify_authorizer_reply(struct ceph_auth_client *ac,
 					  struct ceph_authorizer *a, size_t len)
 {
@@ -641,6 +663,7 @@ static const struct ceph_auth_client_ops ceph_x_ops = {
 	.build_request = ceph_x_build_request,
 	.handle_reply = ceph_x_handle_reply,
 	.create_authorizer = ceph_x_create_authorizer,
+	.update_authorizer = ceph_x_update_authorizer,
 	.verify_authorizer_reply = ceph_x_verify_authorizer_reply,
 	.destroy_authorizer = ceph_x_destroy_authorizer,
 	.invalidate_authorizer = ceph_x_invalidate_authorizer,
diff --git a/net/ceph/auth_x.h b/net/ceph/auth_x.h
index f459e93..c5a058d 100644
--- a/net/ceph/auth_x.h
+++ b/net/ceph/auth_x.h
@@ -29,6 +29,7 @@ struct ceph_x_authorizer {
 	struct ceph_buffer *buf;
 	unsigned int service;
 	u64 nonce;
+	u64 secret_id;
 	char reply_buf[128];  /* big enough for encrypted blob */
 };
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index cb14db8..5ef24e3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2220,6 +2220,11 @@ static struct ceph_auth_handshake *get_authorizer(struct ceph_connection *con,
 							auth);
 		if (ret)
 			return ERR_PTR(ret);
+	} else if (ac->ops && ac->ops->update_authorizer) {
+		int ret = ac->ops->update_authorizer(ac, CEPH_ENTITY_TYPE_OSD,
+						     auth);
+		if (ret)
+			return ERR_PTR(ret);
 	}
 	*proto = ac->protocol;
 
-- 
1.7.9.5

