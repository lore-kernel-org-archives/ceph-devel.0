From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 07/10] perf_counters.cc: remove twice included header files
Date: Mon,  4 Feb 2013 17:54:06 +0100
Message-ID: <1359996849-26302-8-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58038 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756584Ab3BDQyQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:54:16 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included "global/global_init.h" and
"common/ceph_context.h".

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/test/perf_counters.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/test/perf_counters.cc b/src/test/perf_counters.cc
index e5090d2..d8f04ca 100644
--- a/src/test/perf_counters.cc
+++ b/src/test/perf_counters.cc
@@ -43,9 +43,7 @@
 #include <time.h>
 #include <unistd.h>
 
-#include "global/global_init.h"
 #include "common/common_init.h"
-#include "common/ceph_context.h"
 
 int main(int argc, char **argv) {
   std::vector<const char *> preargs;
-- 
1.8.1.2

