From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] ceph: Use kmemdup rather than duplicating its implementation
Date: Thu, 10 Nov 2011 19:45:21 +0100
Message-ID: <1320950721.20155.111.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www17.your-server.de ([213.133.104.17]:42853 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932429Ab1KJSp1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Nov 2011 13:45:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "David S. Miller" <davem@davemloft.net>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Use kmemdup rather than duplicating its implementation

The semantic patch that makes this change is available
in scripts/coccinelle/api/memdup.cocci.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/net/ceph/crypto.c b/net/ceph/crypto.c
--- a/net/ceph/crypto.c 2011-11-07 19:38:30.130592543 +0100
+++ b/net/ceph/crypto.c 2011-11-08 10:58:06.915274800 +0100
@@ -15,10 +15,9 @@ int ceph_crypto_key_clone(struct ceph_cr
 			  const struct ceph_crypto_key *src)
 {
 	memcpy(dst, src, sizeof(struct ceph_crypto_key));
-	dst->key = kmalloc(src->len, GFP_NOFS);
+	dst->key = kmemdup(src->key, src->len, GFP_NOFS);
 	if (!dst->key)
 		return -ENOMEM;
-	memcpy(dst->key, src->key, src->len);
 	return 0;
 }
 


