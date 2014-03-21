From: Jon Mason <jon.mason@intel.com>
Subject: [PATCH] README: Add missing "install"
Date: Fri, 21 Mar 2014 10:26:24 -0700
Message-ID: <1395422784-13443-1-git-send-email-jon.mason@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54170 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbaCUR11 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 21 Mar 2014 13:27:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In the section describing how to build packages for Debian, the command
given to install dpkg-dev is incomplete.  "install" is needed for the
command to execute as desired.

Signed-off-by: Jon Mason <jon.mason@intel.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 197a7bf..825e932 100644
--- a/README
+++ b/README
@@ -58,7 +58,7 @@ Building packages
 You can build packages for Debian or Debian-derived (e.g., Ubuntu)
 systems with
 
-$ sudo apt-get dpkg-dev
+$ sudo apt-get install dpkg-dev
 $ dpkg-checkbuilddeps        # make sure we have all dependencies
 $ dpkg-buildpackage
 
-- 
1.8.3.2

