From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 01/10] MDS.cc: remove twice included common/errno.h
Date: Mon,  4 Feb 2013 17:54:00 +0100
Message-ID: <1359996849-26302-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58013 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755987Ab3BDQyO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:54:14 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included common/errno.h.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/mds/MDS.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index 4153417..0dd3f1b 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -73,7 +73,6 @@
 #include "auth/KeyRing.h"
 
 #include "common/config.h"
-#include "common/errno.h"
 
 #include "perfglue/cpu_profiler.h"
 #include "perfglue/heap_profiler.h"
-- 
1.8.1.2

