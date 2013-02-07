From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 09/15] src/mon/PGMonitor.cc: remove unused variable
Date: Thu,  7 Feb 2013 20:41:57 +0100
Message-ID: <1360266123-28972-10-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33780 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932176Ab3BGTmI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:42:08 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Remove unused variable to fix:

mon/PGMonitor.cc:170:11: warning: unused variable 'now'
  [-Wunused-variable]

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/mon/PGMonitor.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/mon/PGMonitor.cc b/src/mon/PGMonitor.cc
index 7e9b83b..f34ffb8 100644
--- a/src/mon/PGMonitor.cc
+++ b/src/mon/PGMonitor.cc
@@ -167,7 +167,6 @@ void PGMonitor::update_from_paxos()
   } 
 
   // walk through incrementals
-  utime_t now(ceph_clock_now(g_ceph_context));
   while (paxosv > pg_map.version) {
     bufferlist bl;
     bool success = paxos->read(pg_map.version+1, bl);
-- 
1.8.1.2

