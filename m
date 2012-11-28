From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 06/30] ceph_syn.cc: remove twice included sys/stat.h
Date: Wed, 28 Nov 2012 13:57:14 +0100
Message-ID: <1354107458-30941-7-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34455 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754640Ab2K1M5l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 07:57:41 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included sys/stat.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/ceph_syn.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/ceph_syn.cc b/src/ceph_syn.cc
index a087e9f..8ffe40a 100644
--- a/src/ceph_syn.cc
+++ b/src/ceph_syn.cc
@@ -36,7 +36,6 @@ using namespace std;
 #endif // DARWIN || __FreeBSD__
 
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <fcntl.h>
 
 extern int syn_filer_flags;
-- 
1.8.0

