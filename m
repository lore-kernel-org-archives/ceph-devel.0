From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] doc: Correct Git URL for clone
Date: Thu,  2 Aug 2012 12:48:26 +0200
Message-ID: <1343904506-3633-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:58392 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab2HBKsc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 06:48:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 doc/source/clone-source.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/source/clone-source.rst b/doc/source/clone-source.rst
index e2bc95d..2236b37 100644
--- a/doc/source/clone-source.rst
+++ b/doc/source/clone-source.rst
@@ -9,7 +9,7 @@ Clone the Source
 ----------------
 To clone the Ceph source code repository, execute::
 
-	git clone git@github.com:ceph/ceph.git
+	git clone git://github.com/ceph/ceph.git
 
 Once ``git clone`` executes, you should have a full copy of the Ceph 
 repository.
-- 
1.7.9.5

