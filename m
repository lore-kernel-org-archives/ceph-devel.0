From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 11/30] crushtool.cc: remove twice included sys/stat.h
Date: Wed, 28 Nov 2012 13:57:19 +0100
Message-ID: <1354107458-30941-12-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34815 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754943Ab2K1NEO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:04:14 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included sys/stat.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/crushtool.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/crushtool.cc b/src/crushtool.cc
index 271cd15..0f54852 100644
--- a/src/crushtool.cc
+++ b/src/crushtool.cc
@@ -17,8 +17,6 @@
 #include <fcntl.h>
 #include <errno.h>
 
-#include <sys/stat.h>
-
 #include <fstream>
 
 #include "common/debug.h"
-- 
1.8.0

