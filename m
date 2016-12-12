From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 10/15] libceph: uninline ceph_crypto_key_destroy()
Date: Mon, 12 Dec 2016 21:48:55 +0100
Message-ID: <1481575740-1834-11-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35035 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932510AbcLLUuN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:13 -0500
Received: by mail-wj0-f196.google.com with SMTP id he10so13560193wjc.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:12 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.11
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:11 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/crypto.c | 8 ++++++++
 net/ceph/crypto.h | 9 +--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 38936e1fd644..c4d8f68e0b18 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -80,6 +80,14 @@ int ceph_crypto_key_unarmor(struct ceph_crypto_key *key, const char *inkey)
 	return 0;
 }
 
+void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
+{
+	if (key) {
+		kfree(key->key);
+		key->key = NULL;
+	}
+}
+
 static struct crypto_skcipher *ceph_crypto_alloc_cipher(void)
 {
 	return crypto_alloc_skcipher("cbc(aes)", 0, CRYPTO_ALG_ASYNC);
diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
index c33bcafd3829..c4211590b721 100644
--- a/net/ceph/crypto.h
+++ b/net/ceph/crypto.h
@@ -14,19 +14,12 @@ struct ceph_crypto_key {
 	void *key;
 };
 
-static inline void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
-{
-	if (key) {
-		kfree(key->key);
-		key->key = NULL;
-	}
-}
-
 int ceph_crypto_key_clone(struct ceph_crypto_key *dst,
 			  const struct ceph_crypto_key *src);
 int ceph_crypto_key_encode(struct ceph_crypto_key *key, void **p, void *end);
 int ceph_crypto_key_decode(struct ceph_crypto_key *key, void **p, void *end);
 int ceph_crypto_key_unarmor(struct ceph_crypto_key *key, const char *in);
+void ceph_crypto_key_destroy(struct ceph_crypto_key *key);
 
 /* crypto.c */
 int ceph_crypt(const struct ceph_crypto_key *key, bool encrypt,
-- 
2.4.3

