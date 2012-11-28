From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 25/30] osd/OSD.h: remove twice included OpRequest.h
Date: Wed, 28 Nov 2012 13:57:33 +0100
Message-ID: <1354107458-30941-26-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34646 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755059Ab2K1NAr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:00:47 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included OpRequest.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/osd/OSD.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/osd/OSD.h b/src/osd/OSD.h
index ff277e1..ab6e3ac 100644
--- a/src/osd/OSD.h
+++ b/src/osd/OSD.h
@@ -49,7 +49,6 @@ using namespace std;
 #include <ext/hash_set>
 using namespace __gnu_cxx;
 
-#include "OpRequest.h"
 #include "common/shared_cache.hpp"
 #include "common/simple_cache.hpp"
 #include "common/sharedptr_registry.hpp"
-- 
1.8.0

