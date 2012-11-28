From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 27/30] rados.cc: remove twice included headers
Date: Wed, 28 Nov 2012 13:57:35 +0100
Message-ID: <1354107458-30941-28-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34758 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754791Ab2K1NCs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:02:48 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included common/obj_bencher.h and
common/errno.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/rados.cc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/rados.cc b/src/rados.cc
index b06f703..a870255 100644
--- a/src/rados.cc
+++ b/src/rados.cc
@@ -18,8 +18,6 @@
 #include "rados_sync.h"
 using namespace librados;
 
-#include "common/obj_bencher.h"
-
 #include "common/config.h"
 #include "common/ceph_argparse.h"
 #include "global/global_init.h"
@@ -42,8 +40,6 @@ using namespace librados;
 #include <climits>
 #include <locale>
 
-#include "common/errno.h"
-
 #include "cls/lock/cls_lock_client.h"
 
 int rados_tool_sync(const std::map < std::string, std::string > &opts,
-- 
1.8.0

