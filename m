From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 24/30] os/IndexManager.cc: remove twice included FlatIndex.h
Date: Wed, 28 Nov 2012 13:57:32 +0100
Message-ID: <1354107458-30941-25-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34697 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754791Ab2K1NB1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:01:27 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included FlatIndex.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/os/IndexManager.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/os/IndexManager.cc b/src/os/IndexManager.cc
index 2165036..85281c4 100644
--- a/src/os/IndexManager.cc
+++ b/src/os/IndexManager.cc
@@ -30,7 +30,6 @@
 #include "IndexManager.h"
 #include "FlatIndex.h"
 #include "HashIndex.h"
-#include "FlatIndex.h"
 #include "CollectionIndex.h"
 
 #include "chain_xattr.h"
-- 
1.8.0

