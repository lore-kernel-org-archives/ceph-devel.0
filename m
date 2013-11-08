From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: [PATCH] Throttle: Fix indention
Date: Fri,  8 Nov 2013 15:32:33 +0800
Message-ID: <1383895953-583-1-git-send-email-lantianyu1986@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:63431 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab3KHHqj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Nov 2013 02:46:39 -0500
Received: by mail-pd0-f175.google.com with SMTP id g10so1799617pdj.34
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 23:46:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Lan Tianyu <lantianyu1986@gmail.com>

Fix indention.

Signed-off-by: Lan Tianyu <lantianyu1986@gmail.com>
---
 src/common/Throttle.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/Throttle.h b/src/common/Throttle.h
index 6d03988..f261ee0 100644
--- a/src/common/Throttle.h
+++ b/src/common/Throttle.h
@@ -16,7 +16,7 @@ class Throttle {
   CephContext *cct;
   std::string name;
   PerfCounters *logger;
-	ceph::atomic_t count, max;
+  ceph::atomic_t count, max;
   Mutex lock;
   list<Cond*> cond;
   bool use_perf;
-- 
1.7.9.5

