From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 30/30] tools/common.cc: remove twice included headers
Date: Wed, 28 Nov 2012 13:57:38 +0100
Message-ID: <1354107458-30941-31-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34643 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754901Ab2K1NAp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:00:45 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Cleanup includes: Remove twice included  sys/stat.h and  osd/OSDMap.h.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/tools/common.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/tools/common.cc b/src/tools/common.cc
index c500568..9a454f7 100644
--- a/src/tools/common.cc
+++ b/src/tools/common.cc
@@ -23,7 +23,6 @@ using namespace std;
 
 #include <memory>
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <fcntl.h>
 
 extern "C" {
@@ -81,7 +80,6 @@ float tick_interval = 3.0;
 
 // observe (push)
 #include "mon/PGMap.h"
-#include "osd/OSDMap.h"
 #include "mds/MDSMap.h"
 #include "common/LogEntry.h"
 
-- 
1.8.0

