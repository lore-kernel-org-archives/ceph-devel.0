From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 08/10] testmsgr.cc: remove twice included <sys/stat.h>
Date: Mon,  4 Feb 2013 17:54:07 +0100
Message-ID: <1359996849-26302-9-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58025 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756223Ab3BDQyP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:54:15 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included <sys/stat.h>.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/testmsgr.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/testmsgr.cc b/src/testmsgr.cc
index eb716b9..4de779b 100644
--- a/src/testmsgr.cc
+++ b/src/testmsgr.cc
@@ -33,7 +33,6 @@ using namespace std;
 #endif // DARWIN
 
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <fcntl.h>
 
 #define dout_subsys ceph_subsys_ms
-- 
1.8.1.2

