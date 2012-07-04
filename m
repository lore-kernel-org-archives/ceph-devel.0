From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] librados: Bump the version to 0.48
Date: Wed,  4 Jul 2012 15:46:04 +0200
Message-ID: <1341409564-26660-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:53849 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab2GDNqJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 09:46:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/include/rados/librados.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
index 9f723f7..4870b0f 100644
--- a/src/include/rados/librados.h
+++ b/src/include/rados/librados.h
@@ -23,7 +23,7 @@ extern "C" {
 #endif
 
 #define LIBRADOS_VER_MAJOR 0
-#define LIBRADOS_VER_MINOR 44
+#define LIBRADOS_VER_MINOR 48
 #define LIBRADOS_VER_EXTRA 0
 
 #define LIBRADOS_VERSION(maj, min, extra) ((maj << 16) + (min << 8) + extra)
-- 
1.7.9.5

