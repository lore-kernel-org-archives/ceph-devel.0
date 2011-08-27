From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] FileJournal: Also classify kernel major version 3 as safe with disk-cache on
Date: Sat, 27 Aug 2011 22:37:05 +0200
Message-ID: <1314477425-29392-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:52085 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab1H0Upm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Aug 2011 16:45:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/os/FileJournal.cc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
index ee661d6..ddc423b 100644
--- a/src/os/FileJournal.cc
+++ b/src/os/FileJournal.cc
@@ -238,7 +238,7 @@ void FileJournal::_check_disk_write_cache() const
       dout(10) << "_check_disk_write_cache: failed to get kernel version."
 	       << dendl;
     }
-    else if (a >= 2 && b >= 6 && c >= 33) {
+    else if (a >= 2 && b >= 6 && c >= 33 || a >= 3) {
       dout(20) << "_check_disk_write_cache: disk write cache is on, but your "
 	       << "kernel is new enough to handle it correctly. (fn:"
 	       << fn << ")" << dendl;
-- 
1.7.5.4

