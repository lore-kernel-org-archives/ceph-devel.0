From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 05/15] libceph: rename and align ceph_x_authorizer::reply_buf
Date: Mon, 12 Dec 2016 21:48:50 +0100
Message-ID: <1481575740-1834-6-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33492 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932320AbcLLUuI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:08 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so13765299wmu.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:08 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.05
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:06 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's going to be used as a temporary buffer for in-place en/decryption
with ceph_crypt() instead of on-stack buffers, so rename to enc_buf.
Ensure alignment to avoid GFP_ATOMIC allocations in the crypto stack.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 10 +++++-----
 net/ceph/auth_x.h |  3 ++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index de30c585c2a2..ef1423294517 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -603,8 +603,8 @@ static int ceph_x_create_authorizer(
 	auth->authorizer = (struct ceph_authorizer *) au;
 	auth->authorizer_buf = au->buf->vec.iov_base;
 	auth->authorizer_buf_len = au->buf->vec.iov_len;
-	auth->authorizer_reply_buf = au->reply_buf;
-	auth->authorizer_reply_buf_len = sizeof (au->reply_buf);
+	auth->authorizer_reply_buf = au->enc_buf;
+	auth->authorizer_reply_buf_len = CEPHX_AU_ENC_BUF_LEN;
 	auth->sign_message = ac->ops->sign_message;
 	auth->check_message_signature = ac->ops->check_message_signature;
 
@@ -638,10 +638,10 @@ static int ceph_x_verify_authorizer_reply(struct ceph_auth_client *ac,
 	int ret = 0;
 	struct ceph_x_authorize_reply reply;
 	void *preply = &reply;
-	void *p = au->reply_buf;
-	void *end = p + sizeof(au->reply_buf);
+	void *p = au->enc_buf;
 
-	ret = ceph_x_decrypt(&au->session_key, &p, end, &preply, sizeof(reply));
+	ret = ceph_x_decrypt(&au->session_key, &p, p + CEPHX_AU_ENC_BUF_LEN,
+			     &preply, sizeof(reply));
 	if (ret < 0)
 		return ret;
 	if (ret != sizeof(reply))
diff --git a/net/ceph/auth_x.h b/net/ceph/auth_x.h
index 21a5af904bae..48e9ad41bd2a 100644
--- a/net/ceph/auth_x.h
+++ b/net/ceph/auth_x.h
@@ -24,6 +24,7 @@ struct ceph_x_ticket_handler {
 	unsigned long renew_after, expires;
 };
 
+#define CEPHX_AU_ENC_BUF_LEN	128  /* big enough for encrypted blob */
 
 struct ceph_x_authorizer {
 	struct ceph_authorizer base;
@@ -32,7 +33,7 @@ struct ceph_x_authorizer {
 	unsigned int service;
 	u64 nonce;
 	u64 secret_id;
-	char reply_buf[128];  /* big enough for encrypted blob */
+	char enc_buf[CEPHX_AU_ENC_BUF_LEN] __aligned(8);
 };
 
 struct ceph_x_info {
-- 
2.4.3

