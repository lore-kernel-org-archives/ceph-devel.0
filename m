From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 1/6] src/java/Makefile.am: fix default java dir
Date: Fri,  4 Jan 2013 18:51:26 +0100
Message-ID: <1357321891-20202-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:54165 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753949Ab3ADRvf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 12:51:35 -0500
In-Reply-To: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix default javadir in src/java/Makefile.am to $(datadir)/java
since this is the common data dir for java files.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/java/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/java/Makefile.am b/src/java/Makefile.am
index 55ff6c1..1f87885 100644
--- a/src/java/Makefile.am
+++ b/src/java/Makefile.am
@@ -43,7 +43,7 @@ $(JAVA_H): $(CEPH_PROXY)
 libcephfs.jar: $(CEPH_PROXY)
 	$(JAR) cf $@ $(JAVA_CLASSES:%=-C java %) 
 
-javadir = $(libdir)
+javadir = $(datadir)/java
 java_DATA = libcephfs.jar
 
 CLEANFILES = -rf java/com/ceph/fs/*.class $(JAVA_H) libcephfs.jar 
-- 
1.8.0.2

