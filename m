From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 06/10] testxattr.cc: remove twice included <iostream>
Date: Mon,  4 Feb 2013 17:54:05 +0100
Message-ID: <1359996849-26302-7-git-send-email-danny.al-gaaf@bisect.de>
References: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58009 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756061Ab3BDQyO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:54:14 -0500
In-Reply-To: <1359996849-26302-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup includes, remove twice included <iostream>.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/test/old/testxattr.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/test/old/testxattr.cc b/src/test/old/testxattr.cc
index 65bb4b1..b1ef126 100644
--- a/src/test/old/testxattr.cc
+++ b/src/test/old/testxattr.cc
@@ -9,7 +9,6 @@ using namespace std;
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <sys/file.h>
-#include <iostream>
 #include <errno.h>
 #include <dirent.h>
 #include <sys/xattr.h>
-- 
1.8.1.2

