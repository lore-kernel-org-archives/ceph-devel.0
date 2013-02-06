From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 2/8] ceph_crypto.cc: remove unused shutdown() outside crypto ifdef's
Date: Wed,  6 Feb 2013 12:02:45 +0100
Message-ID: <1360148571-6984-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:32976 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757359Ab3BFLC4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 06:02:56 -0500
In-Reply-To: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Gary Lowell <gary.lowell@inktank.com>

Fix "out-of-line declaration of a member must be a definition
[-Wout-of-line-declaration]". Remove ceph::crypto::shutdown() outside
the crypto related ifdef's. Without nss or cryptopp configure will
fail anyways.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/ceph_crypto.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/common/ceph_crypto.cc b/src/common/ceph_crypto.cc
index 3f04349..96fa157 100644
--- a/src/common/ceph_crypto.cc
+++ b/src/common/ceph_crypto.cc
@@ -20,7 +20,6 @@
 #include <pthread.h>
 #include <stdlib.h>
 
-void ceph::crypto::shutdown();
 
 #ifdef USE_CRYPTOPP
 void ceph::crypto::init(CephContext *cct)
-- 
1.8.1.2

