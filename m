From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 21/30] mount/canonicalize.c: remove twice included string.h
Date: Wed, 28 Nov 2012 13:57:29 +0100
Message-ID: <1354107458-30941-22-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34821 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755092Ab2K1NEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:04:16 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included string.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/mount/canonicalize.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/mount/canonicalize.c b/src/mount/canonicalize.c
index c3bdb38..7561e41 100644
--- a/src/mount/canonicalize.c
+++ b/src/mount/canonicalize.c
@@ -24,7 +24,6 @@
 #include <string.h>
 #include <ctype.h>
 #include <unistd.h>
-#include <string.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <limits.h>
-- 
1.8.0

