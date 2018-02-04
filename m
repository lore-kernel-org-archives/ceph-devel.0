From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH 1/2] ceph: avoid NULL pointer dereference in
 ceph_crypto_key_destroy()
Date: Sun, 04 Feb 2018 18:08:48 +0800
Message-ID: <1517738929-229785-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp003.me.com ([17.110.69.254]:36426 "EHLO
        mr11p00im-asmtp003.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBDKJk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Feb 2018 05:09:40 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp003.me.com by
 mr11p00im-asmtp003.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3M00600EJN9D00@mr11p00im-asmtp003.me.com> for
 ceph-devel@vger.kernel.org; Sun, 04 Feb 2018 10:09:27 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, idryomov@gmail.com, Chengguang Xu <cgxu519@icloud.com>

There are many reasons of failure from get_secret(),
so it's necessary to add a check before calling crypto_free_skcipher()
in case of NULL pointer dereference.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 net/ceph/crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index bf9d079..bb1dc2d 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -136,8 +136,10 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
 	if (key) {
 		kfree(key->key);
 		key->key = NULL;
-		crypto_free_skcipher(key->tfm);
-		key->tfm = NULL;
+		if (key->tfm) {
+			crypto_free_skcipher(key->tfm);
+			key->tfm = NULL;
+		}
 	}
 }
 
-- 
1.8.3.1

