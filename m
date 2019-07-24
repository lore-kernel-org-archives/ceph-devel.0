From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: ceph: Fix a possible null-pointer dereference in ceph_crypto_key_destroy()
Date: Wed, 24 Jul 2019 17:43:06 +0800
Message-ID: <20190724094306.1866-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: idryomov@gmail.com, jlayton@kernel.org, sage@redhat.com, davem@davemloft.net
Cc: ceph-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: ceph-devel.vger.kernel.org

In set_secret(), key->tfm is assigned to NULL on line 55, and then
ceph_crypto_key_destroy(key) is executed.

ceph_crypto_key_destroy(key)
    crypto_free_sync_skcipher(key->tfm)
        crypto_skcipher_tfm(tfm)
            return &tfm->base;

Thus, a possible null-pointer dereference may occur.

To fix this bug, key->tfm is checked before calling
crypto_free_sync_skcipher().

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/ceph/crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 5d6724cee38f..ac28463bcfd8 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -136,7 +136,8 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
 	if (key) {
 		kfree(key->key);
 		key->key = NULL;
-		crypto_free_sync_skcipher(key->tfm);
+		if (key->tfm)
+			crypto_free_sync_skcipher(key->tfm);
 		key->tfm = NULL;
 	}
 }
-- 
2.17.0
