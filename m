From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] radosgw: Remove PHP setting from VirtualHost documentation
Date: Thu,  7 Apr 2011 12:23:34 +0200
Message-ID: <1302171814-7959-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:32895 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab1DGKZL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 06:25:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 man/radosgw.8 |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/man/radosgw.8 b/man/radosgw.8
index 3eab509..316f5f2 100644
--- a/man/radosgw.8
+++ b/man/radosgw.8
@@ -33,7 +33,6 @@ An apache example configuration for using the RADOS gateway:
 
   <IfModule mod_fcgid.c>
     SuexecUserGroup web1 web1
-    PHP_Fix_Pathinfo_Enable 1
     <Directory /var/www/web1/web/>
       Options +ExecCGI
       AllowOverride All
-- 
1.7.0.4

