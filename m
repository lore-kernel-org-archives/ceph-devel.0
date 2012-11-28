From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 29/30] rgw/rgw_rest.cc: remove twice included rgw_formats.h
Date: Wed, 28 Nov 2012 13:57:37 +0100
Message-ID: <1354107458-30941-30-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34809 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754935Ab2K1NEL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:04:11 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Cleanup includes: Remove twice included rgw_formats.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/rgw/rgw_rest.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/rgw/rgw_rest.cc b/src/rgw/rgw_rest.cc
index 99eb090..9d978d1 100644
--- a/src/rgw/rgw_rest.cc
+++ b/src/rgw/rgw_rest.cc
@@ -12,8 +12,6 @@
 #include "rgw_rest_s3.h"
 #include "rgw_swift_auth.h"
 
-#include "rgw_formats.h"
-
 #include "rgw_client_io.h"
 #include "rgw_resolve.h"
 
-- 
1.8.0

