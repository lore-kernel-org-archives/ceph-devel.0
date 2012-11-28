From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 16/30] mds/Migrator.cc: remove twice included Migrator.h
Date: Wed, 28 Nov 2012 13:57:24 +0100
Message-ID: <1354107458-30941-17-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34587 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754744Ab2K1NAC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:00:02 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included Migrator.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/mds/Migrator.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 9829d68..b66b54c 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -19,7 +19,6 @@
 #include "CDentry.h"
 #include "Migrator.h"
 #include "Locker.h"
-#include "Migrator.h"
 #include "Server.h"
 
 #include "MDBalancer.h"
-- 
1.8.0

