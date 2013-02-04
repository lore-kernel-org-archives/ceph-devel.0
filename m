From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 05/10] workload_generator.cc: remove twice included "common/debug.h"
Date: Mon,  4 Feb 2013 17:54:04 +0100
Message-ID: <1359996849-26302-6-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58014 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756155Ab3BDQyO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:54:14 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included "common/debug.h"

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/test/filestore/workload_generator.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/test/filestore/workload_generator.cc b/src/test/filestore/workload_generator.cc
index f97bc66..5d7b813 100644
--- a/src/test/filestore/workload_generator.cc
+++ b/src/test/filestore/workload_generator.cc
@@ -27,7 +27,6 @@
 #include <boost/scoped_ptr.hpp>
 #include <boost/lexical_cast.hpp>
 #include "workload_generator.h"
-#include "common/debug.h"
 #include "include/assert.h"
 
 #include "TestFileStoreState.h"
-- 
1.8.1.2

