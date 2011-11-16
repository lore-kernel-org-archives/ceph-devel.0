From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] debian init: Do not stop or start daemons when installing or upgrading
Date: Wed, 16 Nov 2011 20:41:15 +0100
Message-ID: <1321472475-19115-2-git-send-email-wido@widodh.nl>
References: <1321472475-19115-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:36321 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1KPTuK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2011 14:50:10 -0500
In-Reply-To: <1321472475-19115-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 debian/rules |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/debian/rules b/debian/rules
index a20258d..4f3fe62 100755
--- a/debian/rules
+++ b/debian/rules
@@ -98,7 +98,7 @@ binary-arch: build install
 	dh_installexamples
 	dh_install --sourcedir=$(DESTDIR) --list-missing
 	dh_installlogrotate
-	dh_installinit
+	dh_installinit --no-start
 	dh_installman
 	dh_lintian
 	dh_link
-- 
1.7.5.4

