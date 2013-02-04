From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 10/10] xattr_bench.cc: remove twice included <time.h>
Date: Mon,  4 Feb 2013 17:54:09 +0100
Message-ID: <1359996849-26302-11-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58366 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753975Ab3BDQ6v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:58:51 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included <time.h>.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/test/xattr_bench.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/test/xattr_bench.cc b/src/test/xattr_bench.cc
index 3a4b423..d212f55 100644
--- a/src/test/xattr_bench.cc
+++ b/src/test/xattr_bench.cc
@@ -17,7 +17,6 @@
 #include <string.h>
 #include <iostream>
 #include <sstream>
-#include <time.h>
 #include "os/FileStore.h"
 #include "include/Context.h"
 #include "common/ceph_argparse.h"
-- 
1.8.1.2

