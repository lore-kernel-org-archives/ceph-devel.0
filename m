From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 26/30] osdmaptool.cc: remove twice included sys/stat.h
Date: Wed, 28 Nov 2012 13:57:34 +0100
Message-ID: <1354107458-30941-27-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34728 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754791Ab2K1NCI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:02:08 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included sys/stat.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/osdmaptool.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/osdmaptool.cc b/src/osdmaptool.cc
index c28926b..d367c36 100644
--- a/src/osdmaptool.cc
+++ b/src/osdmaptool.cc
@@ -17,7 +17,6 @@
 #include <fcntl.h>
 #include <errno.h>
 
-#include <sys/stat.h>
 #include <iostream>
 #include <string>
 using namespace std;
-- 
1.8.0

