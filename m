From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 08/30] client/MetaRequest.cc: remove twice included client/Dentry.h
Date: Wed, 28 Nov 2012 13:57:16 +0100
Message-ID: <1354107458-30941-9-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34464 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754674Ab2K1M5l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 07:57:41 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included client/Dentry.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/client/MetaRequest.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/client/MetaRequest.cc b/src/client/MetaRequest.cc
index 205e201..2c50f06 100644
--- a/src/client/MetaRequest.cc
+++ b/src/client/MetaRequest.cc
@@ -5,7 +5,6 @@
 #include "client/MetaRequest.h"
 #include "client/Dentry.h"
 #include "client/Inode.h"
-#include "client/Dentry.h"
 #include "messages/MClientReply.h"
 #include "common/Formatter.h"
 
-- 
1.8.0

