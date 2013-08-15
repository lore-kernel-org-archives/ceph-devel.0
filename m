From: Stefan Priebe <s.priebe@profihost.ag>
Subject: [PATCH] debian/control libgoogle-perftools-dev (>= 2.0-2)
Date: Thu, 15 Aug 2013 11:30:19 +0200
Message-ID: <1376559019-28564-1-git-send-email-s.priebe@profihost.ag>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from packetbuilder64bit.de-nserver.de ([85.158.179.228]:46083 "EHLO
	packetbuilder64bit.de-nserver.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892Ab3HOJa0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Aug 2013 05:30:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Stefan Priebe <s.priebe@profihost.ag>

---
 debian/control |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/control b/debian/control
index 5c14ebb..b39579f 100644
--- a/debian/control
+++ b/debian/control
@@ -25,7 +25,7 @@ Build-Depends: autoconf,
                libexpat1-dev,
                libfcgi-dev,
                libfuse-dev,
-               libgoogle-perftools-dev [i386 amd64],
+               libgoogle-perftools-dev (>= 2.0-2) [i386 amd64],
                libkeyutils-dev,
                libleveldb-dev,
                libnss3-dev,
-- 
1.7.10.4

