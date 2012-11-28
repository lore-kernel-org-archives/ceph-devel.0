From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 18/30] mds/journal.cc: remove twice included common/config.h
Date: Wed, 28 Nov 2012 13:57:26 +0100
Message-ID: <1354107458-30941-19-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34827 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755129Ab2K1NET (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:04:19 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included common/config.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/mds/journal.cc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 04b1a92..46adbf2 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -51,9 +51,6 @@
 
 #include "Locker.h"
 
-
-#include "common/config.h"
-
 #define dout_subsys ceph_subsys_mds
 #undef DOUT_COND
 #define DOUT_COND(cct, l) (l<=cct->_conf->debug_mds || l <= cct->_conf->debug_mds_log \
-- 
1.8.0

