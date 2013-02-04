From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 09/10] ceph-filestore-dump.cc: remove twice included <iostream>
Date: Mon,  4 Feb 2013 17:54:08 +0100
Message-ID: <1359996849-26302-10-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58034 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755987Ab3BDQyP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:54:15 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included <iostream>.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/tools/ceph-filestore-dump.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/tools/ceph-filestore-dump.cc b/src/tools/ceph-filestore-dump.cc
index 224ef32..2dfa1e5 100644
--- a/src/tools/ceph-filestore-dump.cc
+++ b/src/tools/ceph-filestore-dump.cc
@@ -24,7 +24,6 @@
 #include <sstream>
 #include <stdlib.h>
 #include <fstream>
-#include <iostream>
 
 #include "common/Formatter.h"
 
-- 
1.8.1.2

