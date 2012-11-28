From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 20/30] mon/Monitor.cc: remove twice included osd/OSDMap.h
Date: Wed, 28 Nov 2012 13:57:28 +0100
Message-ID: <1354107458-30941-21-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34830 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932080Ab2K1NEU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:04:20 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included osd/OSDMap.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/mon/Monitor.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/mon/Monitor.cc b/src/mon/Monitor.cc
index 79f2577..b819fce 100644
--- a/src/mon/Monitor.cc
+++ b/src/mon/Monitor.cc
@@ -65,8 +65,6 @@
 #include "LogMonitor.h"
 #include "AuthMonitor.h"
 
-#include "osd/OSDMap.h"
-
 #include "auth/AuthMethodList.h"
 #include "auth/KeyRing.h"
 
-- 
1.8.0

