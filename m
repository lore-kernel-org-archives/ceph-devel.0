From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: select CRYPTO_CBC in addition to CRYPTO_AES
Date: Fri,  5 Sep 2014 20:32:14 +0400
Message-ID: <1409934734-9010-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:43544 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbaIEQcS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Sep 2014 12:32:18 -0400
Received: by mail-la0-f50.google.com with SMTP id mc6so14311042lab.9
        for <ceph-devel@vger.kernel.org>; Fri, 05 Sep 2014 09:32:17 -0700 (PDT)
Received: from localhost ([109.110.66.113])
        by mx.google.com with ESMTPSA id cq4sm849326lad.10.2014.09.05.09.32.15
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 09:32:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We want "cbc(aes)" algorithm, so select CRYPTO_CBC too, not just
CRYPTO_AES.  Otherwise on !CRYPTO_CBC kernels we fail rbd map/mount
with

    libceph: error -2 building auth method x request

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/Kconfig b/net/ceph/Kconfig
index e50cc69ae8ca..f8cceb99e732 100644
--- a/net/ceph/Kconfig
+++ b/net/ceph/Kconfig
@@ -3,6 +3,7 @@ config CEPH_LIB
 	depends on INET
 	select LIBCRC32C
 	select CRYPTO_AES
+	select CRYPTO_CBC
 	select CRYPTO
 	select KEYS
 	default n
-- 
1.7.10.4

