From: Wido den Hollander <wido@widodh.nl>
Subject: PATCH: Auth: Make a correct cast
Date: Sat, 31 Jul 2010 11:29:58 +0200
Message-ID: <1280568598.2116.5.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-PCMg5KetEQVIyiTYjc80"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:59819 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0GaJaA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Jul 2010 05:30:00 -0400
Received: from [79.99.132.153] (unknown [79.99.132.153])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id 03DD53FC5C
	for <ceph-devel@vger.kernel.org>; Sat, 31 Jul 2010 11:29:58 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-PCMg5KetEQVIyiTYjc80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Commit 8b8fd7e9c22153024b1ce1438b8737b37df6f3aa introduced a compile
issue under Ubuntu 10.04 AMD64 (Don't know what other platforms did).

CEPH_AES_IV is not casted correctly, which causes the compile to fail:

g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64
-D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT librados_a-Crypto.o -MD
-MP -MF .deps/librados_a-Crypto.Tpo -c -o librados_a-Crypto.o `test -f
'auth/Crypto.cc' || echo './'`auth/Crypto.cc
auth/Crypto.cc:110: error: invalid conversion from ‘const char*’ to
‘const unsigned char*’
make: *** [librados_a-Crypto.o] Error 1

The attached patch makes a correct cast and makes it compile correctly.

Wido

--=-PCMg5KetEQVIyiTYjc80
Content-Disposition: attachment; filename="0001-auth-Make-a-correct-cast.patch"
Content-Type: text/x-patch; name="0001-auth-Make-a-correct-cast.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From bdb0acaaeb03bfc39e0dfab276e693b2f2e7c1c1 Mon Sep 17 00:00:00 2001
From: Wido den Hollander <wido@widodh.nl>
Date: Sat, 31 Jul 2010 11:27:24 +0200
Subject: [PATCH] auth: Make a correct cast

---
 src/auth/Crypto.cc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/auth/Crypto.cc b/src/auth/Crypto.cc
index 102c8d2..26b7b5c 100644
--- a/src/auth/Crypto.cc
+++ b/src/auth/Crypto.cc
@@ -107,7 +107,7 @@ public:
   int decrypt(bufferptr& secret, const bufferlist& in, bufferlist& out);
 };
 
-static const unsigned char *aes_iv = CEPH_AES_IV;
+static const unsigned char *aes_iv = (const unsigned char *)CEPH_AES_IV;
 
 int CryptoAES::create(bufferptr& secret)
 {
-- 
1.7.0.4


--=-PCMg5KetEQVIyiTYjc80--

