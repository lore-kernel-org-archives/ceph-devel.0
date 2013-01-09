From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] osd/ReplicatedPG.cc: fix errors in _scrub()
Date: Wed,  9 Jan 2013 22:22:47 +0100
Message-ID: <1357766567-26286-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:50745 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933371Ab3AIVWu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 16:22:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Samuel Just <sam.just@inktank.com>

Fix build error introduced with 5b12b514b047a8a46cc5549bd94b398289b9b5f6:

osd/ReplicatedPG.cc: In member function 'virtual void ReplicatedPG::_scrub(ScrubMap&)':
osd/ReplicatedPG.cc:7116:4: error: 'errors' was not declared in this scope

Increment scrubber.errors instead of errors.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/osd/ReplicatedPG.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index e8a68fe..1645041 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -7113,7 +7113,7 @@ void ReplicatedPG::_scrub(ScrubMap& scrubmap)
       if (head == hobject_t()) {
 	osd->clog.error() << mode << " " << info.pgid << " " << soid
 			  << " found clone without head";
-	++errors;
+	++scrubber.errors;
 	continue;
       }
 
-- 
1.8.1

