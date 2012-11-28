From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 13/30] include/buffer.h: remove twice included stdio.h
Date: Wed, 28 Nov 2012 13:57:21 +0100
Message-ID: <1354107458-30941-14-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34526 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754588Ab2K1M6j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 07:58:39 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included stdio.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/include/buffer.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/include/buffer.h b/src/include/buffer.h
index 4a9e96c..9a635bd 100644
--- a/src/include/buffer.h
+++ b/src/include/buffer.h
@@ -46,7 +46,6 @@ void	*valloc(size_t);
 #endif
 
 #include <stdint.h>
-#include <stdio.h>	// snprintf
 #include <string.h>
 
 #ifndef __CYGWIN__
-- 
1.8.0

