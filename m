From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 62/94] libceph: don't call crypto_free_sync_skcipher() on a NULL tfm
Date: Wed,  4 Sep 2019 11:57:07 -0400
Message-ID: <20190904155739.2816-62-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org, netdev@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit e8c99200b4d117c340c392ebd5e62d85dfeed027 ]

In set_secret(), key->tfm is assigned to NULL on line 55, and then
ceph_crypto_key_destroy(key) is executed.

ceph_crypto_key_destroy(key)
  crypto_free_sync_skcipher(key->tfm)
    crypto_free_skcipher(&tfm->base);

This happens to work because crypto_sync_skcipher is a trivial wrapper
around crypto_skcipher: &tfm->base is still 0 and crypto_free_skcipher()
handles that.  Let's not rely on the layout of crypto_sync_skcipher.

This bug is found by a static analysis tool STCheck written by us.

Fixes: 69d6302b65a8 ("libceph: Remove VLA usage of skcipher").
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 5d6724cee38f9..4f75df40fb121 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -136,8 +136,10 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
 	if (key) {
 		kfree(key->key);
 		key->key = NULL;
-		crypto_free_sync_skcipher(key->tfm);
-		key->tfm = NULL;
+		if (key->tfm) {
+			crypto_free_sync_skcipher(key->tfm);
+			key->tfm = NULL;
+		}
 	}
 }
 
-- 
2.20.1
