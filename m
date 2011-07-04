From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: [PATCH] Move stat/*.log to the end of logrotate.conf
Date: Mon, 4 Jul 2011 13:14:11 -0300
Message-ID: <ory60e3se2.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:45929 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757985Ab1GDRKf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 13:10:35 -0400
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p64Gl2HY010421
	for <ceph-devel@vger.kernel.org>; Mon, 4 Jul 2011 13:47:03 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p64Gl21H017063
	for <ceph-devel@vger.kernel.org>; Mon, 4 Jul 2011 13:47:02 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Logrotate ignores entries after a rule that doesn't match any files.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/logrotate.conf |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/logrotate.conf b/src/logrotate.conf
index 14bc02c..a4fb73f 100644
--- a/src/logrotate.conf
+++ b/src/logrotate.conf
@@ -1,12 +1,3 @@
-# Separate stat/*.log into a different rule because sometimes
-# it doesn't exist, and logrotate will ignore the entire rule
-# if any part of the file list isn't found.
-/var/log/ceph/stat/*.log {
-    rotate 7
-    daily
-    compress
-}
-
 /var/log/ceph/*.log {
     rotate 7
     daily
@@ -16,3 +7,13 @@
         invoke-rc.d ceph reload >/dev/null || service ceph reload >/dev/null
     endscript
 }
+
+# Separate stat/*.log into a different rule because sometimes
+# it doesn't exist, and logrotate will ignore the entire rule
+# and the remainder of the file if any part of the file list
+# isn't found.
+/var/log/ceph/stat/*.log {
+    rotate 7
+    daily
+    compress
+}
-- 
1.7.4.4

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
