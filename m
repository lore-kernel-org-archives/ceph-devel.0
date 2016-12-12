From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 14/15] libceph: drop len argument of *verify_authorizer_reply()
Date: Mon, 12 Dec 2016 21:48:59 +0100
Message-ID: <1481575740-1834-15-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34914 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbcLLUuR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so13798986wme.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:16 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.14
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:14 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The length of the reply is protocol-dependent - for cephx it's
ceph_x_authorize_reply.  Nothing sensible can be passed from the
messenger layer anyway.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/mds_client.c           | 4 ++--
 include/linux/ceph/auth.h      | 5 ++---
 include/linux/ceph/messenger.h | 2 +-
 net/ceph/auth.c                | 4 ++--
 net/ceph/auth_x.c              | 2 +-
 net/ceph/messenger.c           | 2 +-
 net/ceph/osd_client.c          | 4 ++--
 7 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 815acd1a56d4..bf4d3d26850c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3943,13 +3943,13 @@ static struct ceph_auth_handshake *get_authorizer(struct ceph_connection *con,
 }
 
 
-static int verify_authorizer_reply(struct ceph_connection *con, int len)
+static int verify_authorizer_reply(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
 	struct ceph_auth_client *ac = mdsc->fsc->client->monc.auth;
 
-	return ceph_auth_verify_authorizer_reply(ac, s->s_auth.authorizer, len);
+	return ceph_auth_verify_authorizer_reply(ac, s->s_auth.authorizer);
 }
 
 static int invalidate_authorizer(struct ceph_connection *con)
diff --git a/include/linux/ceph/auth.h b/include/linux/ceph/auth.h
index 374bb1c4ef52..a6747789fe5c 100644
--- a/include/linux/ceph/auth.h
+++ b/include/linux/ceph/auth.h
@@ -64,7 +64,7 @@ struct ceph_auth_client_ops {
 	int (*update_authorizer)(struct ceph_auth_client *ac, int peer_type,
 				 struct ceph_auth_handshake *auth);
 	int (*verify_authorizer_reply)(struct ceph_auth_client *ac,
-				       struct ceph_authorizer *a, size_t len);
+				       struct ceph_authorizer *a);
 	void (*invalidate_authorizer)(struct ceph_auth_client *ac,
 				      int peer_type);
 
@@ -118,8 +118,7 @@ extern int ceph_auth_update_authorizer(struct ceph_auth_client *ac,
 				       int peer_type,
 				       struct ceph_auth_handshake *a);
 extern int ceph_auth_verify_authorizer_reply(struct ceph_auth_client *ac,
-					     struct ceph_authorizer *a,
-					     size_t len);
+					     struct ceph_authorizer *a);
 extern void ceph_auth_invalidate_authorizer(struct ceph_auth_client *ac,
 					    int peer_type);
 
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 8dbd7879fdc6..531f2d882bd9 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -30,7 +30,7 @@ struct ceph_connection_operations {
 	struct ceph_auth_handshake *(*get_authorizer) (
 				struct ceph_connection *con,
 			       int *proto, int force_new);
-	int (*verify_authorizer_reply) (struct ceph_connection *con, int len);
+	int (*verify_authorizer_reply) (struct ceph_connection *con);
 	int (*invalidate_authorizer)(struct ceph_connection *con);
 
 	/* there was some error on the socket (disconnect, whatever) */
diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index c822b3ae1bd3..48bb8d95195b 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -315,13 +315,13 @@ int ceph_auth_update_authorizer(struct ceph_auth_client *ac,
 EXPORT_SYMBOL(ceph_auth_update_authorizer);
 
 int ceph_auth_verify_authorizer_reply(struct ceph_auth_client *ac,
-				      struct ceph_authorizer *a, size_t len)
+				      struct ceph_authorizer *a)
 {
 	int ret = 0;
 
 	mutex_lock(&ac->mutex);
 	if (ac->ops && ac->ops->verify_authorizer_reply)
-		ret = ac->ops->verify_authorizer_reply(ac, a, len);
+		ret = ac->ops->verify_authorizer_reply(ac, a);
 	mutex_unlock(&ac->mutex);
 	return ret;
 }
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index b216131915e7..2034fb926670 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -623,7 +623,7 @@ static int ceph_x_update_authorizer(
 }
 
 static int ceph_x_verify_authorizer_reply(struct ceph_auth_client *ac,
-					  struct ceph_authorizer *a, size_t len)
+					  struct ceph_authorizer *a)
 {
 	struct ceph_x_authorizer *au = (void *)a;
 	void *p = au->enc_buf;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2efb335deada..dba380429a05 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2033,7 +2033,7 @@ static int process_connect(struct ceph_connection *con)
 		 * should also define ->verify_authorizer_reply().
 		 * See get_connect_authorizer().
 		 */
-		ret = con->ops->verify_authorizer_reply(con, 0);
+		ret = con->ops->verify_authorizer_reply(con);
 		if (ret < 0) {
 			con->error_msg = "bad authorize reply";
 			return ret;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e6ae15bc41b7..5d812a26f05a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4478,13 +4478,13 @@ static struct ceph_auth_handshake *get_authorizer(struct ceph_connection *con,
 }
 
 
-static int verify_authorizer_reply(struct ceph_connection *con, int len)
+static int verify_authorizer_reply(struct ceph_connection *con)
 {
 	struct ceph_osd *o = con->private;
 	struct ceph_osd_client *osdc = o->o_osdc;
 	struct ceph_auth_client *ac = osdc->client->monc.auth;
 
-	return ceph_auth_verify_authorizer_reply(ac, o->o_auth.authorizer, len);
+	return ceph_auth_verify_authorizer_reply(ac, o->o_auth.authorizer);
 }
 
 static int invalidate_authorizer(struct ceph_connection *con)
-- 
2.4.3

