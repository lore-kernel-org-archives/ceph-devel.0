From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 22/30] os/DBObjectMap.cc: remove twice included headers
Date: Wed, 28 Nov 2012 13:57:30 +0100
Message-ID: <1354107458-30941-23-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34785 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754597Ab2K1NDe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:03:34 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included <string> and <tr1/memory>

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/os/DBObjectMap.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/os/DBObjectMap.cc b/src/os/DBObjectMap.cc
index 83b746d..10b7b70 100644
--- a/src/os/DBObjectMap.cc
+++ b/src/os/DBObjectMap.cc
@@ -8,9 +8,7 @@
 #include <string>
 #include <tr1/memory>
 
-#include <string>
 #include <vector>
-#include <tr1/memory>
 
 #include "ObjectMap.h"
 #include "KeyValueDB.h"
-- 
1.8.0

