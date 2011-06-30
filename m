From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] obsync: Depend on python-lxml on Debian derived platforms
Date: Thu, 30 Jun 2011 13:07:12 +0200
Message-ID: <1309432032-12859-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:57409 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab1F3LHR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2011 07:07:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 debian/control |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/debian/control b/debian/control
index aba948c..612870b 100644
--- a/debian/control
+++ b/debian/control
@@ -289,7 +289,7 @@ Description: debugging symbols for radosgw
 
 Package: obsync
 Architecture: linux-any
-Depends: ${misc:Depends}, python, python-boto, python-ceph, python-xattr
+Depends: ${misc:Depends}, python, python-boto, python-ceph, python-xattr, python-lxml
 Description: synchronize data between cloud object storage providers or a local directory
  obsync is a tool to synchronize objects between cloud object
  storage providers, such as Amazon S3 (or compatible services), a
-- 
1.7.0.4

