From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] include/atomic.h: add stdlib.h for size_t
Date: Tue, 11 Dec 2012 14:05:08 +0100
Message-ID: <1355231108-18168-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:42894 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752972Ab2LKNFN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 08:05:13 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Include missing stdlib.h needed for size_t.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/include/atomic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/include/atomic.h b/src/include/atomic.h
index 0c22b26..3ecbd28 100644
--- a/src/include/atomic.h
+++ b/src/include/atomic.h
@@ -20,6 +20,8 @@
 # include "acconfig.h"
 #endif
 
+#include <stdlib.h>
+
 #ifndef NO_ATOMIC_OPS
 
 // libatomic_ops implementation
-- 
1.8.0.1

