From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 03/10] tp_bench.cc: remove twice included <iostream>
Date: Mon,  4 Feb 2013 17:54:02 +0100
Message-ID: <1359996849-26302-4-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58021 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756214Ab3BDQyO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:54:14 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included <iostream>.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/test/bench/tp_bench.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/test/bench/tp_bench.cc b/src/test/bench/tp_bench.cc
index daee790..31a4db3 100644
--- a/src/test/bench/tp_bench.cc
+++ b/src/test/bench/tp_bench.cc
@@ -12,7 +12,6 @@
 #include <sstream>
 #include <stdlib.h>
 #include <fstream>
-#include <iostream>
 
 #include "common/Formatter.h"
 
-- 
1.8.1.2

