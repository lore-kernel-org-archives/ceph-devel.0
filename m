From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: introduce ceph_x_authorizer_cleanup()
Date: Mon, 26 Oct 2015 13:03:26 +0100
Message-ID: <1445861006-5324-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36100 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbbJZKYJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 06:24:09 -0400
Received: by wicfx6 with SMTP id fx6so106730354wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2015 03:24:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

Commit ae385eaf24dc ("libceph: store session key in cephx authorizer")
introduced ceph_x_authorizer::session_key, but didn't update all the
exit/error paths.  Introduce ceph_x_authorizer_cleanup() to encapsulate
ceph_x_authorizer cleanup and switch to it.  This fixes ceph_x_destroy(),
which currently always leaks key and ceph_x_build_authorizer() error
paths.

Cc: Yan, Zheng <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 28 +++++++++++++++++-----------
 net/ceph/crypto.h |  4 +++-
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index ba6eb17226da..65054fd31b97 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -279,6 +279,15 @@ bad:
 	return -EINVAL;
 }
 
+static void ceph_x_authorizer_cleanup(struct ceph_x_authorizer *au)
+{
+	ceph_crypto_key_destroy(&au->session_key);
+	if (au->buf) {
+		ceph_buffer_put(au->buf);
+		au->buf = NULL;
+	}
+}
+
 static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 				   struct ceph_x_ticket_handler *th,
 				   struct ceph_x_authorizer *au)
@@ -297,7 +306,7 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	ceph_crypto_key_destroy(&au->session_key);
 	ret = ceph_crypto_key_clone(&au->session_key, &th->session_key);
 	if (ret)
-		return ret;
+		goto out_au;
 
 	maxlen = sizeof(*msg_a) + sizeof(msg_b) +
 		ceph_x_encrypt_buflen(ticket_blob_len);
@@ -309,8 +318,8 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	if (!au->buf) {
 		au->buf = ceph_buffer_new(maxlen, GFP_NOFS);
 		if (!au->buf) {
-			ceph_crypto_key_destroy(&au->session_key);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out_au;
 		}
 	}
 	au->service = th->service;
@@ -340,7 +349,7 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	ret = ceph_x_encrypt(&au->session_key, &msg_b, sizeof(msg_b),
 			     p, end - p);
 	if (ret < 0)
-		goto out_buf;
+		goto out_au;
 	p += ret;
 	au->buf->vec.iov_len = p - au->buf->vec.iov_base;
 	dout(" built authorizer nonce %llx len %d\n", au->nonce,
@@ -348,9 +357,8 @@ static int ceph_x_build_authorizer(struct ceph_auth_client *ac,
 	BUG_ON(au->buf->vec.iov_len > maxlen);
 	return 0;
 
-out_buf:
-	ceph_buffer_put(au->buf);
-	au->buf = NULL;
+out_au:
+	ceph_x_authorizer_cleanup(au);
 	return ret;
 }
 
@@ -624,8 +632,7 @@ static void ceph_x_destroy_authorizer(struct ceph_auth_client *ac,
 {
 	struct ceph_x_authorizer *au = (void *)a;
 
-	ceph_crypto_key_destroy(&au->session_key);
-	ceph_buffer_put(au->buf);
+	ceph_x_authorizer_cleanup(au);
 	kfree(au);
 }
 
@@ -653,8 +660,7 @@ static void ceph_x_destroy(struct ceph_auth_client *ac)
 		remove_ticket_handler(ac, th);
 	}
 
-	if (xi->auth_authorizer.buf)
-		ceph_buffer_put(xi->auth_authorizer.buf);
+	ceph_x_authorizer_cleanup(&xi->auth_authorizer);
 
 	kfree(ac->private);
 	ac->private = NULL;
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index d1498224c49d..2e9cab09f37b 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -16,8 +16,10 @@ struct ceph_crypto_key {
 
 static inline void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
 {
-	if (key)
+	if (key) {
 		kfree(key->key);
+		key->key = NULL;
+	}
 }
 
 int ceph_crypto_key_clone(struct ceph_crypto_key *dst,
-- 
2.4.3

