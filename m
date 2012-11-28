From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 17/30] mds/Resetter.h: remove twice included msg/Messenger.h
Date: Wed, 28 Nov 2012 13:57:25 +0100
Message-ID: <1354107458-30941-18-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34597 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754931Ab2K1NAE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:00:04 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included msg/Messenger.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/mds/Resetter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/mds/Resetter.h b/src/mds/Resetter.h
index 663dde1..b3bc067 100644
--- a/src/mds/Resetter.h
+++ b/src/mds/Resetter.h
@@ -19,7 +19,6 @@
 #include "osdc/Journaler.h"
 #include "msg/Dispatcher.h"
 #include "msg/Messenger.h"
-#include "msg/Messenger.h"
 #include "auth/Auth.h"
 
 /**
-- 
1.8.0

