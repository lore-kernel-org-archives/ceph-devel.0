From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 04/10] test_idempotent.cc: remove twice included "os/FileStore.h"
Date: Mon,  4 Feb 2013 17:54:03 +0100
Message-ID: <1359996849-26302-5-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58030 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756080Ab3BDQyP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:54:15 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included "os/FileStore.h".

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/test/filestore/test_idempotent.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/test/filestore/test_idempotent.cc b/src/test/filestore/test_idempotent.cc
index f49aded..6c13861 100644
--- a/src/test/filestore/test_idempotent.cc
+++ b/src/test/filestore/test_idempotent.cc
@@ -24,7 +24,6 @@
 #include "os/LevelDBStore.h"
 #include "os/KeyValueDB.h"
 #include "os/ObjectStore.h"
-#include "os/FileStore.h"
 
 void usage(const string &name) {
   std::cerr << "Usage: " << name << " [new|continue] store_path store_journal db_path"
-- 
1.8.1.2

