From: Stefan Priebe <s.priebe@profihost.ag>
Subject: [PATCH] allow also curl openssl binding
Date: Thu, 15 Aug 2013 11:30:01 +0200
Message-ID: <1376559001-28477-1-git-send-email-s.priebe@profihost.ag>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from packetbuilder64bit.de-nserver.de ([85.158.179.228]:46387 "EHLO
	packetbuilder64bit.de-nserver.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752776Ab3HOJaJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Aug 2013 05:30:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Stefan Priebe <s.priebe@profihost.ag>

---
 debian/control |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/control b/debian/control
index b39579f..957727d 100644
--- a/debian/control
+++ b/debian/control
@@ -20,7 +20,7 @@ Build-Depends: autoconf,
                libboost-program-options-dev (>= 1.42),
                libboost-thread-dev (>= 1.42),
                libboost-system-dev (>= 1.42),
-               libcurl4-gnutls-dev,
+               libcurl4-gnutls-dev | libcurl4-openssl-dev,
                libedit-dev,
                libexpat1-dev,
                libfcgi-dev,
-- 
1.7.10.4

